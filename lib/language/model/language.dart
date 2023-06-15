import 'package:equatable/equatable.dart';

import 'package:movie_search_app/language/model/code.dart';

class Language extends Equatable {
  final String name;
  final LangISOCode code;

  const Language({required this.code, required this.name});

  @override
  String toString() {
    return "($code, $name})";
  }

  @override
  List<Object?> get props => [code, name];
}
