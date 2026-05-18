//Đây sẽ là screen hiển thị chi tiết món ăn được chọn

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/meal_service.dart';
import '../services/favourite_meal_service.dart';
import '../models/meal_model.dart';

class MealDetailScreen extends StatefulWidget {
  final String idMeal;

  const MealDetailScreen({super.key, required this.idMeal});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Meal? _meal;
  bool _loading = true;
  String? _error;
  bool _isFavourite = false;

  @override
  void initState(){
    super.initState();
    _fetchMealDetail();
  }

  Future<void> _fetchMealDetail() async {
    try{
      final meal = await MealService.getMealDetail(widget.idMeal);
      final isFavourite = await FavouriteMealService.isFavourite(widget.idMeal);
      setState(() {
        _meal = meal;
        _isFavourite = isFavourite;
        _loading = false;
      });
    }catch(e){
      setState(() {
        _error = 'Cannot load meal detail';
        _loading = false;
      });
    }
  }

  // ✅ Hàm thêm vào favourite
  Future<void> _addToFavourite() async {
    if(_meal == null) { return; }
    final success = await FavouriteMealService.addFavouriteMeal(_meal!);
    if(success){
      setState(() => _isFavourite = true );
      Fluttertoast.showToast(
        msg: 'Meal has been add to favourite list',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Meal has been in favourite list already',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_meal?.strMeal ?? 'Detail'),
        backgroundColor: Colors.deepOrange,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value){
              if(value == 'AddToFavourite'){
                _addToFavourite();
              } else if( value == 'option 1'){

              } else if(value == 'option 2'){

              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem<String>(
                value: 'AddToFavourite',
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: _isFavourite ? Colors.deepOrange : Colors.black, size: 20,),
                    Text(_isFavourite ? 'Favourite' : 'Add to favourite list', style: TextStyle(color: Colors.black ,),),
                  ],
                ),
              ),
            ]
          ),
        ],
      ),
      body: _loading ? Center(
          child: CircularProgressIndicator(color: Colors.deepOrange)
      ) : _error != null ? Center(
          child: Text(_error!)
      ) : _meal == null ? Center(
          child: Text('Cannot load meal detail')
      ) : _buildMealDetail()
    );
  }

  Widget _buildMealDetail() {
    final meal = _meal!;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
          child: Image.network(
            meal.strMealThumb,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 300,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(
                meal.strMeal,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    meal.strCountry ?? 'Unknown',
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  const SizedBox(width: 10,),
                  Icon(Icons.circle, size: 10, color: Colors.black,),
                  const SizedBox(width: 10,),
                  Text(
                    meal.strCategory ?? 'Unknown',
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),

        const Divider(
          color: Colors.grey,
          thickness: 1.5,
          indent: 20,
          endIndent: 20,
          height: 40,
        ),

        Text(
          'Ingredients',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: meal.ingredients.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.deepOrange),
                  const SizedBox(width: 10),
                  Text(
                    '${meal.measures[index]}  ${meal.ingredients[index]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
        ),

        const Divider(
          color: Colors.grey,
          thickness: 1.5,
          indent: 20,
          endIndent: 20,
          height: 40,
        ),

        Text(
          'Instructions',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          meal.strInstructions ?? 'No instructions',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}