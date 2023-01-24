// where runs for all DUMMY_MEALS that returns true
// firstWhere runs till one of the DUMMY_MEALS returns true and stop

// Don't directly add ListView in Column children as both tries to take max height & throws error
// Insted use ListView as a child to Container where the Container is a children of Column

// Future are obj that allows you to specify a fx that execute once they are done with a certain operation

import 'package:flutter/material.dart';
import '../dummy_data.dart';

class DetailedMealScreen extends StatelessWidget {
  const DetailedMealScreen(this.isFavorite, this.toggleFavorite, {Key? key})
      : super(key: key);

  static const routeName = '/detailed-meal-screen';
  final Function isFavorite;
  final Function toggleFavorite;

  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 150,
      width: 300,
      padding: EdgeInsets.all(10),
      child: child,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(1, 1),
            spreadRadius: 0.1,
            blurStyle: BlurStyle.normal,
          ),
        ],
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: Colors.grey[300]!,
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
        appBar: AppBar(
          centerTitle: Theme.of(context).appBarTheme.centerTitle,
          title: Text('${selectedMeal.title}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container to hold image
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      selectedMeal.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                // ListView.builder() as child
                ListView.builder(
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              )),
            ],
          ),
        ),
        // ? Relate meal_item
        // mealId is the result
        floatingActionButton: FloatingActionButton(
          onPressed: () => toggleFavorite(mealId),
          child: Icon(
            isFavorite(mealId)
                ? Icons.star_rounded
                : Icons.star_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ));
  }
}
