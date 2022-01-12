import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function press;
  final String title;
  final IconData icon;
  const CustomAppBar({
    Key key,
    this.press,
    this.title,
    this.icon,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white,
      elevation: 0.0,
      bottom: PreferredSize(
        child: Container(
          height: 0.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
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
        icon: Icon(icon, color: Colors.black,),

        onPressed: press,
      ),
    );
  }
}
