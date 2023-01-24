import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image(
                    image: AssetImage('assets/images/empty-list.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You\'ve no favorites yet!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[600],
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Start adding some',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[600],
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Ink(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    // color: Theme.of(context).colorScheme.primary,
                    color: Color.fromARGB(255, 189, 131, 162),
                  ),
                  child: IconButton(
                    iconSize: 35,
                    color: Colors.white,
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/'),
                    icon: Icon(
                      Icons.add_rounded,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        // ListView builder instead of ListView children as builder only renders contents visible on the screen => better performance
        itemBuilder: (context, index) => MealItem(
          id: favoriteMeals[index].id,
          title: favoriteMeals[index].title,
          imageUrl: favoriteMeals[index].imageUrl,
          duration: favoriteMeals[index].duration,
          complexity: favoriteMeals[index].complexity,
          affordability: favoriteMeals[index].affordability,
        ),
        itemCount: favoriteMeals.length,
      );
    }
  }
}
