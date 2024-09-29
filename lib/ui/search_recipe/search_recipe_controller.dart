import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:flutter/material.dart';

class SearchRecipeController with ChangeNotifier {
  List<RecipeModel> allRecipes;
  List<RecipeModel> filteredRecipes = [];

  SearchRecipeController(this.allRecipes) {
    filteredRecipes = allRecipes;
  }

  void filterRecipes(String value) {
    filteredRecipes = allRecipes
        .where((recipe) => recipe.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
