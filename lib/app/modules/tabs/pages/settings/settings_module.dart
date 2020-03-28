import 'package:vocabular/app/modules/tabs/pages/settings/settings_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/tabs/pages/settings/settings_page.dart';

class SettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SettingsController(i.get(), i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SettingsPage()),
      ];

  static Inject get to => Inject<SettingsModule>.of();
}
