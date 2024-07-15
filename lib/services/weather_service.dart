import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/auth/api_key.dart';
import 'package:my_weather_app/models/weather_dto.dart';
import 'package:my_weather_app/models/coordinates.dart';
import 'package:my_weather_app/models/weather_response.dart';
import 'package:my_weather_app/services/location_service.dart';

class WeatherService {
  static Future<WeatherResponse> get() async {
    final Coordinates coordinates = await LocationService.get();

    final Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${coordinates.latitude}&lon=${coordinates.longitude}&appid=$apiKey');

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      // Here we should implement a more robust error handling via a try catch block.
      // To keep it simple, though, I'm only returning the response status code
      // to be handled in the frontend.

      return WeatherResponse(
          isSuccessful: true,
          statusCode: response.statusCode,
          data: WeatherDto.fromJson(json));
    } else {
      return WeatherResponse(
          isSuccessful: false, statusCode: response.statusCode);
    }
  }
}
