import 'package:flutter/material.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/drawer_screens/Help.dart';

class screen extends StatefulWidget {
  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                builder: (ctx) => Help(),
              ),
            );
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
                " when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                " It has survived not only five centuries, but also the leap "
                "into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s"
                " with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop "
                "publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
                " when an unknown printer took a galley of type and scrambled it to make a type specimen book."
            , style: TextStyle(fontSize: 17),
          )
      ),
    );
  }
}

