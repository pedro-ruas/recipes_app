import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.model.dart';
import 'package:recipes_app/screens/meal_details.screen.dart';
import 'package:recipes_app/widgets/meal_item.widget.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
    required this.onToggleMealFavorite,
  });

  final List<Meal> meals;
  final String? title;
  final Function(Meal) onToggleMealFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: onToggleMealFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isNotEmpty
        ? ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelect: (Meal meal) {
                _selectMeal(context, meal);
              },
            ),
          )
        : Center(
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sorry, there's nothing here yet",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  "Try selecting a different category!",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );

    return title == null
        ? content
        : Scaffold(
            appBar: AppBar(
              title: Text(
                title!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            body: content,
          );
  }
}
