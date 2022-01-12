import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_login/location_tracking.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lift_login/models/OfferRide.dart';
import 'package:lift_login/drawer_screens/your_trips.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyBRPSKiIDzNKJyYY7WX0PWir7zcy0MLJf4",);

class ManageUploadedTrips extends StatefulWidget {
  final int seats;
  final int bookedSeats;
  final String pick;
  final String destination;
  final int remainingSeats;

  const ManageUploadedTrips({
    Key key,
    this.bookedSeats,
    this.seats,
    this.destination,
    this.pick,
    this.remainingSeats,
}):super(key: key);

  @override
  _ManageUploadedTripsState createState() => _ManageUploadedTripsState();
}

class _ManageUploadedTripsState extends State<ManageUploadedTrips> {

  LatLng pick;
  LatLng destination;



  getLatlng() async{




    final queryPick = widget.pick;
    final queryDestination=widget.destination;





    var addressesPick = await Geocoder.local.findAddressesFromQuery(queryPick);
    var addressesDestination = await Geocoder.local.findAddressesFromQuery(queryDestination);

    var first = addressesPick.first;
    var second = addressesDestination.first;


    pick=LatLng(first.coordinates.latitude,first.coordinates.longitude);
    destination=LatLng(second.coordinates.latitude,second.coordinates.longitude);

    print('function----------------$pick');
    print('function--------------$destination');

    TrackingLatLng.pickup=pick;
    TrackingLatLng.destination=destination;


  }

  void delete() async{
    await Firestore.instance.collection('PostedTrips').where('PhoneNumber',isEqualTo: decision.phoneNumber).
    getDocuments().then((value){
      value.documents.forEach((element) {
        Firestore.instance.collection('PostedTrips').document(element.documentID).collection('UserData').document().delete();
        Firestore.instance.collection('PostedTrips').document(element.documentID).delete();

      });

      
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatlng();
  }


  GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldkey,
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
                        height: size.height*0.07,
                        width: size.width*0.004,

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
                  padding: const EdgeInsets.symmetric(vertical: 170),
                  child: Column(

                    children: [
                      row('Uploaded seats:', '${widget.seats}'),
                      row('Booked seats:', '${widget.bookedSeats}'),
                      row('Remaining seats:', '${widget.remainingSeats}'),

                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 540),
                  child: Column(
                    children: [
                      Container(
                        height: size.height*0.07,
                        width: size.width*1,
                        child: FlatButton(
                          child: Text("Start Ride"),
                          textColor: Colors.white,
                          color: Colors.grey[400],
                          onPressed: (){
                            print('$pick--------pick');
                            print('des-----------$destination');
                            getLatlng();
                            if(pick==null)
                            {
                              print('still null-------------------------------------');

                            }

                            else {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      Tracking(
                                      //  pick: pick, destination: destination,
                                      )));
                            }
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                      SizedBox(height: size.height*0.01,),
                      Container(
                        height: size.height*0.07,
                        width:  size.width*1,
                        child: FlatButton(
                          child: Text("Delete Ride"),
                          textColor: Colors.white,
                          color: Colors.redAccent,
                          onPressed: (){


                            delete();
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=>TripsDetails()
                            ));

                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                    ],
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
