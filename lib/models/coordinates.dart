class Coordinates {
  final String latitude;
  final String longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': double.parse(latitude),
        'longitude': double.parse(longitude),
      };
}
