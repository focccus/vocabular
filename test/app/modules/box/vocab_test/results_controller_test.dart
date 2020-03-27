import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/box/vocab_test/results_controller.dart';
import 'package:vocabular/app/modules/box/vocab_test/vocab_test_module.dart';

void main() {
  initModule(VocabTestModule());
  ResultsController results;

  setUp(() {
    results = VocabTestModule.to.get<ResultsController>();
  });

  group('ResultsController Test', () {
    test("First Test", () {
      expect(results, isInstanceOf<ResultsController>());
    });

    test("Set Value", () {
      expect(results.value, equals(0));
      results.increment();
      expect(results.value, equals(1));
    });
  });
}
