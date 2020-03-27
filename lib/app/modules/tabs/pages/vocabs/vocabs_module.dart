import 'package:vocabular/app/modules/tabs/pages/vocabs/vocabs_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/tabs/pages/vocabs/vocabs_page.dart';
import 'package:vocabular/app/widgets/insert_dialog/dialog_controller.dart';

class VocabsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => VocabsController(i.get(), i.get())),
        Bind((i) => DialogController(i.get(), i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => VocabsPage()),
      ];

  static Inject get to => Inject<VocabsModule>.of();
}
