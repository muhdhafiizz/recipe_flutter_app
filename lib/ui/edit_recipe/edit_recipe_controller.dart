import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';

class EditRecipeController {
  final RecipeProvider provider;
  final RecipeModel recipeModel;

  EditRecipeController(this.provider, this.recipeModel);



  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      provider.image = File(image.path);
      provider.imagePath = null; 

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Picture selected!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    }
  }

  void updateRecipe(BuildContext context) {
    recipeModel.name = provider.nameController.text;
    recipeModel.ingredients = provider.ingredientsController.text;
    recipeModel.instructions = provider.instructionsController.text;

    if (provider.image != null) {
      recipeModel.image = provider.image;  
      recipeModel.imagePath = null; 
    } else if (provider.imagePath != null) {
      recipeModel.imagePath = provider.imagePath;  
      recipeModel.image = null;  
    }

    provider.updateRecpe(recipeModel);
    clearFields();
    Navigator.of(context).pop();
  }

  void clearFields() {
    provider.nameController.clear();
    provider.ingredientsController.clear();
    provider.instructionsController.clear();
    provider.image = null;
    provider.imagePath = null;  
  }
}
