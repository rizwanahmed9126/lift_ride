import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lift_login/components/CustomAlterDialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:lift_login/models/OfferRide.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(24.79437569709072, 67.13462938615491);
const LatLng DEST_LOCATION = LatLng(24.79437569709072, 67.13462938615491);


//24.79437569709072, 67.13462938615491
class Tracking extends StatefulWidget {
//   final LatLng pick;
//   final LatLng destination;
//
//   const Tracking({
//     this.pick,
//     this.destination,
// });

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {



  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = "AIzaSyBRPSKiIDzNKJyYY7WX0PWir7zcy0MLJf4";
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;

  @override
  void initState() {
    super.initState();
    location = new Location();
    polylinePoints = PolylinePoints();
    print('this is pick up---------------${TrackingLatLng.pickup}');
    print('this is pick up---------------${TrackingLatLng.destination}');
    location.onLocationChanged().listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();

    var a=2;
    var b=2;

   // if(a==b)



  }
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/driving_pin.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }
  void setInitialLocation() async {
    currentLocation = await location.getLocation();

    destinationLocation = LocationData.fromMap({
      "latitude": TrackingLatLng.destination.latitude,
      "longitude": TrackingLatLng.destination.longitude
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: TrackingLatLng.pickup
    );
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude,
              currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING
      );
    }
    return Scaffold(
      body: TrackingLatLng.destination==null?Container():Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                showPinsOnMap();
              }),

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              color: Colors.amber,
              child: FlatButton(
                onPressed: (){
                  showAlertDialog(context);

                },
                child: Text("Rate this Ride",style: TextStyle(),),
                textColor: Colors.white,
               // color: Colors.amber,
              ),
            ),
          )
        ],
      ),
    );
  }





  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude,
          currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      // updated position
      var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
      var destination= LatLng(TrackingLatLng.destination.latitude,TrackingLatLng.destination.longitude);




      _markers.removeWhere(
              (m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition, // updated position
          icon: sourceIcon
      ));
    });
  }
  void showPinsOnMap() {
    var pinPosition = LatLng(currentLocation.latitude,
        currentLocation.longitude);
    var destPosition = LatLng(destinationLocation.latitude,
        destinationLocation.longitude);
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon
    ));
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon
    ));
    setPolylines();
  }
  void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);
    if(result.isNotEmpty){
      result.forEach((PointLatLng point){
        polylineCoordinates.add(
            LatLng(point.latitude,point.longitude)
        );
      });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates
        ));
      });
    }
  }
}

showAlertDialog(BuildContext context) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Rate This Ride"),
    content: Container(

      child: SmoothStarRating(
        //rating: value,
        isReadOnly: false,
        size: 40,
        filledIconData: Icons.star,
        color: Colors.green,
        borderColor: Colors.green,
        halfFilledIconData: Icons.star_half,
        defaultIconData: Icons.star_border,
        starCount: 5,
        allowHalfRating: true,
        spacing: 2.0,
        onRated: (value) {
          print("rating value -> $value");
          // print("rating value dd -> ${value.truncate()}");
        },
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
