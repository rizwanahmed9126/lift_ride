import 'package:flutter/material.dart';
import 'package:lift_login/RegisterVehicle/Find_Vehicle.dart';
import 'package:lift_login/RegisterVehicle/components/CustomAppBar.dart';
import 'package:lift_login/RegisterVehicle/components/CustomUI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';

class RegisterCar extends StatefulWidget {

  @override
  _RegisterCarState createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
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
              'Type':'Car',

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
          title: "Register Car",
          icon: Icons.arrow_back_ios_outlined,

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomUI(

              brands: ['Toyota','Suzuki','Honda','KIA','Other'],
              model: ['GLi','Civic','Mehran','Alto','Cultus','City','Priaus','Wagonr','Other'],
              textNumberPlate: 'Enter Your Bike Registration Number',
              textNumberPlate1: 'Car Registration Number',
              image: 'assets/registerCar1.png',

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
