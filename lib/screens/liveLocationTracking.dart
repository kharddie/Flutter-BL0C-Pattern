import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../services/geolocator_service.dart';

import 'package:geolocator/geolocator.dart';

class LiveLocationTracking extends StatefulWidget {
  final Position initPosition;
  LiveLocationTracking(this.initPosition);

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<LiveLocationTracking> {
  final GeolocatorService geoService = GeolocatorService();

  StreamSubscription _locationSubscription;
  var _currentIndex = 0;
  Location _location = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  Future<Uint8List> _getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/car_yellow_lr.png");
    print('0000000 running _getMarker');
    // print(byteData.buffer.asUint8List());
    return byteData.buffer.asUint8List();
  }

  Future<LocationData> getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    var currentLocation;

    _serviceEnabled = await _location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        print("Location service is not available = $_serviceEnabled");
        return null;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("Location service is not granted= $_permissionGranted");
        return null;
      }
    }

    print(
        '--------------------------------------------------perisions granted');
    currentLocation = await _location.getLocation();
    print(
        '--------------------------------------------------Location resullts = $currentLocation');

    return currentLocation;
  }

  getUserLocationStream(Uint8List carData) {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }

    _locationSubscription = _location.onLocationChanged.listen((newLocalData) {
      if (_controller != null) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
                tilt: 25,
                zoom: 18.00)));
        _updateMarkerAndCircle(newLocalData, carData);
      }
    });
  }

  Future<Uint8List> getCarData() async {
    Uint8List imageData;
    print('start navigation1110000000000000000000000000');
    imageData = await _getMarker();
    print('Awaiting imageData...');
    //print(imageData);
    print('-----------end get car data---------------');
    return imageData;
  }

  Future<void> startNavigation() async {
    var carData = await getCarData();
    print('Awaiting locationData...1');
    var newLocationData = await getUserLocation();
    print('Awaiting locationData...2');
    print('---- new location date = $newLocationData');
    _updateMarkerAndCircle(newLocationData, carData);

    getUserLocationStream(carData);
  }

  _setInitialPosition() {
    print('set initial positions');
  }

  void _updateMarkerAndCircle(
      LocationData newLocationData, Uint8List imageData) {
    print('');
    print('');
    print(
        '---------------- inside _ updateMarkerAndCircle newLocationData.latitude = ${newLocationData.latitude} newLocationData.latitude = ${newLocationData.latitude}newLocationData.heading = ${newLocationData.heading}  newLocationData.accuracy = ${newLocationData.accuracy} imageData=$imageData');

    LatLng latlng = LatLng(newLocationData.latitude, newLocationData.longitude);

    this.setState(() {
      Marker(
        markerId: MarkerId("yellow_car"),
        position: latlng,
        rotation: newLocationData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
      );

      Circle(
        circleId: CircleId("yellow_car_circle"),
        radius: newLocationData.accuracy,
        zIndex: 1,
        strokeColor: Colors.pink[200],
        center: latlng,
        fillColor: Colors.pink[200].withAlpha(70),
      );
    });
  }

  @override
  void didUpdateWidget(LiveLocationTracking oldWidget) {
    print('oldWidget ===== $oldWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Live Location Tracking",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: StreamBuilder<Position>(
        stream: geoService.getCurrentLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Center(
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.initPosition.latitude,
                      widget.initPosition.longitude),
                  zoom: 18.0,
                  bearing: 15.0, // 1
                  tilt: 75.0, // 2
                ),
                zoomControlsEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                mapType: MapType.satellite,
                markers: Set.of((marker != null) ? [marker] : []),
                circles: Set.of((circle != null) ? [circle] : []),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                }),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 21.0,
        unselectedFontSize: 20.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text("Ready"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            title: Text("Start"),
          ),
        ].toList(),
        onTap: (int indx) {
          switch (indx) {
            case 0:
              startNavigation();
              break;
            case 1:
              _setInitialPosition();
              break;
          }
        },
      ),
/*
      floatingActionButton: FloatingActionButton(
        onPressed: () => _runRoute(),
        child: Text("Goo"),
        tooltip: "Start navigation",
      ),
*/
    );
  }
}
