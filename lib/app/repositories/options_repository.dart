import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart' as Hive;

import 'package:vocabular/app/models/box.dart';

class OptionsRepository {
  Hive.Box hive;
  Future<Hive.Box> initHive() async {
    if (hive != null) return hive;
    hive = await Hive.Hive.openBox('options');

    if (hive.get('langs') == null) {
      hive.put('langs', ['en', 'fr', 'es']);
    }

    if (hive.get('grades') == null) {
      hive.put('grades', 'de');
    }

    return hive;
  }

  Future getOption(String id) async {
    await initHive();
    return hive.get(id);
  }

  Future saveOption(String id, value) async {
    await initHive();
    return hive.put(id, value);
  }
}
