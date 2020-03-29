import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

const subjectID = '2cf779f8-ef18-4968-9032-321e410ffd58';

const getUnits = "https://lernen.phase-6.de/server.integration/unitsFiltered";
const getCards = "https://lernen.phase-6.de/server.integration/cardList";

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://lernen.phase-6.de/server.integration/',
    headers: {
      'x-jauthtoken':
          'walav45463@mailmyrss.com_51c182e7-163d-4612-842b-26b52924217b',
      'x-clientid': '5cc31107-c14b-413a-f17a-60b50dcf29de',
      'x-lbtoken': 'walav45463@mailmyrss.com',
    },
  ),
);

void main(List<String> args) async {
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

  getUnit(units.keys.first, units.values.first);
}

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
        other = other
            .replaceAll('<b>', '')
            .split('</b>')
            .first
            .replaceAll(',', '|');
        main = main.replaceAll(',', '|');

        vocabs.add({'main': main, 'other': other});
      }
    }

    final file = File('./' + name + '.vocab');
    file.writeAsString(json.encode({'vocabs': vocabs}));
  } else
    return;
}
