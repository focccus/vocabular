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
        Router('', guards: [BlockGuard()], child: (_, args) => BoxPage(0)),
        Router(':id',
            child: (_, args) => BoxPage(int.tryParse(args.params['id']))),
      ];

  static Inject get to => Inject<BoxModule>.of();
}

class BlockGuard implements RouteGuard {
  @override
  bool canActivate(String url) {
    return false;
  }
}
