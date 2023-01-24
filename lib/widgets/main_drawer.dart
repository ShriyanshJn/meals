// VoidCallBack ~ void Function()

import 'package:TastyMeals/screens/filters_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(BuildContext context, IconData icon, String title,
      VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(255, 254, 229, 1),
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              children: [
                Text(
                  'YUM TUM',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Raleway',
                    fontSize: 30,
                    color: Color.fromARGB(226, 255, 255, 255),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Expanded(
                    child: Image(
                      image: AssetImage('assets/images/3d-white-mushrooms.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(context, Icons.restaurant_menu_rounded, 'Meals', () {
            // pushReplacementNamed replaces the page with the new page
            // while pushNamed create stack of pages upon each other
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile(context, Icons.settings_rounded, 'Filters', () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
