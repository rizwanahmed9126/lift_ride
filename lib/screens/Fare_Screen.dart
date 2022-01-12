import 'package:flutter/material.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/screens/Seat_Screen.dart';
import 'package:lift_login/drawer_screens/your_trips.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FareDisplay extends StatefulWidget {


  @override
  _FareDisplayState createState() => _FareDisplayState();
}

class _FareDisplayState extends State<FareDisplay> {

  int _counter = decision.CalFare;
  //int _counter=170;
  var _phoneController = TextEditingController();

  Firestore db = Firestore.instance;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  void _decreaseCounter() {
    setState(() {

      _counter--;
    });
  }

  postTripDetails(){

    print("this is rating at the time of upload-------------${OfferRide.rating}");
    DocumentReference docRef = db.collection('PostedTrips').document();

    db.collection('PostedTrips').document(docRef.documentID).collection('UserData').add({
        for(int i=0; i<OfferRide.polylineCoordinates1.length;i++)
          'point$i': new GeoPoint(OfferRide.polylineCoordinates1[i].latitude, OfferRide.polylineCoordinates1[i].longitude),

      });

    //documentid.id
    db.collection('PostedTrips').document(docRef.documentID).setData({
      'FirstName':OfferRide.firstName,
      'Rating':OfferRide.rating,
      'Fare': OfferRide.fare,
      'BookedSeats':'0',
      'Date':OfferRide.date,
      'Time':OfferRide.time,
      'Pick':OfferRide.pickup,
      'Destination':OfferRide.destination,
      'PhoneNumber': decision.phoneNumber,
      'CarBrand':OfferRide.brand,
      'CarNumber':OfferRide.numberplate,
      'CarModel':OfferRide.model,
      'Seats':OfferRide.seats,


    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          OfferRide.fare=_counter.toString();

          postTripDetails();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TripsDetails(),

          ));
        },
        child: Icon(Icons.arrow_forward_outlined),
        backgroundColor: Colors.redAccent,
      ),
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
      body: Column(

        children: [

            Container(
              margin: EdgeInsets.only(top: 60),
              child: Text("Trip Fare",
                textAlign: TextAlign.right,

                style: TextStyle(fontSize: 25),),
            ),

          SizedBox(height: 20,),

           Text("Our Suggested Fare For Your Trip is",style: TextStyle(fontSize: 15, color: Colors.grey[600]),),

          SizedBox(height: 150,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Container(
                  child: RawMaterialButton(
                    onPressed: () {
                      _incrementCounter();
                      _phoneController.text='$_counter';
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 25.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
              ),
             SizedBox(width: 15,),
             Container(

               height: 30,
               width: 130,
               child:  TextFormField(
                 //initialValue:"$_counter",
                 controller: TextEditingController(text: '$_counter'),
                 //maxLines: 1,
                 style: TextStyle(fontSize: 65),


                   )
               ),

              SizedBox(width: 15,),

              Container(
                  child: RawMaterialButton(
                    onPressed: () {
                      _decreaseCounter();
                      _phoneController.text='$_counter';
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.remove,
                      size: 25.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
              )

            ],
          ),


        ],
      ),
    );
  }
}
