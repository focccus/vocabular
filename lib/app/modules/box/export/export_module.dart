import 'package:vocabular/app/modules/box/export/export_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/box/export/export_page.dart';

class ExportModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ExportController(i.get(),i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('', child: (_, args) => ExportPage(args.data)),
      ];

  static Inject get to => Inject<ExportModule>.of();
}
