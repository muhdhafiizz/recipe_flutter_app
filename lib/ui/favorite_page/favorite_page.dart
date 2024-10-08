import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';
import 'package:recipe_flutter_app/ui/widgets/recipe_widget.dart';

import 'favorite_page_controller.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritePageController(Provider.of<RecipeProvider>(context, listen: false)),
      child: Consumer<FavoritePageController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown,
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Favorite Recipes",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () => controller.searchFavorites(context),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: controller.favoriteRecipes.length,
              itemBuilder: (context, index) {
                return RecipeWidget(controller.favoriteRecipes[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
