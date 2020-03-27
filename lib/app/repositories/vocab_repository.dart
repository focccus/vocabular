import 'package:hive/hive.dart';
import 'package:vocabular/app/models/vocab.dart';

class VocabRepository {
  Box hive(String lang) => Hive.box('vocab_$lang');

  Future<Box> initHive(String lang) async {
    if (Hive.isBoxOpen('vocab_$lang')) return hive(lang);

    return await Hive.openBox('vocab_$lang');
  }

  Future<List<Vocab>> getAllVocabs(String lang) async {
    await initHive(lang);
    // hive(lang).clear();
    final res = <Vocab>[];
    hive(lang).toMap().cast<int, Map>().forEach((i, b) =>
        res.add(Vocab.fromMap(b.cast<String, dynamic>())?.copyWith(id: i)));
    return res;
  }

  Future<List<Vocab>> filtered(
    String lang,
    bool Function(Map) where, [
    int limit,
  ]) async {
    await initHive(lang);
    int count = 0;
    final res = <Vocab>[];

    hive(lang).toMap().cast<int, Map>().forEach((i, b) {
      if (where(b)) {
        if (limit == null || (limit != null && limit > count)) {
          res.add(Vocab.fromMap(b.cast<String, dynamic>())?.copyWith(id: i));
          count++;
        }
      }
    });
    return res;
  }

  Future<int> getLength(String lang) async {
    await initHive(lang);
    return hive(lang).length;
  }

  Future<Vocab> getVocabByID(int id, String lang) async {
    await initHive(lang);
    return Vocab.fromMap(hive(lang).get(id)?.cast<String, dynamic>())
        ?.copyWith(id: id);
  }

  Future<List<Vocab>> getVocabs(List<int> ids, String lang) async {
    return Future.wait<Vocab>(ids.map((i) => getVocabByID(i, lang)).toList());
  }

  Future saveVocab(Vocab v, int id, String lang) async {
    await initHive(lang);
    return hive(lang).put(id, v.toMap());
  }

  Future deleteVocab(int id, String lang) async {
    await initHive(lang);
    return hive(lang).delete(id);
  }

  Future<int> addVocab(Vocab v, String lang) async {
    await initHive(lang);
    return await hive(lang).add(v.toMap());
  }
}
