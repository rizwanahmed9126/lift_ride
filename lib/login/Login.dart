import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/login/Register.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:lift_login/screens/Preferences.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';









class LoginScreen extends StatefulWidget {

  final bool value;
  LoginScreen({Key key,this.value}): super(key:key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();


  String _phone;
  bool _validate=false;
  bool _validateCode=false;
  String number;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }







  @override
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(

        phoneNumber: phone,
        timeout: Duration(seconds: 10),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          if (user != null) {
            decision.phoneNumber=_phoneController.text;
           // print('$user user is not null---------------------------------------');

            if(a==0)
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>Register(),));
            else
             Navigator.push(context, MaterialPageRoute(
               builder: (context)=>Preferences(),));
          }
          else {
            print("Error");

          }
        },

        verificationFailed: (AuthException exception) {
          return exception;

        },
        codeSent: (String verificationId, [int forceResendToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter the code we have send you"),

                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _codeController,
                        decoration: InputDecoration(

                          errorText: _validateCode?'Please Enter the code':null

                        ),
                      )

                    ],
                  ),
                  actions: [
                    FlatButton(
                      child: Text("Submit"),
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      onPressed: () async {

                        setState(() {
                          _codeController.text.isEmpty ? _validateCode = true : _validateCode = false;
                        });

                        if(_validateCode==true){
                          print('value is embty');
                        }
                        else{
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                        AuthResult result = await _auth.signInWithCredential(
                            credential);

                        FirebaseUser user = result.user;
                        //print(user);

                        if (user != null) {
                          decision.phoneNumber=_phoneController.text;
                          if(a==0) {
                            Navigator.pushReplacement(
                                 context, MaterialPageRoute(
                               builder: (context) => Register(),));
                          }
                          else {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(
                              builder: (context) => Preferences(),));
                          }
                        } else {
                          print("error");
                        }
                        }
                        }

                    )
                  ],
                );
              }

          );
        },
        codeAutoRetrievalTimeout: null
    );
  }




  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      _phone=internationalizedPhoneNumber;
      print(internationalizedPhoneNumber);
      _phoneController.text=_phone;
      print("phone number"+_phoneController.text);
    });
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton:  FloatingActionButton(
        onPressed: () async{
          setState(() {
            _phoneController.text.isEmpty ? _validate = true : _validate = false;
          });
          if(_validate==false) {
            final phone = _phoneController.text.trim();
            doesNameAlreadyExist(phone);
            loginUser(phone, context);
            // isLoading=true;
          }


          print('this is called after alreayexist function');
          print(a);




          // adddata();


        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.arrow_forward, color: Colors.white, ),
      ),


      body:Stack(
        children: [
          Container(

            padding: EdgeInsets.only(left:20, right: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 50,),
                GestureDetector(
                  onTap: (){

                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.black,),
                ),
                SizedBox(height: 30,),
                Text("Enter Your Mobile Number", style:TextStyle(fontSize: 20,fontFamily: 'Raleway'), ),

                SizedBox(height: 30,),
                // Row(
                //  children: [
                Center(
                    child: InternationalPhoneInput(
                      //decoration: InputDecoration.collapsed(hintText: '(416) 123-4567',),

                      onPhoneNumberChange: onPhoneNumberChange,
                      initialPhoneNumber: _phone,
                      initialSelection: 'PK',
                      enabledCountries: ['+92', '+1'],
                      showCountryCodes: true,
                      errorText: _validate ?'Please Enter Number':null,
                    )
                ),
                SizedBox(width: 10,),

              ],

            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child:Padding(
                padding: EdgeInsets.only(left: 20,right: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("By Continuing you may receive an SMS \nverification. Message and data rates may\n apply  ", style: TextStyle(height: 1.6),),
                  ],
                ),
              )
          )


        ],
      ),
    );
  }
}
int a=0;
// Widget takeDecision(){
//   return FutureBuilder(
//
//       future: doesNameAlreadyExist(),
//
//       builder: (context, AsyncSnapshot<int> result) {
//         if (!result.hasData)
//           return Register();
//
//
//         if (a==0) {
//           // return Center( child:Text('A company called "Nova" already exists.'));
//           return Register();
//
//           //profile(value:"${widget.value}");
//         }
//         else {
//           //         return Text('No company called "Nova" exists yet.');
//           print("------------------------------Register---------------------------------------------");
//           return Preferences();
//         }
//
//       }
//   );
// }
doesNameAlreadyExist(String number) async {
  final QuerySnapshot result = await Firestore.instance
      .collection('Users')
      .where('PhoneNumber', isEqualTo: number)
      .limit(1)
      .getDocuments();
  List<DocumentSnapshot> documents = result.documents;
  print(decision.phoneNumber);
  print("inside HomeScreen");
  print('phone number');
  print(decision.phoneNumber);
  print(documents.length);
  a=documents.length;
  print('thi is the a value $a');

  // return a;
  //return Register();


}






