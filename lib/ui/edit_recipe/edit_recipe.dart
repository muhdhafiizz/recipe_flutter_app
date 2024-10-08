import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';
import 'package:recipe_flutter_app/ui/edit_recipe/edit_recipe_controller.dart';

class EditRecipe extends StatefulWidget {
  const EditRecipe({super.key, required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  late EditRecipeController controller;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RecipeProvider>(context, listen: false);
    controller = EditRecipeController(provider, widget.recipeModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Edit Recipe", style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: provider.nameController,
                decoration: InputDecoration(
                  labelText: 'Recipe Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: provider.ingredientsController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Ingredients',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: provider.instructionsController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Instructions',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  PopupMenuButton(
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                              onTap: () => controller.pickImage(context, ImageSource.camera),
                              child: const Row(
                                children:  [
                                  Icon(Icons.camera),
                                  SizedBox(width: 5,),
                                  Text("Take a picture"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () => controller.pickImage(context, ImageSource.gallery),
                              child: const Row(
                                children:  [
                                  Icon(Icons.image),
                                  SizedBox(width: 5),
                                  Text("Select from gallery"),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const Text("Add a picture"),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => controller.updateRecipe(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Save Recipe'),
                ),
              ]
            ),
          )
        )
      );
    }
  }
