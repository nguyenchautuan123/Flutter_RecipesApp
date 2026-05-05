import 'package:flutter/material.dart';
import '../widgets/MealCard.dart';
import 'MealDetailScreen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Favourite'),
          backgroundColor: Colors.deepOrange,
          actions: [
            PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (value){
                  if(value == 'DeleteAll'){

                  } else if( value == 'option 1'){

                  } else if(value == 'option 2'){

                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem<String>(
                    value: 'DeleteAll',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 20,
                        ),
                        Text(
                          'Delete All',
                          style: TextStyle(
                            color: Colors.black ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 1,),
            itemBuilder: (context, index) {
              return MealCard(
                strMealThumb: "assets/meal-1.jpg",
                strMeal: "Tandoori chicken",
                  strCountry: "India",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MealDetailScreen(),));
                },
                onLongPress: () {}
              );
            }
          ),
        ),
      ),
    );
  }
}