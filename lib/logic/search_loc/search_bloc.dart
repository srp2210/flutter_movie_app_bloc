import 'package:bloc/bloc.dart';

import 'package:flutter_movie_app_bloc_self/data/repositories/search_repo.dart';
import 'package:flutter_movie_app_bloc_self/logic/search_loc/search_event.dart';
import 'package:flutter_movie_app_bloc_self/logic/search_loc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchrepository;
  SearchBloc(
    this._searchrepository,
  ) : super(SearchInitialState()) {
    on<LoadSearch>(
      (event, emit) async {
        emit(SearchInitialState());
        try {
          final movies = await _searchrepository.searchMovies(event.query);
          emit(SearchLoaded(movies: movies));
        } catch (e) {
          emit(SearchError());
        }
      },
    );
  }
}
