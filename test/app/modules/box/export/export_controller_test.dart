import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/box/export/export_controller.dart';
import 'package:vocabular/app/modules/box/export/export_module.dart';

void main() {
  initModule(ExportModule());
  ExportController export;

  setUp(() {
    export = ExportModule.to.get<ExportController>();
  });

  group('ExportController Test', () {
    test("First Test", () {
      expect(export, isInstanceOf<ExportController>());
    });

    test("Set Value", () {
      expect(export.value, equals(0));
      export.increment();
      expect(export.value, equals(1));
    });
  });
}
