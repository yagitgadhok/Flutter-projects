import 'package:flutter/material.dart';
import 'package:meals/dummydata.dart';

class Mealdetailscreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function togglefavorite;
  final Function isfavorite;

  Mealdetailscreen(this.togglefavorite, this.isfavorite);

  Widget buildsectiontitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget buildcontainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealid = ModalRoute.of(context).settings.arguments as String;
    final selectedmeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealid);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedmeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedmeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildsectiontitle(context, 'Ingredients'),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 11),
            //   child: Text(
            //     'Ingredient',
            //     style: Theme.of(context).textTheme.title,
            //   ),
            // ),
            buildcontainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).primaryColorLight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedmeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedmeal.ingredients.length,
              ),
            ),
            buildsectiontitle(context, 'Steps'),
            buildcontainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(
                        selectedmeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedmeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isfavorite(mealid) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => togglefavorite(mealid),
      ),
    );
  }
}
