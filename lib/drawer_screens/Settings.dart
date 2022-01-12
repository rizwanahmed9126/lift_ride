import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_login/screens/Home.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Widget modify(){
    return AlertDialog(
        title: Text("Update Field"),
        content: TextFormField(
          decoration: InputDecoration(
            icon: Container(margin: EdgeInsets.only(left: 20,top: 5,right:10,bottom: 20,), width: 10,height: 10,),
            hintText: "Enter the Text to update",
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),

            contentPadding: EdgeInsets.only(left: 20.0,top: 10.0,bottom: 10),
          ),

        ),
        actions: [
          FlatButton(
            onPressed: (){},
            child: Text("Submit"),
            textColor: Colors.white,
            color: Colors.redAccent,
          )
        ]

    );
  }



  Widget content(IconData field_icon,String title, String field,){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
      child: Row(
        children: [


          Icon(field_icon),
          SizedBox(width: 23,),
          Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(field),
            ],
          ),

        ],
      ),
    );


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

      ),
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.black),),

        backgroundColor: Colors.white,


        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
            onPressed:(){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>Home(),
              ));
            }),
      ),


      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(

          children:[
            Container(
              child: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                content(Icons.person, "Name", "Rizwan Ahmed", ),
                SizedBox(width: 165,),
                GestureDetector(
                  child:Icon(Icons.edit, ),
                  onTap: (){


                  },
                )



              ],
            ),

            content(Icons.phone_iphone, "Mobile Number", "03033067341", ),

            content(Icons.email, "Email", "rjunejo96@gmail.com", ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                content(Icons.group, "Gender", "tap to Select",),
                SizedBox(width: 180,),
                Icon(Icons.edit)

              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                content(Icons.calendar_today, "Date of Birth", "tap to Select",),
                SizedBox(width: 180,),
                Icon(Icons.edit)

              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                content(Icons.location_city, "City", "Karachi",),
                SizedBox(width: 210,),
                Icon(Icons.edit),


              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0,15,10,10),
              child: Container(
                height: 70,


                child: Card(

                  // margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Row(
                    children: [
                      Icon(Icons.lock),
                      SizedBox(width: 23,),
                      Text("Forgot Password"),
                      SizedBox(width: 150,),
                      Icon(Icons.arrow_forward_ios)
                    ],

                  ),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
