import 'package:equatable/equatable.dart';

import 'package:movie_search_app/movie_overview/model/movie_preview.dart';

class ResultSearch extends Equatable {
  final int page;
  final List<MoviePreview> results;
  final int totalPages;
  final int totalResults;

  const ResultSearch({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  ResultSearch copyWith({
    int? page,
    List<MoviePreview>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      ResultSearch(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory ResultSearch.fromJson(Map<String, dynamic> json) => ResultSearch(
        page: json["page"],
        results: List<MoviePreview>.from(
            json["results"].map((x) => MoviePreview.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<MoviePreview>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
