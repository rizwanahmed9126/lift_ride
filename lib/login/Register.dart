import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/login/middle_login_home.dart';
import 'package:lift_login/screens/Preferences.dart';
import 'package:lift_login/screens/Home.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/models/SignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Register extends StatefulWidget {

  final String value;
  Register({Key key,this.value}): super(key:key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool _validate=false;
  String fname="";
  String lname="";

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final lnameController = TextEditingController();


  insertUserData(){
    Firestore.instance.collection('Users').add({
      'Name': _nameController.text,
      'Email': _emailController.text,
      'PhoneNumber': decision.phoneNumber,
      'Rating':0.0,
    });
  }




  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _nameController.text.isEmpty ? _validate = true : _validate = false;
          });
          if(_validate==false) {

            insertUserData();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Preferences(),
              //SideBarLayout(value:"${widget.value}")
            ));
          }



        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.arrow_forward, color: Colors.white, ),
      ) ,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios,color: Colors.black),
                  ),
                  SizedBox(height: 30,),
                  Text("Let's create an Account", style:TextStyle(fontSize: 20), ),
                  SizedBox(height: 30,),
                  Column(
                    children: [




                      SizedBox(height: 50),
                      //Expanded(
                      TextField(
                          controller: _nameController,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "First Name",
                              fillColor: Colors.white70,

                              errorText: _validate ? 'Value Can\'t Be Empty' : null,
                              contentPadding: EdgeInsets.fromLTRB(25, 15, 6, 15)
                          )
                      ),
                      SizedBox(height: 20,),
                      TextField(
                          controller: lnameController,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "Last Name",
                            fillColor: Colors.white70,
                            contentPadding: EdgeInsets.fromLTRB(25, 15, 6, 15),

                            errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          )
                        // ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                          controller: _emailController,
                          // decoration: InputDecoration(
                          //   hintText: "Last name",
                          //   hintStyle: TextStyle(fontSize: 18),
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "Email",
                            fillColor: Colors.white70,
                            contentPadding: EdgeInsets.fromLTRB(25, 15, 6, 15),

                            errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          )
                        // ),
                      ),


                    ],
                  )



                ]
            ),

          ),
        ],
      ),
    );

  }
}

