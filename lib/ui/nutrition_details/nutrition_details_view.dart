import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_flutter_app/ui/nutrition_details/nutrition_details_controller.dart';
import 'package:recipe_flutter_app/ui/nutrition_details/nutrition_details_model.dart';
import 'package:recipe_flutter_app/ui/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class NutritionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nutritionController = Provider.of<NutritionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrition Data',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      drawer: const Drawer(
        backgroundColor: Colors.brown,
        child: DrawerList(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                nutritionController.updateIngredient(value.trim());
              },
              decoration: InputDecoration(
                labelText: 'Enter Ingredient',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (nutritionController.ingredient.isNotEmpty) {
                  nutritionController.fetchNutritionData(
                    dotenv.env['APP_ID']!,
                    dotenv.env['APP_KEY']!,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter an ingredient.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: Text(
                'Search Nutrition Data',
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: nutritionController.isLoading
                  ? Center(
                      child: Lottie.asset(
                        'assets/animations/lottie-loading-page.json',
                        width: 200,
                        height: 200,
                      ),
                    )
                  : nutritionController.nutritionData == null
                      ? Center(
                          child: Text('No data fetched yet.'),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            NutritionDetails(
                                nutritionController.nutritionData!),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionDetails extends StatelessWidget {
  final NutritionResponse data;

  const NutritionDetails(this.data);

  @override
  Widget build(BuildContext context) {
    final foodList = data.ingredients
            ?.expand((ingredient) =>
                ingredient.parsed
                    ?.map((parsed) => parsed.food?.capitalize() ?? 'N/A') ??
                [])
            .toList() ??
        ['N/A'];

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${foodList.join(', ')}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Calories: ${data.calories ?? 'N/A'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  'URL: ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (data.uri != null) {
                        final uri = Uri.tryParse(data.uri!);
                        if (uri != null) {
                          launchUrl(uri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid URL'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('URL is null'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      data.uri ?? 'N/A',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CO2 Emissions Class: ${data.co2EmissionsClass ?? 'N/A'}',
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const SimpleDialog(
                          title: Text(
                            'CO2 Emissions Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'What is CO2 Emissions in Nutrients?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'CO2 emissions is the carbon footprint associated with the production, transportation, and preparation of food items. Lower emissions indicate more environmentally friendly practices.',
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'How Are CO2 Emissions Classes Divided?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'CO2 emissions classes categorize foods based on their environmental impact:\n'
                                    '- A: Low emissions (eco-friendly)\n'
                                    '- B: Moderate emissions\n'
                                    '- C: High emissions\n'
                                    '- D: Very high emissions (least eco-friendly)',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.blue,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Total CO2 Emissions: ${data.totalCO2Emissions ?? 'N/A'}'),
            SizedBox(height: 8),
            Text('Total Weight: ${data.totalWeight ?? 'N/A'}'),
            SizedBox(height: 8),
            Text('Ingredients:'),
            if (data.ingredients != null && data.ingredients!.isNotEmpty)
              ...data.ingredients!.map((ingredient) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- ${ingredient.text}'),
                        if (ingredient.parsed != null)
                          ...ingredient.parsed!.map((parsed) => Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Weight: ${parsed.weight?.toStringAsFixed(2) ?? 'N/A'} g'),
                                    if (parsed.nutrients != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Nutrients:'),
                                            ...parsed.nutrients!.entries.map(
                                              (entry) => Text(
                                                '- ${entry.value.label}: ${entry.value.quantity} ${entry.value.unit}',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )),
                      ],
                    ),
                  ))
            else
              Text('No ingredients available.'),
          ],
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
