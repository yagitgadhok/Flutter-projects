import 'package:flutter/material.dart';
import 'package:meals/widgets/namedrawer.dart';

class Filterscreen extends StatefulWidget {
  static const routename = '/filter';

  final Function savefilter;
  final Map<String, bool> currentfilters;

  Filterscreen(this.currentfilters, this.savefilter);

  @override
  _FilterscreenState createState() => _FilterscreenState();
}

class _FilterscreenState extends State<Filterscreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentfilters['gluten'];
    _lactoseFree = widget.currentfilters['lactose'];
    _vegetarian = widget.currentfilters['vegetarian'];
    _vegan = widget.currentfilters['vegan'];
    super.initState();
  }

  Widget buildswitchlisttile(
    String title,
    String description,
    bool currentvalue,
    Function updatevalue,
  ) {
    return SwitchListTile(
        title: Text(title),
        value: currentvalue,
        subtitle: Text(description),
        onChanged: updatevalue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              final selectedfilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.savefilter(selectedfilters);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final selectedfilters = {
            'gluten': _glutenFree,
            'lactose': _lactoseFree,
            'vegan': _vegan,
            'vegetarian': _vegetarian,
          };
          widget.savefilter(selectedfilters);
        },
        child: Icon(Icons.save_alt),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Maindrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildswitchlisttile(
                  'Gluten Free',
                  'Only Include Gluten Free Meal',
                  _glutenFree,
                  (newvalue) {
                    setState(() {
                      _glutenFree = newvalue;
                    });
                  },
                ),
                buildswitchlisttile(
                  'Lactose Free',
                  'Only Include Lactosr Free Meal',
                  _lactoseFree,
                  (newvalue) {
                    setState(() {
                      _lactoseFree = newvalue;
                    });
                  },
                ),
                buildswitchlisttile(
                  'Vegetarian',
                  'Only Include Vegetarian Meal',
                  _vegetarian,
                  (newvalue) {
                    setState(() {
                      _vegetarian = newvalue;
                    });
                  },
                ),
                buildswitchlisttile(
                  'Vegan',
                  'Only Include Vegan Meal',
                  _vegan,
                  (newvalue) {
                    setState(() {
                      _vegan = newvalue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
