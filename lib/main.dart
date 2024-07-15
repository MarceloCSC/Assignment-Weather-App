import 'package:flutter/material.dart';
import 'package:my_weather_app/screens/login_screen.dart';
import 'package:my_weather_app/screens/weather_screen.dart';
import 'package:my_weather_app/screens/not_found_screen.dart';

void main() => runApp(MaterialApp(
      title: 'My Weather App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/weather': (context) => const WeatherScreen(),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const NotFoundScreen()),
    ));
