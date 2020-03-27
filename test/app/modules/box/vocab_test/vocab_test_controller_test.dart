import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/box/vocab_test/vocab_test_controller.dart';
import 'package:vocabular/app/modules/box/vocab_test/vocab_test_module.dart';

void main() {
  initModule(VocabTestModule());
  VocabTestController vocabtest;

  setUp(() {
    vocabtest = VocabTestModule.to.get<VocabTestController>();
  });

  group('VocabTestController Test', () {
    test("First Test", () {
      expect(vocabtest, isInstanceOf<VocabTestController>());
    });

    test("Set Value", () {
      expect(vocabtest.value, equals(0));
      vocabtest.increment();
      expect(vocabtest.value, equals(1));
    });
  });
}
