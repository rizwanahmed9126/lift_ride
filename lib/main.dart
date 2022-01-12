import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lift_login/login/Login.dart';
import 'package:lift_login/screens/Destination_search.dart';
import 'package:lift_login/screens/Preferences.dart';
import 'package:lift_login/login/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_map_polyutil/google_map_polyutil.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:lift_login/screens/Find_ride.dart';
import 'package:lift_login/screens/Home.dart';
import 'package:lift_login/screens/Fare_Screen.dart';
import 'package:lift_login/screens/date_time.dart';
import 'package:lift_login/screens/Seat_Screen.dart';
import 'package:lift_login/drawer_screens/your_trips.dart';
import 'package:lift_login/drawer_screens/Help.dart';
import 'package:lift_login/drawer_screens/Settings.dart';
import 'package:lift_login/FindRide/HomeRide.dart';
import 'package:lift_login/screens/Preferences.dart';
import 'package:lift_login/login/Register.dart';
import 'package:lift_login/splash_and_slider/Splash_Screen.dart';
import 'package:provider/provider.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/Providers/Providers.dart';
import 'package:lift_login/location_tracking.dart';
import 'package:lift_login/login/middle_login_home.dart';
import 'package:lift_login/screens/bookSeats.dart';
import 'package:lift_login/RegisterVehicle/RegisterBike.dart';
import 'package:lift_login/RegisterVehicle/RegisterCar.dart';
import 'package:lift_login/RegisterVehicle/Find_Vehicle.dart';
import 'package:lift_login/screens/ManageUploadedTrips.dart';






void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Preferences(),


      routes: {
        '/Trips':(ctx)=>TripsDetails(),
        '/setting':(ctx)=>Settings(),
        '/help':(ctx)=>Help(),
        '/Preference':(ctx)=>Preferences(),
        '/logout':(ctx)=>LoginScreen(),
        '/BookSeats':(ctx)=>BookSeats()

      },
    );
  }
}
