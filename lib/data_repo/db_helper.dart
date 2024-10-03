import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recipe_flutter_app/ui/home_page/home_page.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'recipes';
  final String columnName = 'name';
  final String columnId = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String columnIngredients = 'ingredients';
  final String columnInstructions = 'instructions';
  final String columnImage = 'image';
  final String imagePath = 'imagePath';
  final String columnMealType = 'mealType';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String path = '$directory/recipes.db';

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $isFavoriteColumn INTEGER, $columnIngredients TEXT, $columnInstructions TEXT, $columnImage TEXT, $imagePath TEXT, $columnMealType TEXT)');

      db.insert(
        tableName,
        {
          columnName: 'Chicken Alfredo',
          isFavoriteColumn: 0,
          columnIngredients: 'Chicken, Fettuccine, Cream, Garlic, Parmesan, Butter',
          columnInstructions: 'Cook pasta. Sauté chicken. Make Alfredo sauce. Combine.',
          columnImage: '',  
          'imagePath': 'assets/image/Chicken-Alfredo-above.jpg',
          columnMealType: 'Lunch' 
        },
      );

      db.insert(
        tableName,
        {
          columnName: 'Spaghetti Carbonara',
          isFavoriteColumn: 0,
          columnIngredients: 'Spaghetti, Eggs, Parmesan, Pancetta, Pepper',
          columnInstructions: 'Cook pasta. Fry pancetta. Mix eggs and cheese. Combine everything.',
          columnImage: '',
          'imagePath':'assets/image/spaghetti-carbonara.webp', 
          columnMealType: 'Lunch'
        },
      );

      db.insert(
        tableName,
        {
    columnName: 'Pancakes',
    isFavoriteColumn: 0,
    columnIngredients: 'Flour, Eggs, Milk, Sugar, Baking Powder, Salt',
    columnInstructions: 'Mix ingredients. Heat a skillet. Pour batter and cook until bubbles form, then flip.',
    columnImage: 'assets/image/pancake.jpg',
    'imagePath':'assets/image/pancake.jpg',  
    columnMealType: 'Breakfast'  
  },
);


db.insert(
  tableName,
  {
    columnName: 'Grilled Salmon',
    isFavoriteColumn: 0,
    columnIngredients: 'Salmon fillets, Olive oil, Lemon, Garlic, Herbs, Salt, Pepper',
    columnInstructions: 'Preheat grill. Brush salmon with oil and season. Grill for 6-8 minutes on each side.',
    columnImage: '',
    'imagePath':'assets/image/grilled-salmon.jpg', 
    columnMealType: 'Dinner' 
  },
);


    },
    onUpgrade: (db, oldVersion, newVersion) {
      db.execute('DROP TABLE IF EXISTS $tableName');
    },
    onDowngrade: (db, oldVersion, newVersion) {
      db.execute('DROP TABLE IF EXISTS $tableName');
    },
  );
}


  Future<List<RecipeModel>> getAllRecipes() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => RecipeModel.fromMap(e)).toList();
  }

  insertNewRecipe (RecipeModel recipeModel){
    database.insert(tableName, recipeModel.toMap());
  }

  deleteOneRecipe (RecipeModel recipeModel){
    database.delete(tableName, where: '$columnId=?', whereArgs: [recipeModel.id]) ;
  }

  deleteAllRecipe(){
    database.delete(tableName);
  }

  updateRecpe(RecipeModel recipeModel) async {
  await database.update(
    tableName,
    {
      isFavoriteColumn: recipeModel.isFavorite ? 1 : 0,
      columnName: recipeModel.name,
      columnImage: recipeModel.image != null ? recipeModel.image!.path : '',
      imagePath: recipeModel.imagePath ?? '',
      columnIngredients: recipeModel.ingredients,
      columnInstructions: recipeModel.instructions,
      columnMealType: recipeModel.mealType,
    },
    where: '$columnId=?',
    whereArgs: [recipeModel.id],
  );
}


  updateFavourite(RecipeModel recipeModel) {
    database.update(
      tableName, 
      {
        isFavoriteColumn: !recipeModel.isFavorite ? 1:0},
        where: '$columnId', whereArgs: [recipeModel.id]);
    }
}
