// IN THIS SCREEN WE ARE FILTERING MEALS BASED UPON CATEGORY ID

// null check ---->> ! -> can't be null; ? -> can be null
// .where() returns iterable so we convert it to list; for cond. we return T/F
import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

// Eg : If chinese is selected as category we want to display noodles, soup, etc
class CategoryMealsScreen extends StatefulWidget {
  // static const prop which can be accessed without initiating class
  // used to avoid typo in main file
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;

  @override
  void initState() {
    //...
    super.initState();
  }

  // we used didChangeDependencies here as context is not workable in initState()
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // getting route arguments
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    // meal represents each of DUMMY_MEALS (object) and to be tested for condition
    // You need widget., if you want to access a method of a stateful widget's class not from this class, but from the related state class.
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals?.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: Theme.of(context).appBarTheme.centerTitle,
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        // ListView builder instead of ListView children as builder only renders contents visible on the screen => better performance
        itemBuilder: (context, index) => MealItem(
          id: displayedMeals![index].id,
          title: displayedMeals![index].title,
          imageUrl: displayedMeals![index].imageUrl,
          duration: displayedMeals![index].duration,
          complexity: displayedMeals![index].complexity,
          affordability: displayedMeals![index].affordability,
        ),
        itemCount: displayedMeals?.length,
      ),
    );
  }
}
