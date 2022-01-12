import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_login/screens/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:intl/intl.dart';
import 'package:lift_login/screens/ManageUploadedTrips.dart';

class TripsDetails extends StatefulWidget {
  @override
  _TripsDetailsState createState() => _TripsDetailsState();
}

class _TripsDetailsState extends State<TripsDetails> {

  Widget icontext( String name, IconData icon){
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(icon,size: 17),
            ),
          ),
          TextSpan(text: name,style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
  Widget title(String name){
    return  Text(name,style: TextStyle(fontSize: 20,),);
  }





  Widget showRide(String name, String fare,String rating,String date,String time,String seats,String pickup,String destination,String bookSeats) {
    return  GestureDetector(
      onTap: (){

        print('this is our pickup-------$pickup');
        print('this is our destination-------$destination');

        int remainingSeats=int.parse(seats)-int.parse(bookSeats);
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> ManageUploadedTrips(seats: int.parse(seats),pick: pickup,destination: destination,remainingSeats:remainingSeats,bookedSeats: int.parse(bookSeats),)
        ));

      },
      child: Card(
          child: Column(
            children: [

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/car.png'),
                    ),
                  ),
                  SizedBox(width: 20,),
                  title(name),
                  SizedBox(width: 90,),
                  title(fare),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 7,bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    icontext(pickup, Icons.location_on),
                    SizedBox(height: 5,),
                    icontext(destination, Icons.local_taxi)
                  ],
                ),
              ),

              Divider(height: 2,),
              Padding(
                padding: const EdgeInsets.only(bottom: 15,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    icontext(rating, Icons.star),
                    icontext(time, Icons.alarm),
                    icontext(date, Icons.calendar_today),
                    icontext(seats, Icons.airline_seat_recline_extra_sharp),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  Widget showPostedTrips(){
     return StreamBuilder(
         stream: Firestore.instance.collection('PostedTrips').where('PhoneNumber', isEqualTo: decision.phoneNumber
         ).snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(!snapshot.hasData){
             return Center(
               child:CircularProgressIndicator(),
             );
           }
           return ListView(
             children: snapshot.data.documents.map((document){

               return showRide(document['FirstName'], document['Fare'], document['Rating'], document['Date'], document['Time'],
                   document['Seats'], document['Pick'], document['Destination'],document['BookedSeats']);

             }).toList(),

           );

         }
     );
  }

  Future<void> batchDelete() {
    var now = new DateTime.now();
    String formatter = new DateFormat('M/dd/yyyy').format(now);

    WriteBatch batch = Firestore.instance.batch();

    return  Firestore.instance.collection('PostedTrips').where('Date', isLessThan: formatter ).getDocuments().then((querySnapshot) {

      querySnapshot.documents.forEach((document) {
        batch.delete(document.reference);
      });

      return batch.commit();
    });
  }

  @override
  void initState() {

    super.initState();
   // batchDelete();
  }





  @override
  Widget build(BuildContext context) {
     return
    DefaultTabController(
      length: 2,

      child: Scaffold(
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
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>Home()
              ));

            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Posted',style: TextStyle(color: Colors.black),),
              ),
              Tab(
                child: Text('History',style:TextStyle(color: Colors.black),),
              )
            ],
          ),
        ),
        body:TabBarView(
          children: [

            Container(

             child: showPostedTrips(),
            ),
            Container(

              child: Column(
                children: [



                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}

