import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/geolocator_service.dart';

class LiveLocationTracking extends StatefulWidget {
  final Position initPosition;

  LiveLocationTracking(this.initPosition);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<LiveLocationTracking> {
  final GeolocatorService geoService = GeolocatorService();

  _runRoute() {
    return null;
  }

  @override
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
                mapType: MapType.satellite,
                myLocationEnabled: true,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _runRoute(),
        child: Text("Go"),
        tooltip: "Start navigation",
      ),
    );
  }
}
