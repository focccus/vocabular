import 'package:flutter_modular/flutter_modular.dart';

import 'box/box_module.dart';
import 'box_list/box_list_module.dart';
import 'box_settings/box_settings_module.dart';
import 'export/export_module.dart';
import 'vocab_test/vocab_test_module.dart';

class BoxSubModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', module: BoxModule()),
        Router('settings', module: BoxSettingsModule()),
        Router('vocabs', module: BoxListModule()),
        Router('test', module: VocabTestModule()),
        Router('export', module: ExportModule()),
      ];

  static Inject get to => Inject<BoxSubModule>.of();
}
