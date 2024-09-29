import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';
import 'package:recipe_flutter_app/ui/edit_recipe/edit_recipe.dart';

class RecipeDetailController {
  final RecipeProvider recipeProvider;

  RecipeDetailController(this.recipeProvider);

  void navigateToEditRecipe(BuildContext context, RecipeModel recipeModel) {
    recipeProvider.nameController.text = recipeModel.name ?? "";
    recipeProvider.ingredientsController.text = recipeModel.ingredients ?? "";
    recipeProvider.instructionsController.text = recipeModel.instructions ?? "";
    recipeProvider.image = recipeModel.image;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditRecipe(recipeModel: recipeModel)),
    );
  }

  void deleteRecipe(BuildContext context, RecipeModel recipeModel) {
    recipeProvider.deleteOneRecipe(recipeModel);
    Navigator.pop(context);
  }
}
