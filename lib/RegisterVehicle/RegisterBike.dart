import 'package:flutter/material.dart';
import 'package:lift_login/RegisterVehicle/Find_Vehicle.dart';
import 'package:lift_login/RegisterVehicle/components/CustomAppBar.dart';
import 'package:lift_login/RegisterVehicle/components/CustomUI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';



class RegisterBike extends StatefulWidget {
  @override
  _RegisterBikeState createState() => _RegisterBikeState();
}

class _RegisterBikeState extends State<RegisterBike> {

  String numberPlate;
  String brandName;
  String modelName;




  var snackBar = SnackBar(content: Text('the Values Can not be null'));

  void addVehicle() async {
    await Firestore.instance.collection('Users').where(
        'PhoneNumber', isEqualTo: decision.phoneNumber
    ).getDocuments().then((onValue) {
      onValue.documents.forEach((f) {
        print(f.documentID);
        Firestore.instance.collection('Users').document(f.documentID).collection('Vehicle')
            .add(
            {
              'NumberPlate': numberPlate,
              'VehicleBrand': brandName,
              'VehicleModel': modelName,
              'Type':'Bike',

            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppBar(
          press: (){},
          title: "Register Bike",
          icon: Icons.arrow_back_ios_outlined,

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomUI(

                brands: ['SuperPower','SuperStar','Honda','Unique','Other'],
                model: ['70cc','125cc','150cc','175cc','Other'],
                textNumberPlate: 'Enter Your Bike Registration Number',
                textNumberPlate1: 'Bike Registration Number',
                image: 'assets/bikeregister.png',

                selectedModelValue: modelName,
                selectedBrandValue: brandName,

                //number plate value
                onChnaged: (value){
                  numberPlate=value;
                },

                //brand dropdown value
                onBrandChanged: (value1){
                  setState(() {
                    brandName=value1;});
                },

                //model dropdown value
                onModelChanged: (value){
                  setState(() {
                    modelName=value;});
                },

                press: () {

                  if (brandName != null && modelName != null &&
                      numberPlate != null) {
                    addVehicle();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => RegisterVehicle()));
                  }
                  else
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                }
            )

          ],
        ),
      ),

    );
  }
}



// class RegisterBike extends StatefulWidget {
//   @override
//   _RegisterBikeState createState() => _RegisterBikeState();
// }
//
// class _RegisterBikeState extends State<RegisterBike> {
//
//   List<String> _locations = ['Unique', 'SuperStar', 'SuperPower', 'Honda']; // Option 2
//   String _selectedLocation;
//
//   List<String> _locations1 = ['70CC', '125CC', '175CC', '150CC']; // Option 2
//   String _selectedLocation1;
//
//   TextEditingController numberController=TextEditingController();
//   String carModel;
//   String carBrand;
//
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
//   }
//
//   void addVehicle() async {
//
//     await Firestore.instance.collection('Users').where(
//         'PhoneNumber', isEqualTo: decision.phoneNumber).getDocuments().then((onValue) {
//       onValue.documents.forEach((f) {
//         print(f.documentID);
//         Firestore.instance.collection('Users').document(f.documentID).collection('Vehicle')
//             .add(
//             {
//
//               'NumberPlate': numberController.text,
//               'VehicleBrand': _selectedLocation,
//               'VehicleModel': _selectedLocation1,
//               'Type':'Bike',
//
//             });
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar:AppBar(
//         title: Text("Register Bike",style: TextStyle(color: Colors.black),),
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         bottom: PreferredSize(
//           child: Container(
//             height: 0.5,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.white,
//                   spreadRadius: 0.2,
//                   blurRadius: 0.2,
//                   offset: Offset(1, 0.5), // changes position of shadow
//                 ),
//               ],
//             ),
//           ),
//           preferredSize: Size.fromHeight(0.5),
//         ),
//         iconTheme: IconThemeData(color: Colors.black),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//
//           onPressed: () {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (ctx) => RegisterVehicle(),
//               ),
//             );
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 400,
//               width: 450,
//               child: Image.asset('assets/bikeregister.png',height: 32,width:32),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                 height: 190,
//                 width: 350,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey[200],
//                           offset: Offset(1,0.7),
//                           blurRadius: 6,
//                           spreadRadius: 0.5
//                       ),
//                     ]
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 90,top: 15),
//                       child: Text('Enter the Car Number Plate',style: TextStyle(fontSize: 19,color: Colors.blue),),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10,top: 5),
//                       child: Text('We will only share with passengers who will book your ride',style: TextStyle(fontSize: 16,color: Colors.grey),),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 170,top: 20),
//                       child: Text('Car Registration Number',style: TextStyle(fontSize: 14,color: Colors.grey),),
//                     ),
//
//
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
//                         child: Container(
//                           height: 30,
//                           child: TextField(
//                               controller: numberController,
//                               autofocus: false,
//                               decoration: InputDecoration(
//
//
//                               ),
//                               ),
//                         ),
//                       )
//
//
//
//
//                   ],
//                 ),
//
//               ),
//
//             ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10,top: 20),
//               child: Text('Select Brand',style: TextStyle(fontSize: 17),),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Container(
//                 width: 150,
//                 decoration: BoxDecoration(
//                   // borderRadius: BorderRadius.circular(14),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey[200],
//                           offset: Offset(1,0.7),
//                           blurRadius: 6,
//                           spreadRadius: 0.5
//                       ),
//                     ]
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: DropdownButton(
//                     hint: Text('Select one'), // Not necessary for Option 1
//                     value: _selectedLocation,
//
//                     onChanged: (newValue) {
//                        setState(() {
//                       _selectedLocation = newValue;
//                       carBrand=newValue;
//                       print('$carBrand this is the car brand-----------');
//                       });
//                     },
//                     items: _locations.map((location) {
//                       return DropdownMenuItem(
//                         child: new Text(location),
//                         value: location,
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//
//
//           ],
//         ),
//             SizedBox(height: 20,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10,top: 20),
//               child: Text('Select Model',style: TextStyle(fontSize: 17),),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Container(
//                 width: 150,
//                 decoration: BoxDecoration(
//                   // borderRadius: BorderRadius.circular(14),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey[200],
//                           offset: Offset(1,0.7),
//                           blurRadius: 6,
//                           spreadRadius: 0.5
//                       ),
//                     ]
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: DropdownButton(
//                     hint: Text('Select one'),
//                     autofocus: false,// Not necessary for Option 1
//                     value: _selectedLocation1,
//                     onChanged: (newValue) {
//                        setState(() {
//                       _selectedLocation1 = newValue;
//                       carModel=newValue;
//                       print('$carModel this is the car brand-----------');
//                       });
//                     },
//                     items: _locations1.map((location) {
//                       return DropdownMenuItem(
//                         child: new Text(location),
//                         value: location,
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//
//
//           ],
//         ),
//             Container(
//               height: 50,
//               width: 500,
//               margin: EdgeInsets.only(top: 25),
//               child: FlatButton(
//                 child: Text("Register"),
//                 textColor: Colors.white,
//                 color: Colors.redAccent,
//                 onPressed: (){
//                     if(_selectedLocation!=null && _selectedLocation1!=null && numberController!=null) {
//                       addVehicle();
//                       Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => RegisterVehicle()));
//                     }
//                     else
//                       showInSnackBar('Value Can not be null');
//
//
//               },
//               )
//             )
//
//
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
