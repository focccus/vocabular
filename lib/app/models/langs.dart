import 'package:language_pickers/languages.dart';

Language getLanguageByIsoCode(
  String isoCode, [
  List<Map<String, String>> langs,
]) {
  langs ??= defaultLanguagesList.cast<Map<String, String>>();
  try {
    final res = langs.firstWhere((language) =>
        language['isoCode'].toLowerCase() == isoCode.toLowerCase());
    return Language.fromMap(res);
  } catch (error) {
    throw Exception("The initialValue provided is not a supported iso code!");
  }
}

final List<Map<String, String>> germanLanguagesList = [
  {"isoCode": "ab", "name": "Abkhazian"},
  {"isoCode": "aa", "name": "Afar"},
  {"isoCode": "af", "name": "Afrikaans"},
  {"isoCode": "ak", "name": "Akan"},
  {"isoCode": "sq", "name": "Albanisch"},
  {"isoCode": "am", "name": "Amharic"},
  {"isoCode": "ar", "name": "Arabisch"},
  {"isoCode": "an", "name": "Aragonese"},
  {"isoCode": "hy", "name": "Armenisch"},
  {"isoCode": "as", "name": "Assamese"},
  {"isoCode": "av", "name": "Avaric"},
  {"isoCode": "ae", "name": "Avestan"},
  {"isoCode": "ay", "name": "Aymara"},
  {"isoCode": "az", "name": "Azerbaijani"},
  {"isoCode": "bm", "name": "Bambara"},
  {"isoCode": "ba", "name": "Bashkir"},
  {"isoCode": "eu", "name": "Basque"},
  {"isoCode": "be", "name": "Belarusian"},
  {"isoCode": "bn", "name": "Bengali"},
  {"isoCode": "bh", "name": "Bihari Sprachen"},
  {"isoCode": "bi", "name": "Bislama"},
  {"isoCode": "nb", "name": "Norwegisch"},
  {"isoCode": "bs", "name": "Bosnisch"},
  {"isoCode": "br", "name": "Breton"},
  {"isoCode": "bg", "name": "Bulgarisch"},
  {"isoCode": "my", "name": "Burmese"},
  {"isoCode": "ca", "name": "Catalan"},
  {"isoCode": "km", "name": "Central Khmer"},
  {"isoCode": "ch", "name": "Chamorro"},
  {"isoCode": "ce", "name": "Chechen"},
  {"isoCode": "ny", "name": "Chewa (Nyanja)"},
  {"isoCode": "zh_Hans", "name": "Chinesisch (einfach)"},
  {"isoCode": "zh_Hant", "name": "Chinesisch (Traditionell)"},
  {"isoCode": "cu", "name": "Church Slavonic"},
  {"isoCode": "cv", "name": "Chuvash"},
  {"isoCode": "kw", "name": "Cornish"},
  {"isoCode": "co", "name": "Corsican"},
  {"isoCode": "cr", "name": "Cree"},
  {"isoCode": "hr", "name": "Kroatisch"},
  {"isoCode": "cs", "name": "Tschechisch"},
  {"isoCode": "da", "name": "Dänisch"},
  {"isoCode": "dv", "name": "Dhivehi"},
  {"isoCode": "nl", "name": "Niederländisch"},
  {"isoCode": "dz", "name": "Dzongkha"},
  {"isoCode": "en", "name": "Englisch"},
  {"isoCode": "eo", "name": "Esperanto"},
  {"isoCode": "et", "name": "Estonian"},
  {"isoCode": "ee", "name": "Ewe"},
  {"isoCode": "fo", "name": "Faroese"},
  {"isoCode": "fj", "name": "Fijian"},
  {"isoCode": "fi", "name": "Finnisch"},
  {"isoCode": "fr", "name": "Französisch"},
  {"isoCode": "ff", "name": "Fulah"},
  {"isoCode": "gd", "name": "Gaelic"},
  {"isoCode": "gl", "name": "Galician"},
  {"isoCode": "lg", "name": "Ganda"},
  {"isoCode": "ka", "name": "Georgisch"},
  {"isoCode": "de", "name": "Deutsch"},
  {"isoCode": "el", "name": "Griechisch, Modern (1453-)"},
  {"isoCode": "gn", "name": "Guarani"},
  {"isoCode": "gu", "name": "Gujarati"},
  {"isoCode": "ht", "name": "Haitian"},
  {"isoCode": "ha", "name": "Hausa"},
  {"isoCode": "he", "name": "Hebrew"},
  {"isoCode": "hz", "name": "Herero"},
  {"isoCode": "hi", "name": "Hindi"},
  {"isoCode": "ho", "name": "Hiri Motu"},
  {"isoCode": "hu", "name": "Ungarisch"},
  {"isoCode": "is", "name": "Isländisch"},
  {"isoCode": "io", "name": "Ido"},
  {"isoCode": "ig", "name": "Igbo"},
  {"isoCode": "id", "name": "Indonesisch"},
  {"isoCode": "ia", "name": "Interlingua"},
  {"isoCode": "ie", "name": "Interlingue"},
  {"isoCode": "iu", "name": "Inuktitut"},
  {"isoCode": "ik", "name": "Inupiaq"},
  {"isoCode": "ga", "name": "Irish"},
  {"isoCode": "it", "name": "Italienisch"},
  {"isoCode": "ja", "name": "Japanisch"},
  {"isoCode": "jv", "name": "Javanese"},
  {"isoCode": "kl", "name": "Kalaallisut"},
  {"isoCode": "kn", "name": "Kanadisch"},
  {"isoCode": "kr", "name": "Kanuri"},
  {"isoCode": "ks", "name": "Kashmiri"},
  {"isoCode": "kk", "name": "Kazakh"},
  {"isoCode": "ki", "name": "Kikuyu"},
  {"isoCode": "rw", "name": "Kinyarwanda"},
  {"isoCode": "ky", "name": "Kirghiz"},
  {"isoCode": "kv", "name": "Komi"},
  {"isoCode": "kg", "name": "Kongo"},
  {"isoCode": "ko", "name": "Koreanisch"},
  {"isoCode": "kj", "name": "Kuanyama"},
  {"isoCode": "ku", "name": "Kurdish"},
  {"isoCode": "lo", "name": "Lao"},
  {"isoCode": "la", "name": "Latein"},
  {"isoCode": "lv", "name": "Latvian"},
  {"isoCode": "li", "name": "Limburgan"},
  {"isoCode": "ln", "name": "Lingala"},
  {"isoCode": "lt", "name": "Lithuanian"},
  {"isoCode": "lu", "name": "Luba-Katanga"},
  {"isoCode": "lb", "name": "Luxenburgerisch"},
  {"isoCode": "mk", "name": "Macedonian"},
  {"isoCode": "mg", "name": "Malagasy"},
  {"isoCode": "ms", "name": "Malay"},
  {"isoCode": "ml", "name": "Malayalam"},
  {"isoCode": "mt", "name": "Maltese"},
  {"isoCode": "gv", "name": "Manx"},
  {"isoCode": "mi", "name": "Maori"},
  {"isoCode": "mr", "name": "Marathi"},
  {"isoCode": "mh", "name": "Marshallese"},
  {"isoCode": "mn", "name": "Mongolian"},
  {"isoCode": "na", "name": "Nauru"},
  {"isoCode": "nv", "name": "Navajo"},
  {"isoCode": "nd", "name": "Ndebele, North"},
  {"isoCode": "nr", "name": "Ndebele, South"},
  {"isoCode": "ng", "name": "Ndonga"},
  {"isoCode": "ne", "name": "Nepali"},
  {"isoCode": "se", "name": "Northern Sami"},
  {"isoCode": "no", "name": "Norwegisch"},
  {"isoCode": "nn", "name": "Norwegian Nynorsk"},
  {"isoCode": "oc", "name": "Occitan (post 1500)"},
  {"isoCode": "oj", "name": "Ojibwa"},
  {"isoCode": "or", "name": "Oriya"},
  {"isoCode": "om", "name": "Oromo"},
  {"isoCode": "os", "name": "Ossetian"},
  {"isoCode": "pi", "name": "Pali"},
  {"isoCode": "pa", "name": "Panjabi"},
  {"isoCode": "fa", "name": "Persisch"},
  {"isoCode": "pl", "name": "Polnisch"},
  {"isoCode": "pt", "name": "Portugiesisch"},
  {"isoCode": "ps", "name": "Pushto"},
  {"isoCode": "qu", "name": "Quechua"},
  {"isoCode": "ro", "name": "Romanian"},
  {"isoCode": "rm", "name": "Romansh"},
  {"isoCode": "rn", "name": "Rundi"},
  {"isoCode": "ru", "name": "Russisch"},
  {"isoCode": "sm", "name": "Samoan"},
  {"isoCode": "sg", "name": "Sango"},
  {"isoCode": "sa", "name": "Sanskrit"},
  {"isoCode": "sc", "name": "Sardinian"},
  {"isoCode": "sr", "name": "Serbisch"},
  {"isoCode": "sn", "name": "Shona"},
  {"isoCode": "ii", "name": "Sichuan Yi"},
  {"isoCode": "sd", "name": "Sindhi"},
  {"isoCode": "si", "name": "Sinhala"},
  {"isoCode": "sk", "name": "Slovakisch"},
  {"isoCode": "sl", "name": "Slovenian"},
  {"isoCode": "so", "name": "Somalisch"},
  {"isoCode": "st", "name": "Sotho, Southern"},
  {"isoCode": "es", "name": "Spanisch"},
  {"isoCode": "su", "name": "Sundanese"},
  {"isoCode": "sw", "name": "Swahili"},
  {"isoCode": "ss", "name": "Swati"},
  {"isoCode": "sv", "name": "Schwedisch"},
  {"isoCode": "tl", "name": "Tagalog"},
  {"isoCode": "ty", "name": "Tahitian"},
  {"isoCode": "tg", "name": "Tajik"},
  {"isoCode": "ta", "name": "Tamil"},
  {"isoCode": "tt", "name": "Tatar"},
  {"isoCode": "te", "name": "Telugu"},
  {"isoCode": "th", "name": "Thai"},
  {"isoCode": "bo", "name": "Tibetan"},
  {"isoCode": "ti", "name": "Tigrinya"},
  {"isoCode": "to", "name": "Tonga (Tonga Islands)"},
  {"isoCode": "ts", "name": "Tsonga"},
  {"isoCode": "tn", "name": "Tswana"},
  {"isoCode": "tr", "name": "Türkisch"},
  {"isoCode": "tk", "name": "Turkmen"},
  {"isoCode": "tw", "name": "Twi"},
  {"isoCode": "ug", "name": "Uighur"},
  {"isoCode": "uk", "name": "Ukrainisch"},
  {"isoCode": "ur", "name": "Urdu"},
  {"isoCode": "uz", "name": "Uzbek"},
  {"isoCode": "ve", "name": "Venda"},
  {"isoCode": "vi", "name": "Vietnamesisch"},
  {"isoCode": "vo", "name": "Volapük"},
  {"isoCode": "wa", "name": "Walloon"},
  {"isoCode": "cy", "name": "Welsh"},
  {"isoCode": "fy", "name": "Western Frisian"},
  {"isoCode": "wo", "name": "Wolof"},
  {"isoCode": "xh", "name": "Xhosa"},
  {"isoCode": "yi", "name": "Yiddish"},
  {"isoCode": "yo", "name": "Yoruba"},
  {"isoCode": "za", "name": "Zhuang"},
  {"isoCode": "zu", "name": "Zulu"}
];
