import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';
import 'package:recipe_flutter_app/ui/new_recipe/new_recipe.dart';
import 'package:recipe_flutter_app/ui/search_recipe/search_recipe_screen.dart';

class HomePageController {
  final RecipeProvider recipeProvider;

  HomePageController(this.recipeProvider);

  void navigateToSearchRecipe(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchRecipeScreen(recipes: recipeProvider.allRecipes),
      ),
    );
  }

  Future<void> navigateToNewRecipe(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewRecipeScreen()),
    );
  }
}
