import 'box_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'box_page.dart';

class BoxModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => BoxController(i.get(), i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('', child: (_, args) => BoxPage(args.data)),
      ];

  static Inject get to => Inject<BoxModule>.of();
}
