import 'package:flutter/material.dart';
import 'package:recipes_app/data/mock_data.dart';
import 'package:recipes_app/models/category.model.dart';
import 'package:recipes_app/screens/meals.screen.dart';
import 'package:recipes_app/widgets/category_grid_item.widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category? category) {
    final categoryMeals = category != null
        ? mockMeals
              .where((meal) => meal.categories.any((id) => id == category.id))
              .toList()
        : mockMeals;

    final title = category != null ? category.title : "All Recipes";

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(meals: categoryMeals, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick your category")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: InkWell(
              onTap: () {
                _selectCategory(context, null);
              },
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey.withAlpha(150),
                      Colors.blueGrey.withAlpha(240),
                    ],
                    begin: AlignmentGeometry.topLeft,
                    end: AlignmentGeometry.bottomRight,
                  ),
                ),
                child: Text(
                  "All Recipes",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView(
              padding: EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                ...mockCategories
                    .map(
                      (category) => CategoryGridItem(
                        category: category,
                        onSelected: (Category category) {
                          _selectCategory(context, category);
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
