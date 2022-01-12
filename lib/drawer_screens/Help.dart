import 'package:flutter/material.dart';
import 'package:lift_login/screens/Home.dart';
import 'package:lift_login/drawer_screens/inside_help_screen.dart';
import 'package:lift_login/drawer_screens/Components/CustomAppBar.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;

    return Scaffold(

       appBar:
      // PreferredSize(
      //
      //     child:CustomAppBar(title: 'Help',height: 120,)
      // ),
      AppBar(
        title: Text("Help",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            customTiles(context,'Complaints and Refunds', Icons.arrow_forward_ios),

            customTiles(context, 'Pilot Behavoir', Icons.arrow_forward_ios),

            customTiles(context,'Payment or Wallet Issues', Icons.arrow_forward_ios),

            customTiles(context, 'Lost and Found', Icons.arrow_forward_ios),



          ],
        ),
      ),
    );
  }
}

Widget customTiles(BuildContext context,String name,IconData icon){
  Size size=MediaQuery.of(context).size;
  return GestureDetector(
    onTap: (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (ctx) => screen()));
    },
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Icon(icon),
          ],
        ),
        SizedBox(height: size.height*0.01),
        Divider(height: size.height*0.009,),
        SizedBox(height: size.height*0.01,),

      ],
    ),
  );
}