import 'package:flutter/material.dart';
import 'package:lift_login/screens/Destination_search.dart';

Widget homeBottomSheet(BuildContext context){
  return
    Positioned(

      child: Container(
        height: 230.0,
        width: 500,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0,5.0),
                  blurRadius: 10,
                  spreadRadius: 3
              ),
            ]
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Destination_search()));
              },
              child: Container(

                margin: EdgeInsets.only(top: 35,right: 20,left: 20),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(1.0,12.0),
                          blurRadius: 7,
                          spreadRadius: 9
                      ),
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 12),
                  child: Text('Where to?',style: TextStyle(color: Colors.black54,fontSize: 20)),

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32,left: 30,bottom: 15),

              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(Icons.work,size: 19,color: Colors.redAccent,),
                      ),
                    ),
                    TextSpan(text: 'Work',style: TextStyle(color: Colors.black87,fontSize: 17)),
                  ],
                ),
              ),
            ),
            Divider(height: 1,),
            Container(
              margin: EdgeInsets.only(top: 27,left: 30,bottom: 15),

              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(Icons.home,size: 21,color: Colors.redAccent,),
                      ),
                    ),
                    TextSpan(text: 'Home',style: TextStyle(color: Colors.black87,fontSize: 17)),
                  ],
                ),
              ),
            ),



          ],
        ),

      ),
    );
}



Widget confirmRideInputs(Function abc,Function abc1){
  return Column(
    children: [

      Positioned(

        //top: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 50,
            width: 350,

            child: FlatButton(
              child: Text("Confirm"),
              textColor: Colors.white,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                //side: BorderSide(color: Colors.red)
              ),
              onPressed: (){
                abc();
                abc1();
              },

            ),
          ),
        ),
      )

    ],
  );
}


Widget drawerIcon(){
  GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();
  return Positioned(

    child: GestureDetector(
      onTap: (){
        scaffoldkey.currentState.openDrawer();
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),

          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.menu,color: Colors.black,),
            radius: 22,
          )
      ),
    ),
  );
}

Widget back(context){

  return Positioned(
    child: GestureDetector(
      onTap: (){
        Navigator.pop(context);

      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),


          ),

          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(Icons.arrow_back_ios,color: Colors.black,),
            ),
            radius: 22,

          )

      ),
    ),
  );
}