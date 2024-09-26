part of 'location_fetch_bloc.dart';

@immutable
sealed class LocationFetchState {}

final class LocationFetchInitial extends LocationFetchState {}

class SuccessfullyFetched extends LocationFetchState {
  final String currentplace;

  SuccessfullyFetched({required this.currentplace});
}

class LoadingFetched extends LocationFetchState {}

class ErrorfetchingLocation extends LocationFetchState {
  final String message;

  ErrorfetchingLocation({required this.message});
}
