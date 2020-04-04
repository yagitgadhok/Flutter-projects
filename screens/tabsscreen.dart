import 'package:flutter/material.dart';
import 'package:meals/screens/favoritescreen.dart';
import 'package:meals/widgets/namedrawer.dart';
import './categoryscreen.dart';
import '../models/meal.dart';

class Tabsscreen extends StatefulWidget {
  final List<Meal> favoritemeal;

  Tabsscreen(this.favoritemeal);

  @override
  _TabsscreenState createState() => _TabsscreenState();
}

class _TabsscreenState extends State<Tabsscreen> {
  List<Map<String, Object>> pages;
  int selectedpageindex = 0;

  @override
  void initState() {
    pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': Favoritescreen(widget.favoritemeal),
        'title': 'Favorites',
      },
    ];
    super.initState();
  }

  void selectpage(int index) {
    setState(() {
      selectedpageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[selectedpageindex]['title']),
      ),
      drawer: Maindrawer(),
      body: pages[selectedpageindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectpage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.orange,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedpageindex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text(
              'Category',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.stars),
            title: Text(
              'Favourites',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
