import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/Login_screen.dart';
import 'package:flutter_bloc_pattern/bloc_pattern.dart';
import 'package:flutter_bloc_pattern/home_page.dart';
import 'package:flutter_bloc_pattern/screens/liveLocationTracking.dart';
import 'package:flutter_bloc_pattern/services/geolocator_service.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geoService = GeolocatorService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        routes: {
          'login': (context) => LoginScreen(),
          'bloc_pattern': (context) => BlocPattern(),
          'live_location_tracking': (context) {
            return FutureProvider<Position>(
              create: (context) => geoService.getInitialLocation(),
              child: Consumer<Position>(
                builder: (context, position, widget) {
                  return (position != null
                      ? LiveLocationTracking(position)
                      : Center(
                          child: CircularProgressIndicator(),
                        ));
                },
              ),
            );

            // return LiveLocationTracking(null);
          },
        },
        theme: ThemeData(
          fontFamily: 'Nunito',
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.black87),
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              bodyText1: TextStyle(fontSize: 18),
              bodyText2: TextStyle(fontSize: 16),
              button:
                  TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
              headline5: TextStyle(fontWeight: FontWeight.bold),
              subtitle1: TextStyle(color: Colors.red)),
        ),
        home: HomePage(),
      ),
    );
  }
}
