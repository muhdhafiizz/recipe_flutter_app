import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class RestaurantsNearMeController with ChangeNotifier {
  final String apiKey = 'AIzaSyAsp4Tn0AvnnqEC9VZAqd1zZa8f-RP1vIs';
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  Future<List<dynamic>> fetchNearbyRestaurants(double latitude, double longitude) async {
    final String url = '$baseUrl?location=$latitude,$longitude&radius=1500&type=restaurant&key=$apiKey';
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['results'] as List;
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      debugPrint('Error fetching restaurants: $e');
      return [];
    }
  }

  bool _isLoading = true;
  List<dynamic> _restaurants = [];

  bool get isLoading => _isLoading;
  List<dynamic> get restaurants => _restaurants;

  Future<void> getUserLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;

      _restaurants = await fetchNearbyRestaurants(latitude, longitude);
    } catch (e) {
      _restaurants = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
