import 'package:flutter/material.dart';
import 'package:recipes_app/data/mock_data.dart';
import 'package:recipes_app/widgets/category_grid_item.widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick your category")),
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: mockCategories
            .map((category) => CategoryGridItem(category: category))
            .toList(),
      ),
    );
  }
}
