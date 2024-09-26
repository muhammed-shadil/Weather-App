import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'temperature_converter_state.dart';

enum TempUnit { celsius, fahrenheit }

class TemperatureConverterCubit extends Cubit<TempUnit> {
  TemperatureConverterCubit() : super(TempUnit.celsius);

  void toggleUnit() {
    if (state == TempUnit.celsius) {
      emit(TempUnit.fahrenheit); // Emit Fahrenheit state
    } else {
      emit(TempUnit.celsius); // Emit Celsius state
    }
  }
}
