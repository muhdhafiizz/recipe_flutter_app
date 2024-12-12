import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/ui/favorite_page/favorite_page.dart';
import 'package:recipe_flutter_app/ui/home_page/home_page.dart';
import 'package:recipe_flutter_app/ui/login/login_page.dart';
import 'package:recipe_flutter_app/ui/nutrition_details/nutrition_details_view.dart';
import 'package:recipe_flutter_app/ui/profile/profile_view.dart';
import 'package:recipe_flutter_app/ui/restaurants_near_me/restaurants_near_me_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        const SizedBox(
          height: 100,
        ),
        ListTile(
            title: Text(
              AppLocalizations.of(context)!
                              .profile,
              style: const TextStyle(color: Colors.white),
            ),
            leading: const Icon(
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
              AppLocalizations.of(context)!
                              .home,
              style: const TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }),
        ListTile(
            title: Text(
              AppLocalizations.of(context)!
                              .favorite,
              style: const TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            }),
        ListTile(
            title: Text(
              AppLocalizations.of(context)!
                              .restaurantsNearMe,
              style: const TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.store,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const RestaurantNearbyView()),
              );
            }),
        ListTile(
            title: Text(
              AppLocalizations.of(context)!
                              .nutritionData,
              style: const TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.emoji_food_beverage,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NutritionPage()),
              );
            }),
        // const Divider(
        //   color: Colors.white,
        // ),
        // ListTile(
        //     title: const Text(
        //       "Sign Out",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     leading: const Icon(
        //       Icons.logout,
        //       color: Colors.white,
        //     ),
        //     onTap: () async {
        //       await FirebaseAuth.instance.signOut();
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => const LoginPage()),
        //       );
        //     }),
      ],
    );
  }
}