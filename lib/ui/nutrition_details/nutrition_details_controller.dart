import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/ui/nutrition_details/nutrition_details_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionController extends ChangeNotifier {
  String _ingredient = "";
  NutritionResponse? nutritionData;
  bool isLoading = false;

  String get ingredient => _ingredient;

  void updateIngredient(String ingredient) {
    _ingredient = ingredient;
    notifyListeners();
  }

  Future<void> fetchNutritionData(String appId, String appKey) async {
    if (_ingredient.isEmpty) return;

    final apiUrl =
        "https://api.edamam.com/api/nutrition-data?app_id=$appId&app_key=$appKey&ingr=$_ingredient";

    isLoading = true;
    notifyListeners();
    print(apiUrl);

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        nutritionData = NutritionResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load nutrition data');
      }
    } catch (e) {
      nutritionData = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
