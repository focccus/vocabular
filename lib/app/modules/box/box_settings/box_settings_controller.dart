import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/options_repository.dart';

part 'box_settings_controller.g.dart';

class BoxSettingsController = _BoxSettingsControllerBase
    with _$BoxSettingsController;

abstract class _BoxSettingsControllerBase with Store {
  int boxID;

  final BoxRepository storage;
  final OptionsRepository optionsRepo;

  _BoxSettingsControllerBase(this.storage, this.optionsRepo);

  Box box;

  @observable
  List<String> langs = ['DE', 'EN', 'LA'];

  Future loadBox(int id) async {
    if (id == null) return;
    boxID = id;
    box = await storage.getBoxByID(boxID);

    if (box != null) {
      langs = (await optionsRepo.getOption('langs')).cast<String>();

      hasFormen = box.hasFormen ?? false;
      compartments = 5;
      goback = box.goback;
      lang = box.lang;
      mustType = box.mustType;
      random = box.random;
      askForeign = box.askForeign ?? false;
      testCount = (box.testCount ?? -1) > 0 ? box.testCount : box.vocabCount;
      isLoading = false;
      compartments = box.compartments.length;
    }
  }

  @observable
  String lang;

  @observable
  bool isLoading = true;

  @action
  void setLang(String l) {
    lang = l;
  }

  @observable
  String errorMessage;

  @observable
  bool hasFormen;

  @observable
  int compartments;

  @observable
  int goback;

  @observable
  bool mustType;

  @observable
  bool random;

  @observable
  bool askForeign;

  @computed
  List<bool> get askLang => askForeign ? [false, true] : [true, false];

  @observable
  int testCount;

  @action
  Future delete() async {
    return storage.deleteBox(boxID);
  }

  @action
  void setCompartments(double v) {
    compartments = v.toInt();
    if (goback >= v) goback = v.toInt() - 1;
  }

  @action
  Future<bool> save(String title) async {
    var newCompartments = box.compartments;
    final oldLength = box.compartments.length;

    if (compartments > box.compartments.length) {
      newCompartments = List.from([
        ...List<List<VocabCard>>.generate(
            compartments - oldLength, (index) => <VocabCard>[]),
        ...box.compartments,
      ]);
    } else if (compartments < box.compartments.length) {
      final leftover = List.from(box.compartments.first);
      for (var i = 1; i < oldLength - compartments; i++) {
        if (box.compartments[i].isNotEmpty) {
          leftover.addAll(box.compartments[i]);
        }
      }
      newCompartments =
          List.from(box.compartments.sublist(oldLength - compartments));
    }

    try {
      box = box.copyWith(
        title: title,
        hasFormen: hasFormen,
        lang: lang,
        mustType: mustType,
        goback: goback,
        random: random,
        askForeign: askForeign,
        compartments: newCompartments,
        testCount: testCount < box.vocabCount ? testCount : -1,
      );
      await storage.saveBox(box, box.id);
      return true;
    } catch (e) {
      errorMessage = 'An error while saving occured! Please try again';
    }
    return false;
  }
}
