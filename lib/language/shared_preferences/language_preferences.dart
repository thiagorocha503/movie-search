import 'package:shared_preferences/shared_preferences.dart';

import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/util/convertion.dart';

class LanguagePreferences {
  final SharedPreferences prefs;
  final String key = "movie_search_lang";
  LanguagePreferences({required this.prefs});

  Language getLanguage() {
    String? lang = prefs.getString(key);
    if (lang == null) {
      prefs.setString(key, "en-US");
      return stringToLanguage("en-US");
    }
    return stringToLanguage(lang);
  }

  void setLanguage(Language lang) {
    String value = languageToString(lang);
    prefs.setString(key, value);
  }
}
