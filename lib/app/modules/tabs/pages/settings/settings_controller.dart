import 'package:flutter_modular/flutter_modular.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/repositories/options_repository.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  OptionsRepository repo;

  _SettingsControllerBase(this.repo);

  @observable
  ObservableList<String> langs;
  @observable
  String grades = 'de';

  @observable
  bool isLoading = true;

  @action
  void addLang(String lang) {
    if (!langs.contains(lang)) {
      langs.add(lang);
      repo.saveOption('langs', langs.toList());
    }
  }

  final gradingOptions = ['us', 'de', 'ob'];

  @action
  void setGrade(String grade) {
    if (gradingOptions.contains(grade)) {
      grades = grade;
      repo.saveOption('grades', grade);
    }
  }

  @action
  void removeLang(String lang) {
    langs.remove(lang);
    repo.saveOption('langs', langs.toList());
  }

  Future<bool> checkDeletable(String lang) async {
    final vocabs = Modular.get<VocabRepository>();
    if (vocabs == null) return false;
    return await vocabs.getLength(lang) <= 0;
  }

  Future loadOptions() async {
    isLoading = true;
    langs = ObservableList.of((await repo.getOption('langs')).cast<String>());
    grades = await repo.getOption('grades');
    isLoading = false;
  }
}