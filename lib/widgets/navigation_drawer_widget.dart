import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_space/screens/drawer_screens/recommendation_screen.dart';

import '../screens/drawer_screens/profile_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: 250,
        child: Material(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              buildMenuItem(
                drawerText: 'Profile',
                drawerIcon: Icons.person,
                onClicked: () => selectedItem(context, 0),
              ),
              const SizedBox(
                height: 20,
              ),

              buildMenuItem(
                drawerText: 'Recommendation',
                drawerIcon: Icons.book,
                onClicked: () => selectedItem(context, 1),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(color: Colors.black),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String drawerText,
    required IconData drawerIcon,
    VoidCallback? onClicked,
  }) {

    return ListTile(
      leading: Icon(
        drawerIcon,
        color: Colors.white,
      ),
      title: Text(drawerText,
      style: TextStyle(
        fontSize: 20
      ),),
      onTap: onClicked,
    );
  }

  Future<void> selectedItem(BuildContext context, int i) async {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 1:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RecommendationScreen()));
        break;


    }
  }
}