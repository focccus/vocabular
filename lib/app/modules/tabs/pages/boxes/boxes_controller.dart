import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/repositories/box_repository.dart';

part 'boxes_controller.g.dart';

class BoxesController = _BoxesControllerBase with _$BoxesController;

abstract class _BoxesControllerBase with Store {
  final BoxRepository storage;

  _BoxesControllerBase(this.storage);

  @observable
  int expandedCard = -1;

  @observable
  ObservableList<Box> boxes;
  @observable
  ObservableFuture<List<Box>> boxesFuture;

  @action
  Future loadBoxes() async {
    boxesFuture = ObservableFuture(storage.getAllBoxes());
    boxes = ObservableList.of(await boxesFuture);
  }

  @action
  Future addBox() async {
    var box = Box.initial();
    final id = await storage.addNewBox(box);
    box = box.copyWith(id: id);
    boxes = ObservableList.of([box, ...boxes]);
  }

  @computed
  LoadingState get state {
    print(boxesFuture?.status ?? 'error');
    if (boxesFuture == null || boxesFuture.status == FutureStatus.rejected) {
      return LoadingState.initial;
    }
    if (boxesFuture.status == FutureStatus.pending) {
      return LoadingState.loading;
    }
    if (boxes == null || boxes.isEmpty) {
      return LoadingState.empty;
    }
    return LoadingState.loaded;
  }
}
