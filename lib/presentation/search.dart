// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app_bloc_self/data/models/movie_model.dart';
import 'package:flutter_movie_app_bloc_self/logic/search_loc/search_bloc.dart';
import 'package:flutter_movie_app_bloc_self/logic/search_loc/search_event.dart';

import '../logic/search_loc/search_state.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late SearchBloc searchBloc;

  @override
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context);

    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _searchcontroller = TextEditingController();
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
            'Movies Search Engine',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          TextField(
            controller: _searchcontroller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintText: 'Enter movie name here',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: ElevatedButton(
                child: const Icon(Icons.search),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  searchBloc.add(LoadSearch(query: _searchcontroller.text));
                },
              ),
            ),
            onSubmitted: (value) => {
              searchBloc.add(LoadSearch(query: value)),
            },
            // context.read<WallpaperCubit>().getWallpapers(value),
          ),
          Expanded(child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              //initial
              if (state is SearchInitialState) {
                // ignore: prefer_const_constructors
                return Center(
                  child: const CircularProgressIndicator(),
                );
              }
              //loaded
              if (state is SearchLoaded) {
                List<MovieModel> sList = state.movies;
                return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: ((_, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: 90,
                                  width: 100,
                                  child: Image.network(
                                    'http://image.tmdb.org/t/p/w500${sList[index].posterPath.toString()}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ${sList[index].title}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'ID: ${sList[index].id.toString()}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),

                                    // Text(
                                    //   'Desp: ${sList[index].overview}',
                                    //   style: const TextStyle(fontSize: 15),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }));
              }

              //error
              if (state is SearchError) {
                return const Text('error');
              }
              return Container();
            },
          ))
        ],
      ),
    );
  }
}
