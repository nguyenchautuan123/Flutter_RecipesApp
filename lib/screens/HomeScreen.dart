import 'package:flutter/material.dart';
import '../widgets/Slider.dart';
import '../widgets/CountrySelected.dart';
import '../widgets/Ingredient.dart';
import '../widgets/Categories.dart';

import 'MealFromCategoryScreen.dart';
import 'MealFromCountryScreen.dart';
import 'MealFromIngredientScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ImageSlider(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Countries', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
                    ),
                    Container(
                      height: 200,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 110,
                          separatorBuilder: (context, index) => SizedBox(width: 10,),
                          itemBuilder: (context, index) {
                            return CountrySelected(
                              strCountry: "Italy",
                              strCountryThumb: "assets/italy.png",
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCountryScreen(),));
                              },
                              onLongPress: () {},
                            );
                          }
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Categories', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
                    ),
                    Container(
                      height: 270,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        separatorBuilder: (context, index) => SizedBox(width: 10,),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Categories(
                                  strCategory: "Breakfast",
                                  strCategoryThumb: "assets/breakfast.jpg",
                                  onTap:() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCategoryScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                              Categories(
                                  strCategory: "Sea Food",
                                  strCategoryThumb: "assets/seafood.jpg",
                                  onTap:() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCategoryScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                              Categories(
                                  strCategory: "Dessert",
                                  strCategoryThumb: "assets/dessert2.jpg",
                                  onTap:() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCategoryScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                              Categories(
                                  strCategory: "Pasta",
                                  strCategoryThumb: "assets/pasta.jpg",
                                  onTap:() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCategoryScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                              Categories(
                                  strCategory: "Vegetarian",
                                  strCategoryThumb: "assets/vegetarian.jpg",
                                  onTap:() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCategoryScreen(),));
                                  },
                                  onLongPress: () {}),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Popular Ingredients', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
                    ),
                    Container(
                      height: 270,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        separatorBuilder: (context, index) => SizedBox(width: 10,),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Ingredient(
                                  strIngredient: "Chicken",
                                  strThumb: "assets/Chicken-small.png",
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromIngredientScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                              Ingredient(
                                  strIngredient: "Salmon",
                                  strThumb: "assets/Salmon-small.png",
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromIngredientScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                              Ingredient(
                                  strIngredient: "Beef",
                                  strThumb: "assets/Beef-small.png",
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromIngredientScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                              Ingredient(
                                  strIngredient: "Pork",
                                  strThumb: "assets/Pork-small.png",
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromIngredientScreen(),));
                                  },
                                  onLongPress: () {}
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}