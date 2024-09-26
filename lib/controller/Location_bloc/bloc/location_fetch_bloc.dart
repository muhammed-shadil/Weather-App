import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
part 'location_fetch_event.dart';
part 'location_fetch_state.dart';

class LocationFetchBloc extends Bloc<LocationFetchEvent, LocationFetchState> {
  LocationFetchBloc() : super(LocationFetchInitial()) {
    on<LocationFetch>(locationfetchbloc);
  }

  FutureOr<void> locationfetchbloc(
      LocationFetch event, Emitter<LocationFetchState> emit) async {
    emit(LoadingFetched());
    Position currentposition;
    bool serviceEnabled;
    String currentplace;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(ErrorfetchingLocation(
            message:
                'Location services are disabled. Please enable the services'));
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(ErrorfetchingLocation(
              message: 'Location permissions are denied'));
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(ErrorfetchingLocation(
            message:
                'Location permissions are permanently denied, we cannot request permissions.'));
      }
      currentposition = await Geolocator.getCurrentPosition();

      List<Placemark> placeMark = await placemarkFromCoordinates(
          currentposition.latitude, currentposition.longitude);

      currentplace = placeMark[1].locality.toString();

      emit(SuccessfullyFetched(currentplace: currentplace));
    } catch (e) {
      emit(ErrorfetchingLocation(message: e.toString()));
    }
  }
}
