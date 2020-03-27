import 'dart:convert';

import 'package:vocabular/app/models/vocab.dart';

class Box {
  int id;
  String title;
  String lang;
  bool hasFormen;
  bool mustType;
  int goback;
  bool random;
  bool askForeign;
  int testCount;
  List<int> vocabIds;
  List<List<VocabCard>> compartments;
  int get vocabCount => vocabIds?.length ?? 0;
  DateTime latest;
  Box({
    this.id,
    this.title,
    this.lang,
    this.hasFormen,
    this.mustType,
    this.goback,
    this.random,
    this.askForeign,
    this.testCount,
    this.vocabIds,
    this.compartments,
    this.latest,
  });

  factory Box.initial() => Box(
        title: 'Untitled',
        lang: 'en',
        hasFormen: false,
        mustType: false,
        goback: 1,
        random: true,
        askForeign: false,
        testCount: -1,
        vocabIds: [],
        compartments: [[], [], [], [], []],
        latest: DateTime.now(),
      );

  Box copyWith({
    int id,
    String title,
    String lang,
    bool hasFormen,
    bool mustType,
    int goback,
    bool random,
    bool askForeign,
    int testCount,
    List<int> vocabIds,
    List<List<VocabCard>> compartments,
    DateTime latest,
  }) {
    return Box(
      id: id ?? this.id,
      title: title ?? this.title,
      lang: lang ?? this.lang,
      hasFormen: hasFormen ?? this.hasFormen,
      mustType: mustType ?? this.mustType,
      goback: goback ?? this.goback,
      random: random ?? this.random,
      askForeign: askForeign ?? this.askForeign,
      testCount: testCount ?? this.testCount,
      vocabIds: vocabIds ?? this.vocabIds,
      compartments: compartments ?? this.compartments,
      latest: latest ?? this.latest,
    );
  }

  static Box fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    final opt = map['options'] ?? {};
    final vocabbox = opt['vocabbox'] ?? {};
    final vocabtest = opt['vocabtest'] ?? {};

    return Box(
      id: map['id'],
      title: map['title'],
      lang: map['lang'],
      hasFormen: map['hasFormen'] ?? opt['hasFormen'],
      mustType: map['mustType'] ?? vocabbox['mustType'],
      goback: map['goback'] ?? vocabbox['goback'],
      random: map['random'] ?? vocabbox['random'],
      askForeign: map['askForeign'] ?? vocabbox['askOther'],
      testCount: map['testCount'] ?? vocabtest['ask'],
      compartments: List<List<VocabCard>>.from(map['compartments']?.map((x) => x
              ?.map<VocabCard>(
                  (l) => VocabCard.fromMap(l.cast<String, dynamic>()))
              ?.toList()) ??
          []),
      vocabIds: List<int>.from(map['vocabIds'] ?? []),
      latest: DateTime.fromMillisecondsSinceEpoch(map['latest'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'lang': lang,
      'hasFormen': hasFormen,
      'mustType': mustType,
      'goback': goback,
      'random': random,
      'askForeign': askForeign,
      'testCount': testCount,
      'vocabIds': List<int>.from(vocabIds.map((x) => x)),
      'compartments': List<List<Map<String, dynamic>>>.from(
          compartments?.map((x) => x?.map((x) => x.toMap())?.toList())),
      'latest': latest.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  static Box fromJson(String source) => fromMap(json.decode(source));

  String getDisplayText(Vocab vocab, [bool other = false]) =>
      other ^ askForeign ? vocab.main : vocab.other;

  @override
  String toString() {
    return 'Box(id: $id, title: $title, lang: $lang, hasFormen: $hasFormen, mustType: $mustType, goback: $goback, random: $random, askForeign: $askForeign, testCount: $testCount, vocabIds: $vocabIds, compartments: $compartments, latest: $latest)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Box &&
        o.id == id &&
        o.title == title &&
        o.lang == lang &&
        o.hasFormen == hasFormen &&
        o.mustType == mustType &&
        o.goback == goback &&
        o.random == random &&
        o.askForeign == askForeign &&
        o.testCount == testCount &&
        o.vocabIds == vocabIds &&
        o.compartments == compartments &&
        o.latest == latest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        lang.hashCode ^
        hasFormen.hashCode ^
        mustType.hashCode ^
        goback.hashCode ^
        random.hashCode ^
        askForeign.hashCode ^
        testCount.hashCode ^
        vocabIds.hashCode ^
        compartments.hashCode ^
        latest.hashCode;
  }
}

class VocabCard {
  int id;
  int beated;
  int failed;
  VocabCard({
    this.id,
    this.beated,
    this.failed,
  });

  VocabCard copyWith({
    final int id,
    final int beated,
    final int failed,
  }) {
    return VocabCard(
      id: id ?? this.id,
      beated: beated ?? this.beated,
      failed: failed ?? this.failed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'beated': beated,
      'failed': failed,
    };
  }

  static VocabCard fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VocabCard(
      id: map['id'],
      beated: map['beated'],
      failed: map['failed'],
    );
  }

  String toJson() => json.encode(toMap());

  static VocabCard fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'VocabCard(id: $id, beated: $beated, failed: $failed)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VocabCard &&
        o.id == id &&
        o.beated == beated &&
        o.failed == failed;
  }

  @override
  int get hashCode => id.hashCode ^ beated.hashCode ^ failed.hashCode;
}
