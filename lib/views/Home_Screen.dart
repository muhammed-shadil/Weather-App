import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controller/Location_bloc/bloc/location_fetch_bloc.dart';
import 'package:weather_app/utils/styles.dart';
import 'package:weather_app/views/widgets/bottom_card.dart';
import 'package:weather_app/views/widgets/glass_card.dart';

class HomeScreenwrpper extends StatelessWidget {
  const HomeScreenwrpper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationFetchBloc()..add(LocationFetch()),
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        decoration:
            // const
            // DecorationImage(
            //     fit: BoxFit.cover,
            //     image: AssetImage("assets/misteremil190200032.jpg")))
            AppStyles.gradientBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // 5% of screen width
            vertical: screenHeight * 0.05, // 5% of screen height
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "INDIA",
                style: AppStyles.cityTextStyle,
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  Text(
                    "Current Location",
                    style: AppStyles.smallDetailTextStyle,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05), // Responsive spacing
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          screenWidth * 0.4, // Image takes 40% of screen width
                      child: Image.asset(
                          "assets/412.png"), // Update with your asset name
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      "13°C",
                      style: AppStyles.tempTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Partly Cloud - H:17° L:4°",
                style: AppStyles.weatherDescTextStyle,
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Today")),
                  SizedBox(width: screenWidth * 0.04),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Next day")),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),

              SizedBox(
                height: screenHeight *
                    0.15, // ListView height is 15% of screen height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return const GlassForecastCard(
                        time: "Now", temp: "13°", icon: Icons.cloud);
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherDetails(
                            title: "Sunset",
                            value: "5:51PM",
                            icon: Icons.wb_sunny),
                        WeatherDetails(
                            title: "Sunrise",
                            value: "7:00AM",
                            icon: Icons.wb_sunny),
                        WeatherDetails(
                            title: "UV Index",
                            value: "1 Low",
                            icon: Icons.wb_sunny),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
