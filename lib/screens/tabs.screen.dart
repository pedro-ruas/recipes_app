import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.model.dart';
import 'package:recipes_app/screens/categories.screen.dart';
import 'package:recipes_app/screens/filters.screen.dart';
import 'package:recipes_app/screens/meals.screen.dart';
import 'package:recipes_app/widgets/app_drawer.widget.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<FilterType, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message, Function onUndo) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(message),
            TextButton(
              onPressed: () {
                onUndo();
              },
              child: Text("Undo"),
            ),
          ],
        ),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = _favoriteMeals.contains(meal);

    if (isFavorite) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("Meal removed from favorites", () {
        toggleMealFavoriteStatus(meal);
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Meal added to favorites", () {
        toggleMealFavoriteStatus(meal);
      });
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      final appliedFilters = await Navigator.of(context)
          .push<Map<FilterType, bool>>(
            MaterialPageRoute(
              builder: (ctx) => FiltersScreen(initialFilters: _selectedFilters),
            ),
          );

      setState(() {
        _selectedFilters = appliedFilters ?? kInitialFilters;
      });
    }
  }

  List<Tab> get tabs {
    return [
      Tab(
        title: "Categories",
        content: CategoriesScreen(
          onToggleMealFavorite: toggleMealFavoriteStatus,
          appliedFilters: _selectedFilters,
        ),
        label: "Categories",
        icon: Icons.set_meal,
      ),
      Tab(
        title: "Favorite Meals",
        content: MealsScreen(
          meals: _favoriteMeals,
          onToggleMealFavorite: toggleMealFavoriteStatus,
        ),
        label: "Favorites",
        icon: Icons.star,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Tab activeTab = tabs[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activeTab.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      drawer: AppDrawer(onSelectScreen: _setScreen),
      body: activeTab.content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class Tab {
  const Tab({
    required this.title,
    required this.content,
    required this.icon,
    required this.label,
  });

  final String title;
  final Widget content;
  final IconData icon;
  final String label;
}
