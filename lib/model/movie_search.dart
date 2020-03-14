// To parse this JSON data, do
//
//     final movieSearch = movieSearchFromJson(jsonString);

import 'dart:convert';

MovieSearch movieSearchFromJson(String str) => MovieSearch.fromJson(json.decode(str));

String movieSearchToJson(MovieSearch data) => json.encode(data.toJson());

class MovieSearch {
    double popularity;
    int voteCount;
    bool video;
    String posterPath;
    int id;
    bool adult;
    String backdropPath;
    String originalLanguage;
    String originalTitle;
    List<int> genreIds;
    String title;
    double voteAverage;
    String overview;
    DateTime releaseDate;

    MovieSearch({
        this.popularity,
        this.voteCount,
        this.video,
        this.posterPath,
        this.id,
        this.adult,
        this.backdropPath,
        this.originalLanguage,
        this.originalTitle,
        this.genreIds,
        this.title,
        this.voteAverage,
        this.overview,
        this.releaseDate,
    });

    factory MovieSearch.fromJson(Map<String, dynamic> json) => MovieSearch(
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        posterPath: json["poster_path"],
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
    );

    Map<String, dynamic> toJson() => {
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "poster_path": posterPath,
        "id": id,
        "adult": adult,
        "backdrop_path": backdropPath,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "title": title,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    };
}


/*


{
   "page":1,
   "total_results":2,
   "total_pages":1,
   "results":[
      {
         "popularity":15.845,
         "vote_count":4517,
         "video":false,
         "poster_path":"\/mt0ELw83HIRgaKaDzhsDcIi0RnW.jpg",
         "id":75780,
         "adult":false,
         "backdrop_path":"\/ezXodpP429qK0Av89pVNlaXWJkQ.jpg",
         "original_language":"en",
         "original_title":"Jack Reacher",
         "genre_ids":[
            28,
            80,
            18,
            53
         ],
         "title":"Jack Reacher",
         "vote_average":6.5,
         "overview":"When a gunman takes five lives with six shots, all evidence points to the suspect in custody. On interrogation, the suspect offers up a single note: \"Get Jack Reacher!\" So begins an extraordinary chase for the truth, pitting Jack Reacher against an unexpected enemy, with a skill for violence and a secret to keep.",
         "release_date":"2012-12-20"
      },
      {
         "popularity":15.034,
         "vote_count":3055,
         "video":false,
         "poster_path":"\/IfB9hy4JH1eH6HEfIgIGORXi5h.jpg",
         "id":343611,
         "adult":false,
         "backdrop_path":"\/nDS8rddEK74HfAwCC5CoT6Cwzlt.jpg",
         "original_language":"en",
         "original_title":"Jack Reacher: Never Go Back",
         "genre_ids":[
            28,
            53
         ],
         "title":"Jack Reacher: Never Go Back",
         "vote_average":5.6,
         "overview":"Jack Reacher must uncover the truth behind a major government conspiracy in order to clear his name. On the run as a fugitive from the law, Reacher uncovers a potential secret from his past that could change his life forever.",
         "release_date":"2016-10-19"
      }
   ]
}
*/