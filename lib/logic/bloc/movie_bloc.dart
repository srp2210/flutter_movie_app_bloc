import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_app_bloc_self/data/repositories/movie_repo.dart';
import 'package:flutter_movie_app_bloc_self/data/repositories/search_repo.dart';

import '../../data/models/movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  //repo
  final MovieRepository _movieRepository;

  MovieBloc(this._movieRepository) : super(MovieInitialState()) {
    on<LoadMovieEvent>((event, emit) async {
      //initial
      emit(MovieInitialState());
      try {
        final movies = await _movieRepository.getMovies();
        //final movie = await _movieRepository.searchMovies();
        //loaded
        emit(MovieLoadedState(movies: movies));
        //emit(MovieSearchState(movie: movie));
      } catch (e) {
        //error
        emit(MovieErrorState(e.toString()));
      }
    });
  }
}
