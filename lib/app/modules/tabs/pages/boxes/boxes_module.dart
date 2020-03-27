import 'package:vocabular/app/modules/tabs/pages/boxes/boxes_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/tabs/pages/boxes/boxes_page.dart';

class BoxesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => BoxesController(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => BoxesPage()),
      ];

  static Inject get to => Inject<BoxesModule>.of();
}
