import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/box_settings/box_settings_controller.dart';
import 'package:vocabular/app/modules/box_settings/box_settings_module.dart';

void main() {
  initModule(BoxSettingsModule());
  BoxSettingsController boxsettings;

  setUp(() {
    boxsettings = BoxSettingsModule.to.get<BoxSettingsController>();
  });

  group('BoxSettingsController Test', () {
    test("First Test", () {
      expect(boxsettings, isInstanceOf<BoxSettingsController>());
    });

    test("Set Value", () {
      expect(boxsettings.value, equals(0));
      boxsettings.increment();
      expect(boxsettings.value, equals(1));
    });
  });
}
