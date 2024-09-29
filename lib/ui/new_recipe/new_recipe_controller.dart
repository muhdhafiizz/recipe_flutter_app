import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';

class NewRecipeController {
  final RecipeProvider recipeProvider;

  NewRecipeController(this.recipeProvider);

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      recipeProvider.image = File(image.path);
    }
  }

  void saveRecipe(BuildContext context) {
    if (recipeProvider.nameController.text.isNotEmpty &&
        recipeProvider.ingredientsController.text.isNotEmpty &&
        recipeProvider.instructionsController.text.isNotEmpty &&
        recipeProvider.image != null) {
      recipeProvider.insertNewRecipe();
      recipeProvider.nameController.clear();
      recipeProvider.ingredientsController.clear();
      recipeProvider.instructionsController.clear();
      recipeProvider.image = null; 
      Navigator.of(context).pop();
      print('Recipe Saved');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all fields and add an image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
