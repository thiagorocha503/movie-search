import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/language/shared_preferences/language_preferences.dart';

class LanguageCubit extends Cubit<Language> {
  final LanguagePreferences prefs;
  LanguageCubit({required this.prefs, required Language language})
      : super(language);

  void change(Language language) {
    emit(language);
    prefs.setLanguage(language);
  }
}
