import 'package:flutter/material.dart';
import 'package:recipes_app/widgets/MealCard.dart';
import '../widgets/SearchBar.dart';
import 'MealDetailScreen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SearchBarWidget(),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(height: 1,),
                    itemBuilder: (context, index) {
                      return MealCard(
                          strMealThumb: "assets/meal-1.jpg",
                          strMeal: 'Tandoori chicken',
                          strCountry: 'India',
                          onTap: () {

                          },
                          onLongPress: () {},
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}