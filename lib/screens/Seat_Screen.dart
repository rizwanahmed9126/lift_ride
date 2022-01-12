import 'package:flutter/material.dart';
import 'package:lift_login/screens/Fare_Screen.dart';
import 'package:lift_login/screens/Home.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/RegisterVehicle/Find_Vehicle.dart';
import 'package:provider/provider.dart';
import 'package:lift_login/Providers/Providers.dart';
import 'package:lift_login/models/OfferRide.dart';
import 'package:google_maps_webservice/places.dart';













class SeatScreen extends StatefulWidget {

  @override
  _SeatScreenState createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {







   int _counter=1;



   void _incrementCounter() {
     if(_counter< SeatsModel.seats)
        setState(() {

          _counter++;
        });
   }
   void _decreaseCounter() {
     if(_counter<=SeatsModel.seats && _counter>1)
        setState(() {

          _counter--;
        });
   }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){



          OfferRide.seats=_counter.toString();


          Navigator.push(context, MaterialPageRoute(builder: (context)=>FareDisplay()));
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.arrow_forward, color: Colors.white, ),

      ),
      appBar:AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0.0,

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
            child: Text("Select Seats",
              textAlign: TextAlign.right,

              style: TextStyle(fontSize: 25),),
          ),

          SizedBox(height: 20,),

          Text("Select your available seats",style: TextStyle(fontSize: 15, color: Colors.grey[600]),),

          SizedBox(height: 150,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Container(
                  child: RawMaterialButton(
                    onPressed: () {
                      _incrementCounter();
                      //_phoneController.text='$_counter';
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

                  //height: 30,
                  //width: 130,
                  child: Text('$_counter', style: TextStyle(fontSize: 65),


                  )
              ),

              SizedBox(width: 15,),

              Container(
                  child: RawMaterialButton(
                    onPressed: () {
                      _decreaseCounter();
                     // _phoneController.text='$_counter';
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




