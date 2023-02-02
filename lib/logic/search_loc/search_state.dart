import 'package:equatable/equatable.dart';
import 'package:flutter_movie_app_bloc_self/data/models/movie_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<MovieModel> movies;

  const SearchLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}
