import 'package:flutter/foundation.dart';
import 'package:surge_global/model/yu_gi_oh.dart';

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
