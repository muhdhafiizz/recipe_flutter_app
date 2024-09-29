import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/ui/widgets/recipe_widget.dart';


import 'search_recipe_controller.dart';

class SearchRecipeScreen extends StatelessWidget {
  final List<RecipeModel> recipes;

  const SearchRecipeScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchRecipeController(recipes),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<SearchRecipeController>(
            builder: (context, controller, child) {
              return TextField(
                onChanged: (value) {
                  controller.filterRecipes(value);
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.brown),
                  hintText: "Search recipe",
                  hintStyle: TextStyle(color: Colors.brown),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
        body: Consumer<SearchRecipeController>(
          builder: (context, controller, child) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: controller.filteredRecipes.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.filteredRecipes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeWidget(controller.filteredRecipes[index]);
                      },
                    )
                  : const Center(
                      child: Text("Recipe not found."),
                    ),
            );
          },
        ),
      ),
    );
  }
}
