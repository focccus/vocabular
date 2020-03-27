import 'dart:math';

class StringSimilarity {
  static final maxErrors = 2;
  static final threashold = 0.75;
  static final perfectThreashold = 0.95;

  static bool checkSimilarity(String first, String second) {
    return checkClosest(first, second) <= maxErrors;
  }

  static int checkClosest(String first, String second) {
    final firstInputs = first.toLowerCase().split(RegExp(r'\||;'));
    final secondInputs = second.toLowerCase().split(RegExp(r'\||;'));

    int minErrors;

    for (var input in firstInputs) {
      for (var input2 in secondInputs) {
        final res = levenshteinDistance(input, input2);
        if (minErrors == null || res < minErrors) {
          minErrors = res;
        }
      }
    }

    return minErrors;
  }

  /// Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case-sensitive.
  ///
  /// ##### Arguments
  /// - first (String): The first string
  /// - second (String): The second string
  ///
  /// (Order does not make a difference)
  ///
  /// ##### Returns
  /// (number): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.
  static double compareTwoStrings(String first, String second) {
    first =
        first.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace
    second =
        second.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace

    // if both are empty strings
    if (first.isEmpty && second.isEmpty) {
      return 1;
    }
    // if only one is empty string
    if (first.isEmpty || second.isEmpty) {
      return 0;
    }
    // identical
    if (first == second) {
      return 1;
    }
    // both are 1-letter strings
    if (first.length == 1 && second.length == 1) {
      return 0;
    }
    // if either is a 1-letter string
    if (first.length < 2 || second.length < 2) {
      return 0;
    }

    final Map<String, int> firstBigrams = <String, int>{};
    for (int i = 0; i < first.length - 1; i++) {
      final String bigram = first.substring(i, i + 2);
      final int count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram] + 1 : 1;
      firstBigrams[bigram] = count;
    }

    int intersectionSize = 0;
    for (int i = 0; i < second.length - 1; i++) {
      final String bigram = second.substring(i, i + 2);
      final int count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram] : 0;

      if (count > 0) {
        firstBigrams[bigram] = count - 1;
        intersectionSize++;
      }
    }

    return (2.0 * intersectionSize) / (first.length + second.length - 2);
  }

  static int levenshteinDistance(String s1, String s2) {
    s1 = s1.replaceAll(
        RegExp(r'\s+\b|\b\s|,|;|\.'), ''); // remove all whitespace
    s2 = s2.replaceAll(
        RegExp(r'\s+\b|\b\s|,|;|\.'), ''); // remove all whitespace

    if (s1 == s2) {
      return 0;
    }

    if (s1.isEmpty) {
      return s2.length;
    }

    if (s2.isEmpty) {
      return s1.length;
    }

    List<int> v0 = new List<int>(s2.length + 1);
    List<int> v1 = new List<int>(s2.length + 1);
    List<int> vtemp;

    for (var i = 0; i < v0.length; i++) {
      v0[i] = i;
    }

    for (var i = 0; i < s1.length; i++) {
      v1[0] = i + 1;

      for (var j = 0; j < s2.length; j++) {
        int cost = 1;
        if (s1.codeUnitAt(i) == s2.codeUnitAt(j)) {
          cost = 0;
        }
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }

      vtemp = v0;
      v0 = v1;
      v1 = vtemp;
    }

    return v0[s2.length];
  }
}
