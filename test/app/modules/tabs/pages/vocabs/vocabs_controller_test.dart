import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/tabs/pages/vocabs/vocabs_controller.dart';
import 'package:vocabular/app/modules/tabs/pages/vocabs/vocabs_module.dart';

void main() {
  initModule(VocabsModule());
  VocabsController vocabs;

  setUp(() {
    vocabs = VocabsModule.to.get<VocabsController>();
  });

  group('VocabsController Test', () {
    test("First Test", () {
      expect(vocabs, isInstanceOf<VocabsController>());
    });

    test("Set Value", () {
      expect(vocabs.value, equals(0));
      vocabs.increment();
      expect(vocabs.value, equals(1));
    });
  });
}
