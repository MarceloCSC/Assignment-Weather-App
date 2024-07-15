import 'package:my_weather_app/models/weather_dto.dart';

class WeatherResponse {
  final bool isSuccessful;
  final int statusCode;
  final WeatherDto? data;

  WeatherResponse(
      {required this.isSuccessful,
      required this.statusCode,
      this.data});
}
