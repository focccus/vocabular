import 'package:flutter_modular/flutter_modular.dart';

import 'pages/boxes/boxes_module.dart';
import 'pages/settings/settings_module.dart';
import 'pages/vocabs/vocabs_module.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(
          '',
          module: BoxesModule(),
          transition: TransitionType.fadeIn,
        ),
        Router(
          'vocabs',
          module: VocabsModule(),
          transition: TransitionType.fadeIn,
        ),
        Router(
          'settings',
          module: SettingsModule(),
          transition: TransitionType.fadeIn,
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
