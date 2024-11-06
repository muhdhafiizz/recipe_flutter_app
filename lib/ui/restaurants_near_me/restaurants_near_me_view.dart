import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'restaurants_near_me_controller.dart';
import 'package:lottie/lottie.dart';

class RestaurantNearbyView extends StatefulWidget {
  const RestaurantNearbyView({super.key});

  @override
  State<RestaurantNearbyView> createState() => _RestaurantNearbyViewState();
}

class _RestaurantNearbyViewState extends State<RestaurantNearbyView> {
  final RestaurantsNearMeController _controller = RestaurantsNearMeController();
  List<dynamic> _restaurants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    setState(() {
      _isLoading = true;
    });

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    final restaurants =
        await _controller.fetchNearbyRestaurants(latitude, longitude);
    setState(() {
      _restaurants = restaurants;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nearby Restaurants',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: _isLoading
          ? Center(
              child: Lottie.asset(
                'assets/animations/lottie-loading-page.json', 
                width: 200,
                height: 200,
              ),
            )
          : _restaurants.isEmpty
              ? const Center(child: Text('No restaurants found.'))
              : ListView.builder(
                  itemCount: _restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = _restaurants[index];
                    return ListTile(
                      title: Text(restaurant['name'] ?? 'Unknown'),
                      subtitle: Text(
                          restaurant['vicinity'] ?? 'No address available'),
                    );
                  },
                ),
    );
  }
}
