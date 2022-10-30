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
      // meta: Meta.fromMap(json["page"]),
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
  Meta({
    this.currentRows,
    this.totalRows,
    this.rowsRemaining,
    this.totalPages,
    this.pagesRemaining,
    this.nextPage,
    this.nextPageOffset,
  });

  int? currentRows;
  int? totalRows;
  int? rowsRemaining;
  int? totalPages;
  int? pagesRemaining;
  String? nextPage;
  int? nextPageOffset;

  factory Meta.fromJson(String str) {
    return Meta.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Meta.fromMap(Map<String, dynamic> json) {
    return Meta(
      currentRows: json["current_rows"],
      totalRows: json["total_rows"],
      rowsRemaining: json["rows_remaining"],
      totalPages: json["total_pages"],
      pagesRemaining: json["pages_remaining"],
      nextPage: json["next_page"],
      nextPageOffset: json["next_page_offset"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "current_rows": currentRows,
      "total_rows": totalRows,
      "rows_remaining": rowsRemaining,
      "total_pages": totalPages,
      "pages_remaining": pagesRemaining,
      "next_page": nextPage,
      "next_page_offset": nextPageOffset,
    };
  }
}
