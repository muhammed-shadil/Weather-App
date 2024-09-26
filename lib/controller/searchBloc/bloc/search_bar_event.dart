part of 'search_bar_bloc.dart';

@immutable
sealed class SearchBarEvent {}

class ToggleSearchBar extends SearchBarEvent {}
