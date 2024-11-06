import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/ui/favorite_page/favorite_page.dart';
import 'package:recipe_flutter_app/ui/home_page/home_page.dart';
import 'package:recipe_flutter_app/ui/login/login_page.dart';
import 'package:recipe_flutter_app/ui/profile/profile_view.dart';
import 'package:recipe_flutter_app/ui/restaurants_near_me/restaurants_near_me_view.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        ListTile(
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileView()),
              );
            }),
        ListTile(
            title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }),
        ListTile(
            title: Text(
              "Favorite",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            }),
        ListTile(
            title: Text(
              "Restaurants Near Me",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.store,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestaurantNearbyView()),
              );
            }),
        Divider(
          color: Colors.white,
        ),
        ListTile(
            title: Text(
              "Sign Out",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }),
      ],
    );
  }
}
