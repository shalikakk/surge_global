import 'dart:convert';

import 'package:surge_global/model/page_model.dart';
import 'package:surge_global/model/tob_rated_movie_model.dart';

class TopRatedMovies {
  TopRatedMovies({
    this.data = const <TopRatedMovieModel>[],
    this.meta,
  });

  List<TopRatedMovieModel> data;
  PageModel? meta;

  factory TopRatedMovies.fromJson(String str) {
    return TopRatedMovies.fromMap(json.decode(str));
  }

  factory TopRatedMovies.fromMap(Map<String, dynamic> json) {
    return TopRatedMovies(
      data: List<TopRatedMovieModel>.from(json["results"].map((x) {
        return TopRatedMovieModel.fromMap(x);
      })),
      meta: PageModel.fromMap(json),
    );
  }
}
