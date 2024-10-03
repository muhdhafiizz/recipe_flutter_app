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
                  child: recipeModel.image != null && recipeModel.image!.existsSync()
                ? ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.file(
                      recipeModel.image!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : recipeModel.imagePath != null && recipeModel.imagePath!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(
                          recipeModel.imagePath!,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(
                          'assets/image/recipe-word.webp', 
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                        "Type of Meals",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipeModel.mealType ?? "",
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