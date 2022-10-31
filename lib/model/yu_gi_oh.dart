import 'dart:convert';

class YuGiOh {
  YuGiOh({
    this.data = const <TopRatedMovieModel>[],
    this.meta,
  });

  List<TopRatedMovieModel> data;
  Meta? meta;

  factory YuGiOh.fromJson(String str) {
    return YuGiOh.fromMap(json.decode(str));
  }

  factory YuGiOh.fromMap(Map<String, dynamic> json) {
    return YuGiOh(
      data: List<TopRatedMovieModel>.from(json["results"].map((x) {
        return TopRatedMovieModel.fromMap(x);
      })),
      meta: Meta.fromMap(json),
    );
  }
}

class TopRatedMovieModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  TopRatedMovieModel(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory TopRatedMovieModel.fromJson(String str) {
    return TopRatedMovieModel.fromMap(json.decode(str));
  }

  factory TopRatedMovieModel.fromMap(Map<String, dynamic> json) {
    return TopRatedMovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'].cast<int>(),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}

class Meta {
  int? page;
  int? total_pages;
  int? total_results;

  Meta({
    this.page,
    this.total_pages,
    this.total_results,
  });

  factory Meta.fromJson(String str) {
    return Meta.fromMap(json.decode(str));
  }

  factory Meta.fromMap(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      total_pages: json["total_pages"],
      total_results: json["total_results"],
    );
  }
}
