import 'dart:io';

class RecipeModel {
  int? id;
  bool isFavorite;
  String name;
  File? image;
  String? ingredients;  
  String? instructions;

  RecipeModel({
    this.id,
    required this.isFavorite,
    required this.name,
    this.image,
    this.ingredients,
    this.instructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isFavorite': isFavorite ? 1 : 0,
      'name': name,
      'image':image == null ? '':image!.path,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }

  
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'],
      isFavorite: map['isFavorite'] == 1 ? true : false,
      name: map['name'],
      image: map['image'] != null ? File(map['image']) : null,
      ingredients: map['ingredients'],
      instructions: map['instructions'],
    );
  }
}
