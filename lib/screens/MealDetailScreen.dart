//Đây sẽ là screen hiển thị chi tiết món ăn được chọn

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {


  const MealDetailScreen ({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        backgroundColor: Colors.deepOrange,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value){
              if(value == 'AddToFavourite'){

              } else if( value == 'option 1'){

              } else if(value == 'option 2'){

              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem<String>(
                value: 'AddToFavourite',
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.black,
                      size: 20,
                    ),
                    Text(
                      'Add to favourite list',
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
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/meal-1.jpg',width: double.infinity,height: 300, fit: BoxFit.cover,),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('Tandoori chicken', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text('India', style: TextStyle(fontSize: 25),)
                ],
              ),
            ),
            Divider(
              color: Colors.grey,      // Màu sắc của đường kẻ
              thickness: 2.0,          // Độ dày của đường kẻ (mặc định rất mỏng)
              indent: 20.0,           // Khoảng trống bên trái (thụt vào đầu dòng)
              endIndent: 20.0,        // Khoảng trống bên phải (thụt vào cuối dòng)
              height: 50.0,           // Khoảng cách tổng cộng mà widget này chiếm (bao gồm cả khoảng trống trên và dưới)
            ),
            Container(
              height: 330,
              width: double.infinity,
              child: Column(
                children: [
                  Text('Ingredients', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 20,
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemBuilder: (context, index) {
                        return Text('Ingredient', style: TextStyle(fontSize: 18),);
                      }
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,      // Màu sắc của đường kẻ
              thickness: 2.0,          // Độ dày của đường kẻ (mặc định rất mỏng)
              indent: 20.0,           // Khoảng trống bên trái (thụt vào đầu dòng)
              endIndent: 20.0,        // Khoảng trống bên phải (thụt vào cuối dòng)
              height: 50.0,           // Khoảng cách tổng cộng mà widget này chiếm (bao gồm cả khoảng trống trên và dưới)
            ),
            Container(
              width: double.infinity,
              height: 500,
              child: Column(
                children: [
                  Text('Instructions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(
                    'Mix the lemon juice with the paprika and red onions in a large shallow dish. Slash each chicken thigh three times, then turn them in the juice and set aside for 10 mins. Mix all of the marinade ingredients together and pour over the chicken. Give everything a good mix, then cover and chill for at least 1 hr. This can be done up to a day in advance. Heat the grill. Lift the chicken pieces onto a rack over a baking tray. Brush over a little oil and grill for 8 mins on each side or until lightly charred and completely cooked through.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}