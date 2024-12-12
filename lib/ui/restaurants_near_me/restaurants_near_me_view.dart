import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/ui/widgets/drawer.dart';
import 'restaurants_near_me_controller.dart';
import 'package:lottie/lottie.dart';

class RestaurantNearbyView extends StatelessWidget {
  const RestaurantNearbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantsNearMeController()..getUserLocation(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nearby Restaurants',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.brown,
        ),
        drawer: const Drawer(
          backgroundColor: Colors.brown,
          child: DrawerList(),
        ),
        body: Consumer<RestaurantsNearMeController>(
          builder: (context, controller, _) {
            return controller.isLoading
                ? Center(
                    child: Lottie.asset(
                      'assets/animations/lottie-loading-page.json',
                      width: 200,
                      height: 200,
                    ),
                  )
                : controller.restaurants.isEmpty
                    ? const Center(child: Text('No restaurants found.'))
                    : ListView.builder(
                        itemCount: controller.restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = controller.restaurants[index];
                          return ListTile(
                            title: Text(restaurant['name'] ?? 'Unknown'),
                            subtitle: Text(
                                restaurant['vicinity'] ?? 'No address available'),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
