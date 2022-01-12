import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:lift_login/FindRide/HomeRide.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/RegisterVehicle/Find_Vehicle.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/login/Register.dart';
import 'package:lift_login/screens/Destination_search.dart';
import 'package:lift_login/screens/Preferences.dart';
import 'package:lift_login/login/Login.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:lift_login/screens/Home.dart';
import 'package:lift_login/screens/Destination_search.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/splash_and_slider/Start_slider.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/login/middle_login_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/components/CustomRichText.dart';
import 'package:lift_login/components/CustomIconButton.dart';


class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}
class _PreferencesState extends State<Preferences> {

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(

            padding: EdgeInsets.symmetric(horizontal: 50 ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.18,),
                Text("Your Route Details", style:TextStyle(fontSize: 28,),  ),
                SizedBox(height: size.height*0.01,),
                Text("Select your Preference", style:TextStyle(fontSize: 16, color: Colors.grey),),
                SizedBox(height: size.height*0.07,),

                CustomIconButton(
                  text: 'Offer Ride',
                  icon: Icons.group,
                  press: (){
                    decision.phoneNumber= '+923362306113';
                           Navigator.pushReplacement(context, MaterialPageRoute(
                             builder: (context)=>Home(),));
                  },
                ),

                SizedBox(height: size.height*0.025,),
                CustomIconButton(
                  text: 'Find Ride',
                  icon: Icons.local_taxi_sharp,
                  press: (){
                    decision.phoneNumber= '+923362306113';
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=>HomeRide(),));

                  },
                ),
                SizedBox(height: size.height*0.03,),
                CustomRichText(
                  icon: Icons.info,
                  text: 'You can change preferences any time',
                  textColor: Colors.grey[400],
                  iconColor: Colors.black,
                )
              ],

            ),
          ),
        ],
      ),
    );
  }
}
