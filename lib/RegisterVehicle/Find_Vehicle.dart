import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_login/screens/Home.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/RegisterVehicle/RegisterBike.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/screens/date_time.dart';
import 'package:lift_login/RegisterVehicle/RegisterCar.dart';
import 'package:lift_login/models/OfferRide.dart';

class RegisterVehicle extends StatefulWidget {
  @override
  _RegisterVehicleState createState() => _RegisterVehicleState();
}

class _RegisterVehicleState extends State<RegisterVehicle> {



  String document;
  Future getDocumentID() async {
    await Firestore.instance.collection('Users').where('PhoneNumber', isEqualTo: decision.phoneNumber).getDocuments().then((onValue) {
      onValue.documents.forEach((f) {
        setState(() {
          document=f.documentID;
        });

        OfferRide.documentID=f.documentID;
        print(document);
      });
    });
  }
  @override
  void initState() {
    getDocumentID();
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        title: Text("Select Vehicle",style: TextStyle(color: Colors.black),),
        actions: [
          RaisedButton.icon(
            onPressed: (){
              _showModelSheet();
            },
            icon: Icon(Icons.add),
            label: Text("Add new"),

            color: Colors.white,
            elevation: 0.0,
          ),

      ],
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(

            height: 0.5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,

                  spreadRadius: 0.2,
                  blurRadius: 0.2,
                  offset: Offset(1, 0.5), // changes position of shadow
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(0.5),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),

          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => Home(),
              ),
            );
          },
        ),
      ),
      body:document==null?Container(child: Center(child: CircularProgressIndicator(),),): StreamBuilder(

          stream: Firestore.instance.collection('Users').document(OfferRide.documentID).collection('Vehicle').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child:CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document){
                print('inside list view');
                return showVehicle(document['VehicleBrand'],document['NumberPlate'],document['VehicleModel'],document['Type']);
              }).toList(),

            );

          }
      ) //selectVehicle('Honda','klk-212','Civic'),





);
  }



  // Widget showVehicle(){
  //   getDocumentID();
  //
  //
  //   return StreamBuilder(
  //
  //       stream: Firestore.instance.collection('Users').document(OfferRide.documentID).collection('Vehicle').snapshots(),
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
  //         if(!snapshot.hasData){
  //           return Center(
  //             child:CircularProgressIndicator(),
  //           );
  //         }
  //         return ListView(
  //           children: snapshot.data.documents.map((document){
  //             return showRide(document['VehicleBrand'],document['NumberPlate'],document['VehicleModel'],document['Type']);
  //           }).toList(),
  //
  //         );
  //
  //       }
  //   );
  // }

  Widget showVehicle(String brand, String number,String model,String type) {

    Size size=MediaQuery.of(context).size;
    return
       Card(
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 8),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/car.png'),
                    ),
                  ),
                 // SizedBox(width: size.width*0.07,),
                  Text(brand,style: TextStyle(fontSize: 30,),),
                 // SizedBox(width: size.width*0.2,),
                  FlatButton(

                      child: Text("Select"),
                      textColor: Colors.white,
                      color: Colors.black,
                      onPressed: (){
                        OfferRide.brand=brand;
                        OfferRide.numberplate=number;
                        OfferRide.model=model;

                        if(type=='Bike')
                          SeatsModel.seats=1;
                        else
                          SeatsModel.seats=4;

                        print("these are seats${SeatsModel.seats}");
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>datetime()
                        ));
                      }
                      )
                ],
              ),

              Divider(height: 2,),
              SizedBox(height: size.height*0.009,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Number: $number',style: TextStyle(fontSize: 14,),),

                  Text('Model: $model',style: TextStyle(fontSize: 14,),),

                  Text('Type: $type',style: TextStyle(fontSize: 14,),)

                ],
              ),
              SizedBox(height: size.height*0.009,),
            ],
          )
      );

  }


  void _showModelSheet(){
    showModalBottomSheet(context: context, builder:(builder){
      Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height*0.35 ,
      child: Column(
        children: [
          SizedBox(height: size.height*0.009,),

          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterBike()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  height: size.height*0.20,
                  width: size.width*0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(1,0.7),
                            blurRadius: 6,
                            spreadRadius: 0.5
                        ),
                      ]
                  ),
                  child: Image.asset('assets/bikeride.png',height: size.height*0.1,width:size.width*0.1),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterCar()));
                },

                child: Container(

                  height: size.height*0.20,
                  width: size.width*0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(1,0.7),
                            blurRadius: 6,
                            spreadRadius: 0.5
                        ),
                      ]
                  ),
                  child: Image.asset('assets/carregister.png',height: size.height*0.1,width:size.width*0.1),

                ),
              )
            ],
          ),
          SizedBox(height: size.height*0.009,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Bike',style: TextStyle(fontSize: 25),) ,
              Text('Car',style: TextStyle(fontSize: 25),)
            ],
          ),
        ],
      ),
    );

     });

   }
}