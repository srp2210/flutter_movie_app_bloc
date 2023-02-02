import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

@immutable
class LoadSearch extends SearchEvent {
  final String query;
   const LoadSearch({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
