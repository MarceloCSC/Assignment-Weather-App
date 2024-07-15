import 'package:flutter/material.dart';
import 'package:my_weather_app/services/weather_service.dart';
import 'package:my_weather_app/screens/request_error_screen.dart';
import 'package:my_weather_app/constants/screen_size.dart';
import 'package:my_weather_app/widgets/loading_widget.dart';
import 'package:my_weather_app/utils/formatter.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  FormattedWeather? _currentWeather;

  void fetchData() async {
    final response = await WeatherService.get();

    if (response.isSuccessful) {
      setState(() {
        _currentWeather = FormattedWeather.format(response.data!);
      });
    } else if (mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RequestErrorScreen(statusCode: response.statusCode)));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return _currentWeather == null
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.indigo.shade50,
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.all(4),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 220),
                        child: Image.asset(
                          'assets/images/${_currentWeather!.imageAddress}',
                          fit: BoxFit.contain,
                          width: screenWidth * 0.4,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Text(
                      _currentWeather!.location,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 28, letterSpacing: 2),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      _currentWeather!.temperature,
                      style: const TextStyle(color: Colors.black, fontSize: 38),
                    ),
                    Text(
                      _currentWeather!.description,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 18, letterSpacing: 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: SizedBox(
                          width: screenWidth * 0.75,
                          child: const Divider(
                              thickness: 1, color: Colors.black38),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: 420, maxHeight: screenHeight * 0.2),
                        child: Flex(
                          direction: screenWidth < ScreenSize.mobileScreen
                              ? Axis.vertical
                              : Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: 210, maxHeight: screenHeight * 0.1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text('min'),
                                      Text(
                                        _currentWeather!.minTemperature,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('max'),
                                      Text(
                                        _currentWeather!.maxTemperature,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: 210, maxHeight: screenHeight * 0.1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text('humidity'),
                                      Text(
                                        _currentWeather!.humidity,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('wind speed'),
                                      Text(
                                        _currentWeather!.windSpeed,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          );
  }
}
