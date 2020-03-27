import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/boxes/boxes_controller.dart';
import 'package:vocabular/app/modules/boxes/boxes_module.dart';

void main() {
  initModule(BoxesModule());
  BoxesController boxes;

  setUp(() {
    boxes = BoxesModule.to.get<BoxesController>();
  });

  group('BoxesController Test', () {
    test("First Test", () {
      expect(boxes, isInstanceOf<BoxesController>());
    });

    test("Set Value", () {
      expect(boxes.value, equals(0));
      boxes.increment();
      expect(boxes.value, equals(1));
    });
  });
}
