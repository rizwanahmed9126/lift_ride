import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_login/drawer_screens/your_trips.dart';
import 'package:lift_login/drawer_screens/Help.dart';
import 'package:lift_login/RegisterVehicle/Find_Vehicle.dart';
import 'package:lift_login/screens/Preferences.dart';
import 'package:lift_login/drawer_screens/Settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lift_login/login/Login.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';
import 'package:lift_login/screens/Find_ride.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/models/Utils.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:date_format/date_format.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/screens/Seat_Screen.dart';
import 'package:lift_login/screens/date_time.dart';
import 'package:flutter/services.dart';
import 'package:lift_login/drawer_screens/Components/CustomDrawer.dart';
import 'package:lift_login/RegisterVehicle/components/CustomDropDown.dart';










const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8",);

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  LatLng drop;
  LatLng pick;
  String currentAutofill;
  String _placeDistance;
  double value1=0.0;
  double value2=0.0;
  double totalDistance = 0.0;


  static LatLng _initialPosition;

  final _pickup = TextEditingController();
  final _destination = TextEditingController();


  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> matching = [];
  List<LatLng> polylineCoordinates = [];
  String FirstName;
  PolylinePoints polylinePoints = PolylinePoints();
  String LastName;
  String email;
  String PhoneNumber;
  String googleAPIKey = "AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8";
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  // haversine algorithm

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


  void logout() async {
    Navigator.pop(context);
  }


