import 'package:dio/dio.dart';
import 'package:surge_global/network/api_key.dart';

import '../common/constant.dart';
import '../model/yu_gi_oh.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constant.baseUrl,
    ),
  );

  static Future<TopRatedMovies?> getCardInfo({
    required int page,
  }) async {
    try {
      Response<Map<String, dynamic>> _response;
      _response = await _dio.get<Map<String, dynamic>>(
        '/movie/top_rated',
        queryParameters: <String, dynamic>{
          'api_key': apiKey,
          'language': 'en-US',
          'page': page
        },
      );
      //https://api.themoviedb.org/3/movie/top_rated?api_key=9618b5cf6ae9661f92fff553c697bed4&language=en-US&page=1
      return TopRatedMovies.fromMap(_response.data ?? <String, dynamic>{});
    } catch (e) {
      return null;
    }
  }
}
