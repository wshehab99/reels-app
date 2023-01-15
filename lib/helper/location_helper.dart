import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<String> getAddress() async {
    bool serviceEnabled;
    LocationPermission permissionGranted;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted == LocationPermission.denied ||
          permissionGranted == LocationPermission.deniedForever ||
          permissionGranted == LocationPermission.unableToDetermine) {
        return "not addressed";
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    var address = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude));
    return "${address.first.countryName}, ${address.first.locality}";
  }
}
