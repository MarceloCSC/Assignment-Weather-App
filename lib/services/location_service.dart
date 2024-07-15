import 'package:geolocator/geolocator.dart';
import 'package:my_weather_app/models/coordinates.dart';

class LocationService {
  static Future<Coordinates> get() async {
    final bool hasPermission = await _handlePermission();

    if (!hasPermission) {
      return Future.error('Location permissions are denied.');
    }

    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    final json = position.toJson();
    final Coordinates coordinates = Coordinates.fromJson(json);

    return coordinates;
  }

  static Future<bool> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return false;
      }
    }

    return true;
  }
}
