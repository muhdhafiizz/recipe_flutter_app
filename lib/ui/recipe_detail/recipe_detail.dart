import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';

import 'recipe_detail_controller.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeModel recipeModel;

  const RecipeDetail(this.recipeModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, provider, child) {
        final controller = RecipeDetailController(provider);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown,
            actions: [
              InkWell(
                onTap: () => controller.navigateToEditRecipe(context, recipeModel),
                child: const Icon(Icons.edit, color: Colors.white),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () => controller.deleteRecipe(context, recipeModel),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 170,
                  child: recipeModel.image == null
                      ? const Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage("assets/image/recipe-word.webp"),
                          ),
                        )
                      : Image.file(recipeModel.image!),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    recipeModel.name ?? "",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipeModel.ingredients ?? "",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Instructions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipeModel.instructions ?? "",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
