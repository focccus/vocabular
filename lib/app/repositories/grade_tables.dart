class GradeTable {
  static String american(double percent) {
    int p = (percent * 100).round();
    if (p.between(97)) return 'A+';
    if (p.between(93)) return 'A';
    if (p.between(90)) return 'A-';
    if (p.between(87)) return 'B+';
    if (p.between(83)) return 'B';
    if (p.between(80)) return 'B-';
    if (p.between(77)) return 'C+';
    if (p.between(73)) return 'C';
    if (p.between(70)) return 'C-';
    if (p.between(67)) return 'D+';
    if (p.between(63)) return 'D';
    if (p.between(60)) return 'D-';
    return 'F';
  }

  static String oberstufe(double percent) {
    int p = (percent * 100).round();
    if (p.between(95)) return '15';
    if (p.between(90)) return '14';
    if (p.between(85)) return '13';
    if (p.between(80)) return '12';
    if (p.between(75)) return '11';
    if (p.between(70)) return '10';
    if (p.between(65)) return '09';
    if (p.between(60)) return '08';
    if (p.between(55)) return '07';
    if (p.between(50)) return '06';
    if (p.between(45)) return '05';
    if (p.between(39)) return '04';
    if (p.between(33)) return '03';
    if (p.between(27)) return '02';
    if (p.between(20)) return '01';
    return '00';
  }

  static String german(double percent) {
    int p = (percent * 100).round();
    if (p.between(98)) return '1+';
    if (p.between(95)) return '1';
    if (p.between(92)) return '1-';
    if (p.between(88)) return '2+';
    if (p.between(85)) return '2';
    if (p.between(81)) return '2-';
    if (p.between(77)) return '3+';
    if (p.between(72)) return '3';
    if (p.between(67)) return '3-';
    if (p.between(61)) return '4+';
    if (p.between(56)) return '4';
    if (p.between(50)) return '4-';
    if (p.between(43)) return '5+';
    if (p.between(37)) return '5';
    if (p.between(30)) return '5-';
    return '6';
  }
}

extension Between on num {
  bool between(num p1, [num p2]) {
    if (p1 != null && this < p1) return false;
    if (p2 != null && this > p2) return false;
    return true;
  }
}