String rating;


  void profile() async{
    await Firestore.instance.collection("Users")
        .where('PhoneNumber',isEqualTo:decision.phoneNumber
    )
        .getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        FirstName=result.data['Name'];
        LastName=result.data['LastName'];
        email=result.data['Email'];
        PhoneNumber=result.data['PhoneNumber'];
        rating=result.data['Rating'];
        OfferRide.rating=result.data['Rating'];


      });
    });

  }
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/destination_map_marker.png');
  }




  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    currentAutofill= '${first.featureName},${first.thoroughfare},${first.subLocality},${first.subAdminArea}, ${first.adminArea},';
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      pick=_initialPosition;
      _pickup.text=currentAutofill;
      _destination.text='FAST - National University of Computer & Emerging Sciences, National Highway 5, Shah Latif Town, Karachi';

    });
  }



  @override
  void initState()
  {
    super.initState();
    _getUserLocation();
    setSourceAndDestinationIcons();
    profile();

    //pick=LatLng(24.795159829736473, 67.04149674706026);
    //drop=LatLng(24.864116017083557, 67.07496813680505);
  }




  bool widgetVisible = false ;
  bool widgetHide = true ;
  bool submit =false;

  void showWidget(){
    setState(() {
      widgetVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      widgetHide = false ;
    });
  }
  void showSubmitWidget(){
    setState(() {
      submit = true;
    });
  }
  void hideSubmitWidget(){
    setState(() {
      submit = false;
    });
  }
  GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));
    return Scaffold(
      key: scaffoldkey,
      appBar: PreferredSize(
        child: Container(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            //brightness: Brightness.light,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(1.0,12.0),
                    blurRadius: 50,
                    spreadRadius: 40
                ),
              ]
          ),

        ),
        preferredSize:  Size(MediaQuery.of(context).size.width, 1),
      ),


      drawer: FirstName == null ? Container(child: Center(child: CircularProgressIndicator()),): CustomDrawer(
        name: FirstName,
        email: email,
        title1: 'YourTrips',
        title2: 'Help',
        title3: 'Settings',
        title4: 'Logout',
        title5: 'Preferences',
        pushHelp: '/help',
        pushHistory: '/Trips',
        pushLogout: '/logout',
        pushPreferences: '/Preference',
        pushSettings: '/setting',
      ),
      body: _initialPosition == null ? Container(child: Center(child: CircularProgressIndicator()),): Container(
        child:
        Stack(children: <Widget>[

          GoogleMap(
              myLocationEnabled: false,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,

              initialCameraPosition: CameraPosition(

                zoom: CAMERA_ZOOM,
                bearing: CAMERA_BEARING,
                tilt: CAMERA_TILT,
                target: _initialPosition,

              ),
              onMapCreated: onMapCreated),
          Positioned(
              top: 15,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(1,0.7),
                          blurRadius: 6,
                          spreadRadius: 0.5
                      ),
                    ]
                ),

                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,


                  child: IconButton(
                    icon: Icon(Icons.menu),
                    disabledColor: Colors.white,
                    //color: Colors.black,
                    onPressed: () {
                      scaffoldkey.currentState.openDrawer();
                    },
                  ),
                ),
              )
          ),



          Positioned(
            top:70,
            child: Container(
              height: 50,
              width: 320,
              //color: Colors.white,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                   color: Colors.white,
              ),

              margin: EdgeInsets.only(left: 20,right: 30),
              child: TextFormField(
               // initialValue: currentAutofill,
                controller: _pickup,
                    onTap: () async {
                      showWidget();
                      hideSubmitWidget();
                      polylineCoordinates.clear();
                      _polylines.clear();
                      _markers.clear();
                      Prediction p = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleAPIKey,
                        mode: Mode.fullscreen, // Mode.fullscreen
                        language: "en",
                        components: [Component(Component.country,"pk")],

                      );
                      displayPrediction1(p);
                      PlacesDetailsResponse detail =
                          await _places.getDetailsByPlaceId(p.placeId);
                      double lat1 = detail.result.geometry.location.lat;
                      double lng1 = detail.result.geometry.location.lng;
                      //pick=LatLng(lat1,lng1);
                      pick= _initialPosition;   //LatLng(24.795159829736473, 67.04149674706026);

                    },
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 10, right: 10,bottom: 15),
                        width: 7,
                        height: 7,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                        ),
                      ),
                      hintText: "Pick Up",
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      contentPadding: EdgeInsets.only(left: 20.0, top: 15.0,),
                    ),
                  ),
            ),
          ),


          Visibility(
            visible: widgetVisible,
            child: Positioned(
              top: 120,
              child: Container(
                height: 40,
                width: 320,
                color: Colors.white,
                margin: EdgeInsets.only(left: 20,right: 30),
                child: Row(
                  children: [
                    Container(
                      //height: 70,
                      width: 2,
                      color: Colors.redAccent,
                      margin: EdgeInsets.only(left: 20,),
                    ),
                    Container(
                      height: 2,
                      width: 260,
                      color: Colors.grey[200],
                      margin: EdgeInsets.only(left: 20,bottom: 15),
                    )
                  ],
                ),
              ),
            ),
          ),


          Visibility(
            visible: widgetVisible,
            child: Positioned(

              top:150,
              child: Container(
                height: 45,
                width: 320,
                color: Colors.white,

                margin: EdgeInsets.only(left: 20,right: 30),
                child: TextFormField(
                  controller: _destination,
                  onTap: () async {
                    showWidget();
                    hideSubmitWidget();
                    polylineCoordinates.clear();
                    _polylines.clear();
                    _markers.clear();

                   // polylineCoordinates.clear();
                    Prediction p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: googleAPIKey,
                      mode: Mode.fullscreen, // Mode.fullscreen
                      language: "en",
                      components: [Component(Component.country,"pk")],

                    );
                    displayPrediction(p);
                    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
                    double lat1 = detail.result.geometry.location.lat;
                    double lng1 = detail.result.geometry.location.lng;
                    //drop=LatLng(lat1,lng1);
                    drop=LatLng(24.857015887320756, 67.2646838017071);
                  },
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20,),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.local_taxi,
                        color: Colors.redAccent,
                      ),
                    ),
                    hintText: "destination",
                    //filled: true,
                    //fillColor: Colors.grey[200],
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),
                    ),
                    contentPadding:
                    EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10),
                  ),
                ),
              ),
            ),
          ),

          Visibility(
            visible: widgetHide,
            child: Positioned(
              top: 630,
              child:Container(
                height: 45,
                width: 330,
                margin: EdgeInsets.only(left: 20,top: 20),
                child:FlatButton(
                  child: Text("Confirm Pickup"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: (){
                    showWidget();
                    hideWidget();
                    },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widgetVisible,
            child: Positioned(
              top: 630,
              child:Container(
                height: 45,
                width: 330,
                margin: EdgeInsets.only(left: 20,top: 20),
                child:FlatButton(
                  child: Text("Drop off"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: (){

                    //pick=LatLng(24.795159829736473, 67.04149674706026);
                    pick= _initialPosition;
                    drop=LatLng(24.857015887320756, 67.2646838017071);

                    showSubmitWidget();
                    if(_pickup!=null && _destination!=null) {
                      setMapPins();
                      setPolylines();
                    }
                    else{
                      polylineCoordinates.clear();


                    }



                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          ),


          Visibility(
            visible: submit,
            child: Positioned(
              top: 630,
              child:Container(
                height: 45,
                width: 330,
                margin: EdgeInsets.only(left: 20,top: 20),
                child:FlatButton(
                  child: Text("Submit"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: (){
                    OfferRide.pickup=_pickup.text;
                    OfferRide.destination=_destination.text;
                    OfferRide.rating=rating;


                    OfferRide.firstName=FirstName;
                    OfferRide.phoneNumber=PhoneNumber;
                    upload_trip_coord();

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> RegisterVehicle()));

                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          )


        ]
        ),
      ),





    );
  }


  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      var address=detail.result.formattedAddress;


      setState(() {
        _destination.text=address;

      });

    }
  }

  Future<Null> displayPrediction1(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      var address=detail.result.formattedAddress;


      setState(() {
        _pickup.text=address;

      });

    }
  }


  void onMapCreated(GoogleMapController controller) async{
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    decision.start=pick;
    decision.end=drop;
    setState(() {

      _markers.add(Marker(
          markerId: MarkerId('$pick'),
          position: pick,
          icon: sourceIcon));

      _markers.add(Marker(
          markerId: MarkerId('$drop'),
          position: drop,
          icon: destinationIcon));
    });
  }

  setPolylines() async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
      googleAPIKey,

      pick.latitude,
      pick.longitude,


      drop.latitude,
      drop.longitude,


    );


    if (result.isNotEmpty) {

      //polylineCoordinates.clear();
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        //matching.add(LatLng(point.latitude,point.longitude));
      });
    }
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,

      );
    }
    // for(int i =4; i<polylineCoordinates.length-3;i++)
    // {
    //   value1= polylineCoordinates[i].latitude;
    //   value2= polylineCoordinates[i].longitude;
    //   //matching.add();
    // }
    // print(matching);







    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Colors.redAccent,
          points: polylineCoordinates,
          width: 3
      );
      _placeDistance = totalDistance.toStringAsFixed(2);
      print('-------DISTANCE: $_placeDistance km------------------------');
      double fare=totalDistance*7;
      decision.CalFare=fare.toInt();
      _polylines.add(polyline);


    });
  }

  void upload_trip_coord() async{

    OfferRide.polylineCoordinates1=polylineCoordinates;



  }
}












