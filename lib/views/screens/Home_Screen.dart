import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controller/Data_fetch_bloc/cubit/temperature_converter_cubit.dart';
import 'package:weather_app/controller/Data_fetch_bloc/current_weather/weather_data_bloc.dart';
import 'package:weather_app/controller/Data_fetch_bloc/forecast/forecast_weather_bloc.dart';
import 'package:weather_app/controller/Location_bloc/bloc/location_fetch_bloc.dart';
import 'package:weather_app/controller/searchBloc/bloc/search_bar_bloc.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/styles.dart';
import 'package:weather_app/views/widgets/BottomHomepart.dart';
import 'package:weather_app/views/widgets/ForecastHomepart.dart';
import 'package:weather_app/views/widgets/StartHomepart.dart';

class HomeScreenwrpper extends StatelessWidget {
  const HomeScreenwrpper({super.key});
  @override
  Widget build(BuildContext context) {
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
          create: (context) => SearchBarBloc(),
        ),
      ],
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationFetchBloc>(context).add(LocationFetch());
  }

  void _searchCityWeather(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          BlocProvider.of<SearchBarBloc>(context)
                              .add(ToggleSearchBar());
                        },
                      ),
                      BlocBuilder<SearchBarBloc, SearchBarState>(
                        builder: (context, state) {
                          if (state is SearchBarVisible) {
                            return Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                height: 40,
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: TextField(
                                  autofocus: true,
                                  onTapOutside: (event) =>
                                      FocusScope.of(context).unfocus(),
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
                            return Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: BlocBuilder<LocationFetchBloc,
                                    LocationFetchState>(
                                  builder: (context, state) {
                                    if (state is SuccessfullyFetched) {
                                      BlocProvider.of<WeatheDataBloc>(context)
                                          .add(WeatherDatas(
                                              cityname: state.currentplace));
                                      BlocProvider.of<ForecastWeatherBloc>(
                                              context)
                                          .add(ForcastWeather(
                                              cityname: state.currentplace));

                                      return Column(
                                        children: [
                                          Text(
                                            state.currentplace,
                                            style: AppStyles.cityTextStyle,
                                          ),
                                          const Text(
                                            "current location",
                                          ),
                                        ],
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
                SizedBox(height: screenHeight * 0.01),
                StartHomepart(
                    screenWidth: screenWidth, screenHeight: screenHeight),
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
                ForecastHomePart(screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.04),
                BottomPartHome(
                    screenWidth: screenWidth, screenHeight: screenHeight),
                AppSpaces.h10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
