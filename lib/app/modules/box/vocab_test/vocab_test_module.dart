import 'package:vocabular/app/modules/box/vocab_test/results/results_controller.dart';
import 'package:vocabular/app/modules/box/vocab_test/results/results_page.dart';
import 'package:vocabular/app/modules/box/vocab_test/vocab_test_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/box/vocab_test/vocab_test_page.dart';

class VocabTestModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ResultsController(i.get(), i.get())),
        Bind((i) => VocabTestController(i.get(), i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(
          '',
          child: (_, args) => VocabTestPage(args.data),
        ),
        Router(
          'results/:id',
          child: (_, args) => ResultsPage(
            int.parse(args.params['id']),
            args.data,
          ),
        ),
      ];

  static Inject get to => Inject<VocabTestModule>.of();
}
