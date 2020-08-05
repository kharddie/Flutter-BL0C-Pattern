import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  static final location = Location();
  LatLng latlng;
  LocationData _locationData;

//Get User location
  Future<LocationData> getUserLocation() async {
    _locationData = await location.getLocation();
    return _locationData;
  }

/*
//Get User location stream
  Stream<LatLng> getUserLocationStream() {
    _userLocationStream = location.onLocationChanged.listen((locationData) {
      return LatLng(locationData.latitude, locationData.longitude);
    });
  }
*/

}
