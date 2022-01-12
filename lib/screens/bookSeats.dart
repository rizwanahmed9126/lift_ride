import 'package:flutter/material.dart';
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
import 'package:lift_login/screens/Preferences.dart';
import 'package:lift_login/drawer_screens/Settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lift_login/login/Login.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';
import 'package:lift_login/screens/Find_ride.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/models/FindRide.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class BookSeats extends StatefulWidget {

  final String availableSeats;
  final int farePerSeat;
  final String travelTime;
  final String travelDate;
  final String name;
  final String pick;
  final String destination;



  BookSeats({
    this.availableSeats,
    this.farePerSeat,
    this.name,
    this.travelDate,
    this.travelTime,
    this.pick,
    this.destination

});

  @override
  _BookSeatsState createState() => _BookSeatsState();
}

class _BookSeatsState extends State<BookSeats> {
  int _counter=1;
 // int availableSeats=widget.availableSeats;
  int farePerSeat=FindRideData.fareToShow;
  int totalFare=0;






  void bookSeats()
  {
    if(int.parse(widget.availableSeats)==0)
    {
      print('sorry no availble seats');


    }
    else {
      print('entered in book seats');
      Firestore.instance.collection('PostedTrips').where(
          'phoneNumber', isEqualTo: FetchFindRideData.phoneNumber)
          .getDocuments().then((value) {
        value.documents.forEach((element) {
          Firestore.instance.collection('PostedTrips').document(
              element.documentID).updateData({
            'BookedSeats': '$_counter'
          });
        });
      });
      print('finished');
    }
    
  }


  void _incrementCounter() {
    if(_counter< int.parse(widget.availableSeats))
      setState(() {

        _counter++;
        totalFare=_counter*farePerSeat;
      });
  }
  void _decreaseCounter() {
    if(_counter>1)
      setState(() {

        _counter--;

        totalFare=_counter*farePerSeat;
      });
  }

  @override
  void initState() {
    super.initState();
    totalFare=farePerSeat;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);

            },
          ),
        ),
      body:SingleChildScrollView(
        child: Stack(
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 50,top: 15),
              child: Text('${widget.pick}',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black)),

            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 15),
              child: Column(
                children: [

                  Icon(Icons.stop,size: 10,color: Colors.blue,),
                  Container(
                    height: 50,
                    width: 2,

                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue,
                            Colors.red,
                          ],
                        )
                    ),
                  ),

                    Icon(Icons.stop,size: 14,color: Colors.red,),


                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50,top: 75),
              child: Text('${widget.destination}',overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black)),


            ),

            //SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.only(top: 150,left: 20),
              child: Container(
                height: 200,
                width: 325,
                child: GoogleMap(
                    myLocationEnabled: false,
                    compassEnabled: false,
                    tiltGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    //markers: _markers,
                    //polylines: _polylines,
                    mapType: MapType.normal,

                    initialCameraPosition: CameraPosition(

                      zoom: CAMERA_ZOOM,
                      bearing: CAMERA_BEARING,
                      tilt: CAMERA_TILT,
                      target: LatLng(24.795861248037244, 67.04488699728579),

                    ),
                   // onMapCreated: onMapCreated
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 370,left: 10,right: 10),
              child: Column(

                children: [
                 row('Ride Offer Name:', '${widget.name}'),
                  row('Travel Date:', '${widget.travelDate}'),
                  row('Travel Time:', '${widget.travelTime}'),
                  row('Fare Per Seat:', '${FindRideData.fareToShow}'),
                  row('Available Seats:', '${widget.availableSeats}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 600,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Book your Seats',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          child: RawMaterialButton(
                            onPressed: () {
                              _incrementCounter();

                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 15.0,
                            ),
                            //padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                          )
                      ),

                      Container(

                          child: Text('$_counter', style: TextStyle(fontSize: 25),)
                      ),

                      Container(

                          child: RawMaterialButton(
                            onPressed: () {
                              _decreaseCounter();
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.remove,
                              size: 15.0,
                            ),
                           // padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                          )
                      )

                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 670,left: 200),
              child: Container(

               child:Text('Total Rs: $totalFare',style: TextStyle(fontSize: 25),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 730,left: 10,right: 10,bottom: 15),
              child: Container(
                height: 50,
                width: 350,
                child: FlatButton(
                  child: Text("Confirm your Booking"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: (){
                    if(int.parse(widget.availableSeats)==0)
                      showAlertDialog(context, 'Sorry', 'No available Seats!!');

                    else {
                      bookSeats();
                      showAlertDialog(
                          context, 'Booking', 'Seats Booked Successfully');
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=>Preferences()
                      ));
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            )





           ]
        ),
      )

    );
  }
}
Widget row(String title,String value){
  return  Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        Text(value,style: TextStyle(fontSize: 17,),)
      ],
    ),
  );

}

showAlertDialog(BuildContext context,String title,String content,) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [

          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();

            },
          )
        ],
      );
    },
  );
}



