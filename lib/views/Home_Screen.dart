import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/Data_fetch_bloc/cubit/temperature_converter_cubit.dart';
import 'package:weather_app/controller/Data_fetch_bloc/current_weather/weather_data_bloc.dart';
import 'package:weather_app/controller/Data_fetch_bloc/forecast/forecast_weather_bloc.dart';
import 'package:weather_app/controller/Location_bloc/bloc/location_fetch_bloc.dart';
import 'package:weather_app/controller/searchBloc/bloc/search_bar_bloc.dart';
import 'package:weather_app/utils/commen_functions.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/icons.dart';
import 'package:weather_app/utils/styles.dart';
import 'package:weather_app/views/widgets/bottom_card.dart';
import 'package:weather_app/views/widgets/glass_card.dart';

class HomeScreenwrpper extends StatelessWidget {
  const HomeScreenwrpper({super.key});
  @override
  Widget build(BuildContext context) {
    print("objectsss");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TemperatureConverterCubit(),
        ),
        BlocProvider(
          create: (context) => ForecastWeatherBloc(),
        ),
        BlocProvider(
          create: (context) => LocationFetchBloc(),
        ),
        BlocProvider(
          create: (context) => WeatheDataBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBarBloc(), // Added SearchBarBloc
        ),
      ],
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch weather and forecast for current location initially
    BlocProvider.of<LocationFetchBloc>(context).add(LocationFetch());
  }

  // Function to trigger weather fetching for the searched city
  void _searchCityWeather(BuildContext context) {
    print(_searchController.text);
    if (_searchController.text.isNotEmpty) {
      BlocProvider.of<ForecastWeatherBloc>(context)
          .add(ForcastWeather(cityname: _searchController.text));
      BlocProvider.of<WeatheDataBloc>(context)
          .add(WeatherDatas(cityname: _searchController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight,
          decoration: AppStyles.gradientBackground,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Bar with Search Icon and Location Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: Row(
                    children: [
                      // Search Icon
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          BlocProvider.of<SearchBarBloc>(context)
                              .add(ToggleSearchBar());
                        },
                      ),
                      // BlocBuilder for SearchBar visibility
                      BlocBuilder<SearchBarBloc, SearchBarState>(
                        builder: (context, state) {
                          if (state is SearchBarVisible) {
                            return Expanded(
                              child: Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: "Search city",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white54),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  onSubmitted: (value) =>
                                      _searchCityWeather(context),
                                ),
                              ),
                            );
                          } else {
                            // Show Current Location when search bar is hidden
                            return Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: BlocBuilder<LocationFetchBloc,
                                    LocationFetchState>(
                                  builder: (context, state) {
                                    if (state is SuccessfullyFetched) {
                                      // Fetch weather and forecast for current location
                                      BlocProvider.of<WeatheDataBloc>(context)
                                          .add(WeatherDatas(
                                              cityname: state.currentplace));
                                      BlocProvider.of<ForecastWeatherBloc>(
                                              context)
                                          .add(ForcastWeather(
                                              cityname: state.currentplace));

                                      return Text(
                                        state.currentplace,
                                        style: AppStyles.cityTextStyle,
                                      );
                                    }
                                    return const Text(
                                      "Fetching...",
                                      style: AppStyles.cityTextStyle,
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.01), // Responsive spacing

                // Weather details for current location or searched city
                BlocBuilder<TemperatureConverterCubit, TempUnit>(
                  builder: (context, unit) {
                    return BlocBuilder<WeatheDataBloc, WeatheDataState>(
                      builder: (context, state) {
                        if (state is LoadingFetchingWeather) {
                          return const CircularProgressIndicator();
                        } else if (state is SuccessfullyFetchedWeather) {
                          double currentTemp = CommenFunctions.convertTemp(
                              state.weatherdata.main.temp, unit);
                          return Center(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.4,
                                      child: Image(
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          AppIcons.icons[state
                                              .weatherdata.weather[0].main],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => context
                                          .read<TemperatureConverterCubit>()
                                          .toggleUnit(),
                                      child: Text(
                                        "${currentTemp.toStringAsFixed(0)}°${unit == TempUnit.celsius ? 'C' : 'F'}",
                                        style: AppStyles.tempTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  "${state.weatherdata.weather[0].description}- H:${state.weatherdata.main.tempMax.toStringAsFixed(2)}° L:${state.weatherdata.main.tempMin.toStringAsFixed(2)}°",
                                  style: AppStyles.weatherDescTextStyle,
                                ),
                                Text(
                                  "${state.weatherdata.name}- H:${state.weatherdata.main.tempMax.toStringAsFixed(2)}° L:${state.weatherdata.main.tempMin.toStringAsFixed(2)}°",
                                  style: AppStyles.weatherDescTextStyle,
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    );
                  },
                ),

                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Today")),
                    SizedBox(width: screenWidth * 0.03),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Next day")),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                SizedBox(
                  height: screenHeight *
                      0.15, // ListView height is 15% of screen height
                  child: BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
                    builder: (context, state) {
                      if (state is LoadingForecastWeather) {
                        return const CircularProgressIndicator();
                      } else if (state is SuccessfullyForecastWeather) {
                        final list = state.forecastdata.list;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            DateTime dateTime =
                                DateTime.parse(list[index].dtTxt);
                            String formattedTime = DateFormat.jm()
                                .format(dateTime); // Convert to 12-hour format

                            return GlassForecastCard(
                              time: formattedTime, // Show the formatted time
                              temp:
                                  "${list[index].main.temp.toStringAsFixed(0)}°", // Show temperature
                              icon: AppIcons
                                      .icons[list[index].weather[0].main] ??
                                  "assets/icons/clear.png", // Replace this with an actual weather icon based on condition
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  margin: const EdgeInsets.all(7),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: BlocBuilder<WeatheDataBloc, WeatheDataState>(
                    builder: (context, state) {
                      if (state is LoadingFetchingWeather) {
                        return const CircularProgressIndicator();
                      } else if (state is SuccessfullyFetchedWeather) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherDetails(
                                    title: "Windspeed",
                                    value: "${state.weatherdata.wind.speed}",
                                    icon: "assets/images-removebg-preview.png"),
                                WeatherDetails(
                                    title: "Humidity",
                                    value: "${state.weatherdata.main.humidity}",
                                    icon: "assets/dd-removebg-preview.png"),
                                WeatherDetails(
                                    title: "Pressure",
                                    value: "${state.weatherdata.main.pressure}",
                                    icon:
                                        "assets/images__1_-removebg-preview.png"),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                AppSpaces.h10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
