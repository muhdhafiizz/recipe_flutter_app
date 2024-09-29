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
    }
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: const Text('Please select whether to use camera or gallery.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickImage(context, ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickImage(context, ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  void updateRecipe(BuildContext context) {
    recipeModel.name = provider.nameController.text;
    recipeModel.image = provider.image;
    recipeModel.ingredients = provider.ingredientsController.text;
    recipeModel.instructions = provider.instructionsController.text;

    provider.updateRecpe(recipeModel);
    clearFields();
    Navigator.of(context).pop();
  }

  void clearFields() {
    provider.nameController.clear();
    provider.ingredientsController.clear();
    provider.instructionsController.clear();
    provider.image = null;
  }
}
