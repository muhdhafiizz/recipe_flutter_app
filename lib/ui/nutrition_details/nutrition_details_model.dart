
class Ingredient {
  final String text;
  final List<ParsedIngredient>? parsed;

  Ingredient({
    required this.text,
    this.parsed,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      text: json['text'] as String,
      parsed: (json['parsed'] as List?)
          ?.map((item) => ParsedIngredient.fromJson(item))
          .toList(),
    );
  }
}

class ParsedIngredient {
  final double? quantity;
  final String? measure;
  final String? food;
  final String? foodMatch;
  final String? foodId;
  final double? weight;
  final double? retainedWeight;
  final Map<String, Nutrient>? nutrients;

  ParsedIngredient({
    this.quantity,
    this.measure,
    this.food,
    this.foodMatch,
    this.foodId,
    this.weight,
    this.retainedWeight,
    this.nutrients,
  });

  factory ParsedIngredient.fromJson(Map<String, dynamic> json) {
    final nutrientsMap = json['nutrients'] as Map<String, dynamic>?;
    return ParsedIngredient(
      quantity: (json['quantity'] as num?)?.toDouble(),
      measure: json['measure'] as String?,
      food: json['food'] as String?,
      foodMatch: json['foodMatch'] as String?,
      foodId: json['foodId'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      retainedWeight: (json['retainedWeight'] as num?)?.toDouble(),
      nutrients: nutrientsMap?.map(
        (key, value) => MapEntry(key, Nutrient.fromJson(value)),
      ),
    );
  }
}

class Nutrient {
  final String label;
  final double quantity;
  final String unit;

  Nutrient({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      label: json['label'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
    );
  }
}

class NutritionResponse {
  final String? uri;
  final int? calories;
  final List<Ingredient>? ingredients;
  final double? totalCO2Emissions;
  final double? totalWeight;
  final String? co2EmissionsClass;

  NutritionResponse({
    this.uri,
    this.calories,
    this.ingredients,
    this.totalCO2Emissions,
    this.totalWeight,
    this.co2EmissionsClass,
  });

  factory NutritionResponse.fromJson(Map<String, dynamic> json) {
    return NutritionResponse(
      uri: json['uri'] as String?,
      calories: json['calories'] as int?,
      ingredients: (json['ingredients'] as List?)
          ?.map((item) => Ingredient.fromJson(item))
          .toList(),
      totalCO2Emissions: (json['totalCO2Emissions'] as num?)?.toDouble(),
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      co2EmissionsClass: json['co2EmissionsClass'] as String?,
    );
  }
}
