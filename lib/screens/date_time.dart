import 'package:flutter/material.dart';
import 'package:lift_login/models/Upload_Ride_Model.dart';
import 'package:lift_login/screens/Home.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:lift_login/screens/Seat_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/RegisterVehicle/Find_Vehicle.dart';

class datetime extends StatefulWidget {
  @override
  _datetimeState createState() => _datetimeState();
}

class _datetimeState extends State<datetime> {

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTime selectedDate = DateTime.now();
  String _hour, _minute, _time;
  double _width;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }


  // void getDocumentID() async {
  //   await Firestore.instance.collection('Users').where(
  //       'PhoneNumber', isEqualTo: '+923022565616').getDocuments().then((onValue) {
  //     onValue.documents.forEach((f) {
  //      print('document id from function------------');
  //       print(f.documentID);
  //       OfferRide.documentID=f.documentID;
  //       print(OfferRide.documentID);
  //
  //
  //     });
  //   });
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();


  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Add your travel time",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.transparent,
          elevation: 0.0,

          bottom: PreferredSize(
            child: Container(
              //color: Colors.grey,
              height: 0.5,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    //.withOpacity(0.5),
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
              Navigator.pop(context);
            },
          ),

        ),
        body:Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 8),
                  child: Text("when will you go?", style:TextStyle(fontSize: 19, color: Colors.grey[400]),),
                ),


                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },

                  child:Container(
                    height: 50,
                    width: _width,
                    //margin: EdgeInsets.only(left: 10,top: 15),

                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      enabled: false,
                      style: TextStyle(fontSize: 23),
                      controller: _dateController,

                      onSaved: (String val) {
                        // _setDate = val;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left:30,right: 85),
                          child: Icon(Icons.calendar_today),
                        ),
                        filled: true,
                        fillColor: Colors.grey[120],


                        hintText: "which Date ?",

                      ),

                    ),
                  ),


                ),

                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(top: 12,bottom: 8),
                  child: Text("What time?", style:TextStyle(fontSize: 19, color: Colors.grey[400]),),
                ),

                InkWell(
                    onTap: () {
                      _selectTime(context);
                    },

                    child:Container(
                      height:50,
                      width: _width,

                      child: TextFormField(
                        cursorColor: Colors.black,


                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _timeController,
                        style: TextStyle(fontSize: 23),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left:30,right: 85),
                            child: Icon(Icons.alarm,),
                          ),



                          filled: true,
                          fillColor: Colors.grey[100],

                          hintText: "which time ?",

                        ),

                      ),

                    )
                ),
              ],
            ),

            Column(
              children: [
                Container(

                  width: _width/1.05,
                  child: FlatButton(
                    child: Text("Submit"),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    onPressed: (){

                      OfferRide.date=_dateController.text;
                      OfferRide.time=_timeController.text;
                      //getDocumentID();

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SeatScreen()));


                    },


                  ),
                ),

              ],
            ),

          ],
        )
    );
  }
}
