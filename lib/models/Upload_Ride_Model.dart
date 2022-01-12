import 'package:google_maps_flutter/google_maps_flutter.dart';



class OfferRide{
  static String firstName;
  static String lastName;
  static String phoneNumber;
  static String rating;
  static String date;
  static String time;
  static String seats;
  static String fare;
  static String pickup;
  static String destination;
  static String numberplate;
  static String model;
  static String brand;
  static String documentID;
  static List<LatLng> polylineCoordinates1 = [];
}

class decision{
  static String phoneNumber="";
  static int CalFare;
  static int totalDisatnce;

  static LatLng start;
  static LatLng end;

  static LatLng destinationLatLng;

}

class FindRideData{
  static int fareToShow;
}



class documentid{
  static String id;

}

