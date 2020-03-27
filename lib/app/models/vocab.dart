import 'dart:convert';

class Vocab {
  int id;
  String main;
  String other;
  String forms;
  Vocab({
    this.id,
    this.main,
    this.other,
    this.forms,
  });

  Vocab copyWith({
    int id,
    String main,
    String other,
    String forms,
  }) {
    return Vocab(
      id: id ?? this.id,
      main: main ?? this.main,
      other: other ?? this.other,
      forms: forms ?? this.forms,
    );
  }

  Map<String, dynamic> toMap() {
    final ret = {
      'id': id,
      'main': main,
      'other': other,
    };
    if (forms != null) ret['forms'] = forms;
    return ret;
  }

  static Vocab fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Vocab(
      id: map['id'],
      main: map['main'],
      other: map['other'],
      forms: map['forms'],
    );
  }

  String toJson() => json.encode(toMap());

  static Vocab fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vocab(id: $id, main: $main, other: $other, forms: $forms)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vocab &&
        o.id == id &&
        o.main == main &&
        o.other == other &&
        o.forms == forms;
  }

  @override
  int get hashCode {
    return id.hashCode ^ main.hashCode ^ other.hashCode ^ forms.hashCode;
  }
}
