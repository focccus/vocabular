import 'package:vocabular/app/modules/box/box_settings/box_settings_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/box/box_settings/box_settings_page.dart';

class BoxSettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => BoxSettingsController(i.get(), i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(':id',
            child: (_, args) => BoxSettingsPage(int.parse(args.params['id']))),
      ];

  static Inject get to => Inject<BoxSettingsModule>.of();
}
