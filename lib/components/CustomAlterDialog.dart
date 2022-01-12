import 'package:flutter/material.dart';

class CustomAlterDialog extends StatelessWidget {
  final String title;
  final String msg;
  final Function press;
  const CustomAlterDialog({
    this.title,
    this.press,
    this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [

        FlatButton(
          child: Text("OK"),
          onPressed: press,
        )
      ],
    );
  }
}