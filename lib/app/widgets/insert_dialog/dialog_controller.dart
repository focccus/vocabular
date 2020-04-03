import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

part 'dialog_controller.g.dart';

const MyMemoryURL = 'http://api.mymemory.translated.net/get';
const MemoryEmail = 'walav45463@mailmyrss.com';

class DialogController = _DialogControllerBase with _$DialogController;

abstract class _DialogControllerBase with Store {
  final VocabRepository repo;
  final Dio dio;

  _DialogControllerBase(this.repo, this.dio);

  String lang = 'en';

  bool loadStorage;

  Future<List<SuggestionEntry>> getSuggestions(String s) async {
    final ret = <SuggestionEntry>[];

    if (loadStorage != null && loadStorage) {
      s = s.toLowerCase();

      final vocabs = await repo.filtered(
        lang,
        (Map m) =>
            (m['main']?.toLowerCase()?.contains(s) ?? false) ||
            (m['other']?.toLowerCase()?.contains(s) ?? false),
        10,
      );
      ret.addAll(vocabs.map((e) => SuggestionEntry(false, e)).toList());
    }

    final res = await jsonRequest(
      MyMemoryURL,
      {
        'q': s,
        'langpair': '$lang|de',
        'de': MemoryEmail,
      },
    );

    if (res['matches'] != null) {
      for (var m in res['matches']) {
        if (m != null && m['segment'] != null && m['translation'] != null) {
          ret.add(SuggestionEntry.fromMap(m));
        }
      }
    }

    return ret;
  }
}

Future<Map> jsonRequest(String url, Map<String, dynamic> query) async {
  try {
    Response response = await Dio().get(url, queryParameters: query);
    return response.data;
  } catch (e) {
    print(e);
    return {};
  }
}

class SuggestionEntry {
  final bool isThirdParty;
  final Vocab vocab;

  SuggestionEntry(this.isThirdParty, this.vocab);

  static SuggestionEntry fromMap(Map m) {
    final other = m['segment'];
    final main = m['translation'];

    return SuggestionEntry(true, Vocab(main: main, other: other, forms: ''));
  }
}
