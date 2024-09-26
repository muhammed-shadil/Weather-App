import 'package:weather_app/controller/Data_fetch_bloc/cubit/temperature_converter_cubit.dart';

class CommenFunctions {
 static double convertTemp(double temp, TempUnit unit) {
    if (unit == TempUnit.fahrenheit) {
      return (temp * 9 / 5) + 32; // Convert to Fahrenheit
    }
    return temp; // Celsius by default
  }
}
