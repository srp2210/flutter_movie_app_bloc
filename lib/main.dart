import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app_bloc_self/data/repositories/search_repo.dart';
import 'package:flutter_movie_app_bloc_self/logic/search_loc/search_bloc.dart';
import 'package:flutter_movie_app_bloc_self/logic/search_loc/search_event.dart';
import 'package:flutter_movie_app_bloc_self/presentation/search.dart';

import 'data/repositories/movie_repo.dart';

import 'logic/bloc/movie_bloc.dart';

import 'presentation/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //adding bloc provider
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => MovieRepository(),
        ),
         RepositoryProvider(
          create: (context) => SearchRepositoryImpl(),
        ),
        
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MovieBloc(
              RepositoryProvider.of<MovieRepository>(context),
            )..add(LoadMovieEvent()),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              RepositoryProvider.of<SearchRepositoryImpl>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Movies TMDB',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SearchWidget(),
        ),
      ),
    );
  }
}
