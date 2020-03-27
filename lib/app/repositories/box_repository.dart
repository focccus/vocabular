import 'dart:math';

import 'package:hive/hive.dart' as Hive;
import 'package:vocabular/app/models/box.dart';

enum LoadingState { initial, loading, loaded, empty }

class BoxRepository {
  Hive.Box hive;
  Future<Hive.Box> initHive() async {
    if (hive != null) return hive;
    return hive = await Hive.Hive.openBox('boxes');
  }

  Future<List<Box>> getAllBoxes() async {
    await initHive();
    return hive.values
        .cast<Map>()
        .map((b) => Box.fromMap(b.cast<String, dynamic>()))
        .toList();
  }

  Future<Box> getBoxByID(int id) async {
    await initHive();
    return Box.fromMap(hive.get(id)?.cast<String, dynamic>());
  }

  Future saveBox(Box box, int id) async {
    await initHive();
    return hive.put(id, box.toMap());
  }

  Future deleteBox(int id) async {
    await initHive();
    return hive.delete(id);
  }

  Future<int> addNewBox(Box box) async {
    await initHive();
    final json = box.toMap();
    json['vocabIds'] ??= [];
    final id = await hive.add(json);
    await saveBox(box.copyWith(id: id), id);
    return id;
  }
}

extension ShuffleExtension on List {
  List<T> shuffle<T>(List<T> items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }
}
