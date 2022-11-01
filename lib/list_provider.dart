import 'package:flutter/foundation.dart';
import 'model/tob_rated_movie_model.dart';

class TopRatedMoviesProvider with ChangeNotifier {
  bool isLoading = true;
  List<TopRatedMovieModel> movieList = [];
  List<TopRatedMovieModel> get topRatedMovies => movieList;

  Future<void> getAllMovies(List<TopRatedMovieModel> items) async {
    movieList.addAll(items);
    isLoading = false;
    notifyListeners();
  }
}
