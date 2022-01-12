import 'package:flutter/material.dart';
import 'package:lift_login/drawer_screens/Components/Custom_ListTile.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  final String email;
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String title5;
  final String pushHistory;
  final String pushHelp;
  final String pushSettings;
  final String pushLogout;
  final String pushPreferences;

  CustomDrawer({
    Key key,
    this.name,
    this.email,
    this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.pushHelp,
    this.pushHistory,
    this.pushLogout,
    this.pushPreferences,
    this.pushSettings


  }):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(

        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name, style: TextStyle(fontSize: 20),),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/car.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),

            CustomListTile(
              title: title1,
              pushScreen: pushHistory,
              icon: Icons.history,
            ),
            CustomListTile(
              title: title2,
              pushScreen: pushHelp,
              icon: Icons.help,
            ),
            CustomListTile(
              title: title3,
              pushScreen: pushSettings,
              icon: Icons.settings,
            ),
            CustomListTile(
              title: title4,
              pushScreen: pushLogout,
              icon: Icons.logout,
            ),
            CustomListTile(
              title: title5,
              pushScreen: pushPreferences,
              icon: Icons.room_preferences_sharp,
            ),

          ],
        )
    );
  }
}
