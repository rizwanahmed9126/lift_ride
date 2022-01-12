import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function press;
  final IconData icon;
  final String text;
  const CustomIconButton({
    this.text,
    this.icon,
    this.press
  });

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      width: size.width*0.7,
      height: size.height*0.08,
      child:FlatButton.icon(
        onPressed: press,
        icon: Icon(icon,color: Colors.redAccent,),

        label: Text(text,style: TextStyle(color:  Colors.redAccent,),),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.redAccent)
        ),


      ),
    );
  }
}
