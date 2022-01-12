import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:lift_login/screens/Home.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/models/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_map_polyutil/google_map_polyutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/models/DisplayMatchRides.dart';
import 'package:lift_login/models/FindRide.dart';

class FindRide extends StatefulWidget {
  final Data data;
  FindRide({Key key, this.data}) : super(key: key);

  @override
  _FindRideState createState() => _FindRideState();
}

class _FindRideState extends State<FindRide> {
  List<LatLng> polyLinesLatLongs = [];

  bool source;
  bool destination;
  List<String> listOfDocument = [];
  int lengthOfCollection;
  int fieldsLength;
  List<String> documentsToShow = [];
  bool checkPath;
  List<String> list1 = [];
  var firestore = Firestore.instance.collection('PostedTrips');

  int count=0;
  getDataFromDB() async {
    //below code get all documents of parent collection from firebase
    await firestore.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        listOfDocument.add(doc.documentID);
      });
    });
    lengthOfCollection = listOfDocument.length;



    for (int k=0; k < lengthOfCollection;k++){
      await firestore.document(listOfDocument[k]).collection('UserData').getDocuments().then((QuerySnapshot snapshot){
        snapshot.documents.forEach((element) {
          list1.add(element.documentID);
        });
      });

    }
    //print('list of child documents --------------------------------------------');
    //print(list1);

    //below code retrieve Latlng into List

    for (int j = 0; j < lengthOfCollection; j++) {

        firestore.document(listOfDocument[j]).collection('UserData').document(list1[j]).get().then((myDocuments) {
        fieldsLength = myDocuments.data.length;

      });
      //  print('these are the documents---------------------------------------------');
      //print(listOfDocument[j]);
      Firestore.instance.collection('PostedTrips').document(listOfDocument[j]).collection('UserData').document(list1[j]).get().then((value) async {
        for (int i = 0; i < fieldsLength; i++) {
          GeoPoint latLng = value.data["point$i"];
          polyLinesLatLongs.add(LatLng(latLng.latitude, latLng.longitude));
        }
        path(polyLinesLatLongs);
        path1(polyLinesLatLongs);
        polyLinesLatLongs = [];
      });
    }

  }



  path(List<LatLng> cord) async {
    //source
    await GoogleMapPolyUtil.isLocationOnPath(
        point:decision.start,
        polygon: cord,
        geodesic: true, tolerance: 1200)
        .then((value) => source = value);

    //print('source-----------------$source');


  }

  path1(List<LatLng> cord) async {

    //destination
    await GoogleMapPolyUtil.isLocationOnPath(
            point: decision.end,
            polygon: cord,
            geodesic: true, tolerance: 1200)
            .then((value) => destination = value);

    //print('destination --------$destination');
    //print(decision.start);
    //print(decision.end);

    if (source == true && destination == true) {
      setState(() {

        documentsToShow.add(listOfDocument[count]);
        count=count+1;

      //  print('new document list which in important---------$documentsToShow');
       // print('$count match routes------------------------------------------');
      });
    }
  }
  @override
  void initState() {
    super.initState();


    getDataFromDB();
  }

  Widget future(int i){
    CollectionReference users = Firestore.instance.collection('PostedTrips');

    return FutureBuilder<DocumentSnapshot>(
      future: users.document(documentsToShow[i]).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> document =snapshot.data.data;
          FetchFindRideData.phoneNumber=document['phoneNumber'];
          return showRide(context,document['FirstName'], document['Fare'], document['Rating'], document['Date'], document['Time'],
              document['Seats'], document['Pick'], document['Destination'], document['BookedSeats']);
        }

        return Text("loading");
      },
    );

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:count == 0 ? Container(child: Center(child: CircularProgressIndicator()),): Column(
         children: [

             for(int i = 0; i < documentsToShow.length; i++)
               future(i),


         ],
       )

    );
  }
}
