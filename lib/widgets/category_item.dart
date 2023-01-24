import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(this.id, this.title, this.color);

  final Color color;
  final String id;
  final String title;

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // InkWell = GestureDetector + RippleEff
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      //* borderRadius of InkWell should match with the container's borderRadius for proper splash effect
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'RobotoCondensed',
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white10,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
              spreadRadius: 0.1,
              offset: Offset(5, 10),
              blurStyle: BlurStyle.normal,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          //*
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
