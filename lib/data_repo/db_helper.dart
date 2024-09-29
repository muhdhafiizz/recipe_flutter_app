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
  final String columnUserID = 'UserID';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = '$directory/recipes.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version){
        db.execute('CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $isFavoriteColumn INTEGER, $columnIngredients TEXT, $columnInstructions TEXT, $columnImage TEXT, $columnUserID TEXT)');
      }, onUpgrade: (db, oldVersion, newVersion) {
          db.execute('CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $isFavoriteColumn INTEGER, $columnIngredients TEXT, $columnInstructions TEXT, $columnImage TEXT, $columnUserID TEXT)');
      }, onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },);
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
    await database.update(tableName,
    {
      isFavoriteColumn: recipeModel.isFavorite ? 1 : 0,
      columnName: recipeModel.name,
      columnImage: recipeModel.image!.path,
      columnIngredients: recipeModel.ingredients,
      columnInstructions: recipeModel.instructions,
    }, where: '$columnId=?',
    whereArgs: [recipeModel.id]);
  }

  updateFavourite(RecipeModel recipeModel) {
    database.update(
      tableName, 
      {
        isFavoriteColumn: !recipeModel.isFavorite ? 1:0},
        where: '$columnId', whereArgs: [recipeModel.id]);
    }
}
