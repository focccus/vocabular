import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

const subjects = {
  'Green Line 2': 'eb7b6da8-f9c0-4529-8a59-99d91c54d3c4',
  'Green Line 5': '36d63a43-2e40-4185-850f-c05f3cdb5edd',
  'Green Line 4': '6dd4513a-4839-488c-99c9-b2e701363612',
  'Green Line 3': 'c17fa59d-b6b2-4671-bfbe-307054616404',
};

const lang = 'en';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://lernen.phase-6.de/server.integration/',
    headers: {
      'x-jauthtoken':
          'walav45463@mailmyrss.com_4ade4b13-60a6-4ff1-8566-c964e689033e',
      'x-clientid': '84a62081-7982-4c93-ef69-e704b5ac5961',
      'x-lbtoken': 'walav45463@mailmyrss.com',
    },
  ),
);

main(List<String> args) {
  subjects.forEach((key, value) {
    getSubject(value, './$key/');
  });
}

void getSubject(String subjectID, String dir) async {
  Map<String, String> units = {};

  final unitRes = (await dio.post(
    'unitsFiltered',
    data: {'subjectId': subjectID},
  ))
      .data;

  if (unitRes != null &&
      unitRes['replyContent'] != null &&
      unitRes['replyContent']['units'] != null) {
    for (var unit in unitRes['replyContent']['units']) {
      String id;
      if (unit['unitId'] != null && unit['unitId']['id'] != null) {
        id = unit['unitId']['id'];
      }
      String name;
      if (unit['unitContent'] != null && unit['unitContent']['name'] != null) {
        name = unit['unitContent']['name'];
      }
      if (id != null && name != null) {
        units[id] = name;
      }
    }
  } else
    return;

  void getUnit(String id, String name) async {
    final res = (await dio.post(
      'cardList',
      data: {
        'subjectId': subjectID,
        'units': [id],
      },
    ))
        .data;

    if (res != null &&
        res['replyContent'] != null &&
        res['replyContent']['cards'] != null) {
      List<Map<String, String>> vocabs = [];

      for (var unit in res['replyContent']['cards']) {
        if (unit['cardContent'] != null &&
            unit['cardContent']['question'] != null &&
            unit['cardContent']['answer'] != null) {
          String main = unit['cardContent']['question'];
          String other = unit['cardContent']['answer'];

          other = stringUnify(other);

          main = stringUnify(main);

          vocabs.add({'main': main, 'other': other});
        }
      }
      final map = {
        'vocabs': vocabs,
        'box': {
          'title': name,
          'lang': lang,
          'hasFormen': false,
          'mustType': false,
          'goback': 1,
          'random': true,
          'askForeign': false,
          'testCount': -1,
        }
      };

      if (Directory(dir).existsSync() == false && dir.isNotEmpty) {
        Directory(dir).createSync(recursive: true);
      }

      final file =
          File(dir + name.replaceAll('/', '').replaceAll('.', '') + '.vocab');
      print('saved $name');

      file.writeAsString(json.encode(map));
    } else
      return;
  }

  units.forEach(getUnit);

  //getUnit(units.keys.first, units.values.first);
}

String stringUnify(String s) {
  return s
      .split('\n')
      .first
      .replaceAll(RegExp(r'<[^>]*>'), "")
      .replaceAll(',', ' |');
}
