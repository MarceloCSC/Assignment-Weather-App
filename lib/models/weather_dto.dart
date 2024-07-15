class WeatherDto {
  final String id;
  final String name;
  final String description;
  final String location;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final double windSpeed;
  final int humidity;

  WeatherDto({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.windSpeed,
    required this.humidity,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) {
    return WeatherDto(
      id: json['weather'][0]['id'].toString(),
      name: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      location: json['name'],
      temperature: json['main']['temp'],
      minTemperature: json['main']['temp_min'],
      maxTemperature: json['main']['temp_max'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': int.parse(id),
        'name': name,
        'description': description,
        'city': location,
        'temperature': temperature,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature,
        'humidity': humidity,
        'windSpeed': windSpeed,
      };
}
