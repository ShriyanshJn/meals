import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/detailed_meal_screen.dart';
import './screens/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenfree': false,
    'lactosefree': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        // we want gluten free but the meal isn't gluten free
        if (_filters['glutenfree']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactosefree']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIdx = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    // if already in favorite meal we remove it
    if (existingIdx >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIdx);
      });
    } else {
      // else we add it in favorite
      // existingIdx == -1
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yum Tum',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color.fromARGB(255, 179, 121, 152),
            secondary: Colors.white),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        // fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          // titleTextStyle: TextStyle(
          //   fontFamily: 'Raleway',
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          //   color: Color.fromRGBO(255, 254, 229, 1),
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          centerTitle:
              (defaultTargetPlatform == TargetPlatform.iOS) ? true : false,
          titleTextStyle: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 254, 229, 1),
          ),
          backgroundColor: Color.fromARGB(255, 179, 121, 152),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              // we use copywith here to change the default theme of below parameters only
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // first/root screen of the app
      // home: CategoriesScreen(),
      // named routes for navigating in app
      initialRoute: '/', // default route for home
      routes: {
        // string key to identify a route(screen); value is the creation fx for that screen
        '/': (context) => TabsScreen(_favoriteMeals),
        // accessing static const prop wout initiating class i.e ()
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        DetailedMealScreen.routeName: (context) =>
            DetailedMealScreen(_isFavorite,_toggleFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute is used when we used named route that is not registered in routes
      // Generally used for high scale apps in which there are dynamic routes
      onGenerateRoute: (settings) {
        // print(settings.arguments);
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      // onUnknownRoute is used as a last option when flutter fails to load anything on the screen
      // Can be used to avoid app crashes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
