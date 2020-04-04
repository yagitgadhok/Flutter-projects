import 'package:flutter/material.dart';
import 'package:meals/dummydata.dart';
import 'package:meals/screens/filter.dart';
import 'package:meals/screens/mealdetailscreen.dart';
import 'package:meals/screens/tabsscreen.dart';
import './models/meal.dart';
import 'screens/categorymeal.dart';
import 'screens/categoryscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availablemeal = DUMMY_MEALS;
  List<Meal> favoritemeal = [];

  void setfilter(Map<String, bool> filterdata) {
    setState(() {
      filters = filterdata;

      availablemeal = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void togglefavorite(String mealid) {
    final existingindex = favoritemeal.indexWhere((meal) => meal.id == mealid);
    if (existingindex >= 0) {
      setState(() {
        favoritemeal.removeAt(existingindex);
      });
    } else {
      setState(() {
        favoritemeal.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealid),
        );
      });
    }
  }

  bool ismealfavorite(String id) {
    return favoritemeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals Itenary',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        canvasColor: Color.fromRGBO(90, 173, 173, 1),
        fontFamily: 'RobotoCondensed-Bold',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(15, 56, 87, 2),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(0, 55, 55, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway-Bold',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => Tabsscreen(favoritemeal),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availablemeal),
        Mealdetailscreen.routeName: (ctx) => Mealdetailscreen(togglefavorite, ismealfavorite),
        Filterscreen.routename: (ctx) => Filterscreen(filters, setfilter),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
