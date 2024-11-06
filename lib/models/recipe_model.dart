import 'dart:io';

class RecipeModel {
  int? id;
  bool isFavorite;
  String name;
  File? image;
  String? imagePath;
  String? ingredients;
  String? instructions;
  String mealType;

  RecipeModel(
      {this.id,
      required this.isFavorite,
      required this.name,
      this.image,
      this.imagePath,
      this.ingredients,
      this.instructions,
      required this.mealType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isFavorite': isFavorite ? 1 : 0,
      'name': name,
      'image': image == null ? '' : image!.path,
      'imagePath': imagePath ?? '',
      'ingredients': ingredients,
      'instructions': instructions,
      'mealType': mealType,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
        id: map['id'],
        isFavorite: map['isFavorite'] == 1,
        name: map['name'],
        image: map['image'] != null && map['image'].isNotEmpty
            ? File(map['image'])
            : null,
        imagePath: map['imagePath'] != null && map['imagePath'].isNotEmpty
            ? map['imagePath']
            : null,
        ingredients: map['ingredients'],
        instructions: map['instructions'],
        mealType: map['mealType']);
  }
}
