import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';

import 'new_recipe_controller.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  late NewRecipeController controller;

  @override
  void initState() {
    super.initState();
    controller = NewRecipeController(
        Provider.of<RecipeProvider>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          "Create a new Recipe",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Container(
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
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: provider.mealTypeController.text.isNotEmpty
                      ? provider.mealTypeController.text
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Meal Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  items: ['Breakfast', 'Lunch', 'Dinner'].map((String meal) {
                    return DropdownMenuItem<String>(
                      value: meal,
                      child: Text(meal),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    provider.mealTypeController.text = newValue ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a meal type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
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
                              onTap: () => controller.pickImage(
                                  context, ImageSource.camera),
                              child: const Row(
                                children: [
                                  Icon(Icons.camera),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Take a picture"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () => controller.pickImage(
                                  context, ImageSource.gallery),
                              child: const Row(
                                children: [
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
                Visibility(
                  visible: provider.image != null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          provider.image = null;
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                      provider.image != null
                          ? Image.file(
                              provider.image!,
                              width: 200,
                              height: 200,
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.saveRecipe(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      child: const Text('Save Recipe'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
