import 'dart:convert';

import 'package:vocabular/app/models/vocab.dart';

class VocabTestValue {
  final Vocab vocab;
  final String input;
  final String inputForms;

  final int valueMistakes;
  final int formsMistakes;
  double get mistakes => ((valueMistakes ?? 2) / 2 + (formsMistakes ?? 2) / 2);
  VocabTestValue({
    this.vocab,
    this.input,
    this.inputForms,
    this.valueMistakes,
    this.formsMistakes,
  });

  VocabTestValue copyWith({
    Vocab vocab,
    String input,
    String inputForms,
    int valueMistakes,
    int formsMistakes,
  }) {
    return VocabTestValue(
      vocab: vocab ?? this.vocab,
      input: input ?? this.input,
      inputForms: inputForms ?? this.inputForms,
      valueMistakes: valueMistakes ?? this.valueMistakes,
      formsMistakes: formsMistakes ?? this.formsMistakes,
    );
  }

  @override
  String toString() {
    return 'VocabTestValue(vocab: $vocab, input: $input, inputForms: $inputForms, valueMistakes: $valueMistakes, formsMistakes: $formsMistakes)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VocabTestValue &&
        o.vocab == vocab &&
        o.input == input &&
        o.inputForms == inputForms &&
        o.valueMistakes == valueMistakes &&
        o.formsMistakes == formsMistakes;
  }

  @override
  int get hashCode {
    return vocab.hashCode ^
        input.hashCode ^
        inputForms.hashCode ^
        valueMistakes.hashCode ^
        formsMistakes.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'vocab': vocab.toMap(),
      'input': input,
      'inputForms': inputForms,
      'valueMistakes': valueMistakes,
      'formsMistakes': formsMistakes,
    };
  }

  static VocabTestValue fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VocabTestValue(
      vocab: Vocab.fromMap(map['vocab']),
      input: map['input'],
      inputForms: map['inputForms'],
      valueMistakes: map['valueMistakes'],
      formsMistakes: map['formsMistakes'],
    );
  }

  String toJson() => json.encode(toMap());

  static VocabTestValue fromJson(String source) => fromMap(json.decode(source));
}
