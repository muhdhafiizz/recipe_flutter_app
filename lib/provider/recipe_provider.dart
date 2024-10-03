import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/data_repo/db_helper.dart';
import 'package:recipe_flutter_app/ui/home_page/home_page.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';

class RecipeProvider extends ChangeNotifier {
  RecipeProvider(){
    getRecipes();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController mealTypeController = TextEditingController();
  File? image;
  String? imagePath;

  List<RecipeModel> allRecipes = [];
  List<RecipeModel> favoriteRecipes = [];

  getRecipes() async {
    allRecipes = await DbHelper.dbHelper.getAllRecipes();
    favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
    notifyListeners();
  }

  insertNewRecipe(){
    RecipeModel recipeModel = RecipeModel(
      isFavorite: false,
      name: nameController.text,
      image: image,
      imagePath: imagePath,
      ingredients: ingredientsController.text,
      instructions: instructionsController.text,
      mealType: mealTypeController.text);

    DbHelper.dbHelper.insertNewRecipe(recipeModel);
    getRecipes();
  }

  updateRecpe(RecipeModel recipeModel) async {
    await DbHelper.dbHelper.updateRecpe(recipeModel);
    getRecipes();
  }

  void updateIsFavorite(RecipeModel recipeModel) async {
  recipeModel.isFavorite = !recipeModel.isFavorite;

  await DbHelper.dbHelper.updateFavourite(recipeModel);

  if (recipeModel.isFavorite) {
    favoriteRecipes.add(recipeModel);
  } else {
    favoriteRecipes.removeWhere((recipe) => recipe.id == recipeModel.id);
  }
  notifyListeners();
}


  deleteOneRecipe (RecipeModel recipeModel) {
    DbHelper.dbHelper.deleteOneRecipe(recipeModel);
    getRecipes();
  }



}