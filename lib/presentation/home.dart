import 'package:flutter/material.dart';
import 'package:flutter_movie_app_bloc_self/data/models/movie_model.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/bloc/movie_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Movies List'),
      ),
      body: Column(
        children: [
          const Text(
            'Movies4k',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          TextField(
            controller: _controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintText: 'Search Wallpapers',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: ElevatedButton(
                child: const Icon(Icons.search),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  //context
                  // .read<WallpaperCubit>()
                  // .getWallpapers(_controller.text);
                },
              ),
            ),
            onSubmitted: (value) => {},
            // context.read<WallpaperCubit>().getWallpapers(value),
          ),
          Expanded(
            child: Center(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: ((context, state) {
                  //initial
                  if (state is MovieInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //loaded
                  if (state is MovieLoadedState) {
                    List<MovieModel> movieList = state.movies;

                    return ListView.builder(
                        itemCount: movieList.length,
                        itemBuilder: (_, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 170,
                                      width: 120,
                                      child: Image.network(
                                        'http://image.tmdb.org/t/p/w500${movieList[index].posterPath.toString()}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ID: ${movieList[index].id.toString()}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Name: ${movieList[index].title}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          'Desp: ${movieList[index].overview}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                  }

                  //error
                  if (state is MovieErrorState) {
                    return const Text('error');
                  }
                  return Container();
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
