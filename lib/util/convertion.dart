import 'package:movie_search_app/language/model/code.dart';
import 'package:movie_search_app/language/model/language.dart';

Language stringToLanguage(String lang) {
  switch (lang) {
    case "en-US":
      return const Language(code: LangISOCode.en_US, name: "English");
    case "pt-BR":
      return const Language(code: LangISOCode.pt_BR, name: "Português(Brasil)");
    case "es":
      return const Language(code: LangISOCode.es, name: "Spanish");
    default:
      throw Exception("Invalid lang '$lang'");
  }
}

String languageToString(Language lang) {
  switch (lang.code) {
    case LangISOCode.en_US:
      return "en-US";
    case LangISOCode.es:
      return "es";
    case LangISOCode.pt_BR:
      return "pt-BR";
  }
}
