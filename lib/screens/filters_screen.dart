import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters-screen';
  final Map<String, bool> currentFilters;
  final Function saveFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenfree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactosefree = false;

  // setting initial state of filters screen with previous state
  @override
  void initState() {
    super.initState();
    // You need widget., if you want to access a method of a stateful widget's class not from this class, but from the related state class.
    _glutenfree = widget.currentFilters['glutenfree']!;
    _lactosefree = widget.currentFilters['lactosefree']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
  }

  Widget _buildSwitchListTile(
      String title, String description, var flag, Function(bool) update) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.primary,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      value: flag,
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
        ),
        actions: [
          IconButton(
            onPressed: () {
              final filters = {
                'glutenfree': _glutenfree,
                'lactosefree': _lactosefree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              // You need widget., if you want to access a method of a stateful widget's class not from this class, but from the related state class.
              widget.saveFilters(filters);
              Navigator.of(context).pushReplacementNamed('/');
            },
            icon: Icon(
              Icons.save_rounded,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-Free', 'Only include gluten-free meals', _glutenfree,
                  (newValue) {
                setState(() {
                  _glutenfree = newValue;
                });
              }),
              _buildSwitchListTile('Lactose-Free',
                  'Only include lactose-free meals', _lactosefree, (newValue) {
                setState(() {
                  _lactosefree = newValue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include vegan meals', _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
            ],
          ),
        )
      ]),
    );
  }
}
