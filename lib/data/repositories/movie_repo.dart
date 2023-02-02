import 'dart:convert';

import 'package:flutter_movie_app_bloc_self/constants.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class MovieRepository {
  String end = 'https://jsonplaceholder.typicode.com/posts';
  String endpoint =
      'https://api.themoviedb.org/3/movie/popular?api_key=$kkey&language=en-US&page=20';
  Future<List<MovieModel>> getMovies() async {
    final response = await http.get(Uri.parse(endpoint));
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
