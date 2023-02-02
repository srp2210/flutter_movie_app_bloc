part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

//data loading state
class MovieInitialState extends MovieState {}

//data loaded state
class MovieLoadedState extends MovieState {
  //passing model
  final List<MovieModel> movies;
  const MovieLoadedState({
    required this.movies,
  });
  @override
  List<Object> get props => [movies];
}

//data error state
class MovieErrorState extends MovieState {
  final String error;
  const MovieErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class Search extends MovieState{}
