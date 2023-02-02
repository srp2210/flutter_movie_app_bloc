import 'dart:convert';

import 'package:flutter_movie_app_bloc_self/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

abstract class SearchRepository {
  Future<List<MovieModel>> searchMovies(String query);
}

class SearchRepositoryImpl extends SearchRepository {
  String searchq =
      'https://api.themoviedb.org/3/search/movie?api_key=7fe438ce86cea095bebfce47bda9f0e8&language=en-US&query=avatar&page=1&include_adult=false';
  String endpoint =
      'https://api.themoviedb.org/3/movie/popular?api_key=$kkey&language=en-US&page=20';
  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$kkey&language=en-US&query=$query&page=1&include_adult=false'));
    if (response.statusCode == 200) {
      //json
      final json = jsonDecode(response.body);
      //imp
      final results = json['results'] as List<dynamic>;
      // print(response.body);
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
