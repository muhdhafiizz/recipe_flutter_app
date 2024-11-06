import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class RestaurantsNearMeController {
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
}
