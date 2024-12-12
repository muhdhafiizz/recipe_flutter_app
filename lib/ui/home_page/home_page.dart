import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';
import 'package:recipe_flutter_app/ui/widgets/drawer.dart';
import 'package:recipe_flutter_app/ui/widgets/recipe_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_page_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final controller = HomePageController(recipeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.recipes, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
        actions: [
          InkWell(
            onTap: () => controller.navigateToSearchRecipe(context),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.brown,
        child: DrawerList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.navigateToNewRecipe(context),
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: recipeProvider.allRecipes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return RecipeWidget(recipeProvider.allRecipes[index]);
        },
      ),
    );
  }
}
