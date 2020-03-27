import 'package:vocabular/app/modules/box/box_list/box_list_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/box/box_list/box_list_page.dart';
import 'package:vocabular/app/widgets/insert_dialog/dialog_controller.dart';

class BoxListModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => BoxListController(i.get(), i.get())),
        Bind((i) => DialogController(i.get(), i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(':id',
            child: (_, args) => BoxListPage(int.parse(args.params['id']))),
      ];

  static Inject get to => Inject<BoxListModule>.of();
}
