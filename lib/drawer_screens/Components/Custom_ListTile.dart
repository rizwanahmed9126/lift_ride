import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final title;
  final pushScreen;
  final IconData icon;

  CustomListTile({
    Key key,
    this.title,
    this.pushScreen,
    this.icon

  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushNamed(pushScreen);

      },

    );
  }
}
