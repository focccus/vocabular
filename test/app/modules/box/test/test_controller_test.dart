import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/box/test/test_controller.dart';
import 'package:vocabular/app/modules/box/test/test_module.dart';

void main() {
  initModule(TestModule());
  TestController test;

  setUp(() {
    test = TestModule.to.get<TestController>();
  });

  group('TestController Test', () {
    test("First Test", () {
      expect(test, isInstanceOf<TestController>());
    });

    test("Set Value", () {
      expect(test.value, equals(0));
      test.increment();
      expect(test.value, equals(1));
    });
  });
}
