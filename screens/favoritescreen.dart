import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/mealitem.dart';

class Favoritescreen extends StatelessWidget {
  final List<Meal> favoritemeal;
  Favoritescreen(this.favoritemeal);

  @override
  Widget build(BuildContext context) {
    if (favoritemeal.isEmpty) {
      return Center(
        child: Text('You Need To Add Some Favorties!!!!',style: TextStyle(fontSize:25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return Mealitem(
            id: favoritemeal[index].id,
            title: favoritemeal[index].title,
            imageurl: favoritemeal[index].imageUrl,
            duration: favoritemeal[index].duration,
            affordability: favoritemeal[index].affordability,
            complexity: favoritemeal[index].complexity,
          );
        },
        itemCount: favoritemeal.length,
      );
    }
  }
}
