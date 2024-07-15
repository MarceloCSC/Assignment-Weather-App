import 'package:my_weather_app/constants/images.dart';
import 'package:my_weather_app/models/weather_dto.dart';

class Formatter {
  static String getImageAddress(String id) {
    if (id == '800') {
      return Images.clear;
    } else if (id.substring(0, 2) == '80') {
      return Images.clouds;
    }

    String code = id.substring(0, 1);

    switch (code) {
      case '2':
        return Images.thunderstorm;
      case '3':
        return Images.drizzle;
      case '5':
        return Images.rain;
      case '6':
        return Images.snow;
      case '7':
        return Images.atmosphere;
      case '8':
        return Images.clear;
      default:
        return '';
    }
  }

  static String toFahrenheit(double kelvin) {
    double fahrenheit = ((kelvin - 273.15) * 1.8) + 32;

    return '${fahrenheit.round()} °F';
  }

  static String toMilesPerHour(double metersPerSecond) {
    double milesPerHour = metersPerSecond * 2.236936;

    return '${milesPerHour.round()} mph';
  }

  static String toPercentage(int number) {
    return '$number%';
  }
}

class FormattedWeather {
  final String name;
  final String description;
  final String location;
  final String imageAddress;
  final String temperature;
  final String minTemperature;
  final String maxTemperature;
  final String windSpeed;
  final String humidity;

  FormattedWeather({
    required this.name,
    required this.description,
    required this.location,
    required this.imageAddress,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.windSpeed,
    required this.humidity,
  });

  factory FormattedWeather.format(WeatherDto dto) {
    return FormattedWeather(
      name: dto.name,
      description: dto.description,
      location: dto.location,
      imageAddress: Formatter.getImageAddress(dto.id),
      temperature: Formatter.toFahrenheit(dto.temperature),
      minTemperature: Formatter.toFahrenheit(dto.minTemperature),
      maxTemperature: Formatter.toFahrenheit(dto.maxTemperature),
      windSpeed: Formatter.toMilesPerHour(dto.windSpeed),
      humidity: Formatter.toPercentage(dto.humidity),
    );
  }
}
