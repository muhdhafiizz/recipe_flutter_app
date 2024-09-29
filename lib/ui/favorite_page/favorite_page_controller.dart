import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';
import 'package:recipe_flutter_app/ui/search_recipe/search_recipe_screen.dart';

class FavoritePageController with ChangeNotifier {
  final RecipeProvider recipeProvider;

  FavoritePageController(this.recipeProvider);

  List<RecipeModel> get favoriteRecipes => recipeProvider.favoriteRecipes;

  void searchFavorites(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchRecipeScreen(recipes: favoriteRecipes)));
  }
}
