// List of data to list of widgets ==> .map()
// Eg: Here, we want to use list of dummy_data as list of container widget

import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(20),
        children: DUMMY_CATEGORIES
            .map(
              (catData) => CategoryItem(
                catData.id,
                catData.title,
                catData.color,
              ),
            )
            .toList(),
        // grid design
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // Sliver refers to the scrollable area on the screen
          // DelegateWithMax refers to passing max grid with occupancy of max space col
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2, // times(height for the cross axis)
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
