import 'package:vocabular/app/modules/import/import_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/import/import_page.dart';

class ImportModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ImportController(i.get(), i.get(), i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(
          '',
          child: (_, args) => ImportPage(
            lang: args.data == null ? null : args.data['lang'],
            canImportBox: args.data == null ? null : args.data['canImportBox'],
          ),
        ),
      ];

  static Inject get to => Inject<ImportModule>.of();
}
