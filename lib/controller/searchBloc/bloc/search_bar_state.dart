part of 'search_bar_bloc.dart';

@immutable
sealed class SearchBarState {}

final class SearchBarInitial extends SearchBarState {}

class SearchBarHidden extends SearchBarState {}

class SearchBarVisible extends SearchBarState {}
