import 'package:flutter/material.dart';
import 'package:meals/screens/filter.dart';

class Maindrawer extends StatelessWidget {
  Widget buildlist(String title, IconData icon, Function taphandle) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: taphandle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking up',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildlist('Meals', Icons.restaurant_menu, () {
            Navigator.of(context).pushReplacementNamed('/');
          },),
          buildlist(
            'Filter',
            Icons.settings_applications,
            () {
              Navigator.of(context).pushReplacementNamed(Filterscreen.routename);
            },
          ),
        ],
      ),
    );
  }
}
