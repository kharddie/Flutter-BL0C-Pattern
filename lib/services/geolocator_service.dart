import 'package:geolocator/geolocator.dart';
import 'dart:async';

import '../services/location_service.dart';

class GeolocatorService {
  final Geolocator geo = Geolocator();
  LocationService locationService = LocationService();
  Position initPosition;
  Position position;

  Stream<Position> getCurrentLocation() {
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    return geo.getPositionStream(locationOptions);
  }

  Future<Position> getInitialLocation() async {
    return geo.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
