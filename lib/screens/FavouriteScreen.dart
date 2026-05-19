import 'package:flutter/material.dart';
import '../widgets/MealCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/meal_model.dart';
import '../services/favourite_meal_service.dart';
import '../services/meal_service.dart';
import 'MealDetailScreen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Meal> _favouriteMeals = [];

  @override
  void initState(){
    super.initState();
    _loadFavouriteMeal();
  }

  Future<void> _loadFavouriteMeal() async {
    final favouriteList = await FavouriteMealService.getFavouriteMeals();
    setState(() {
      setState(() => _favouriteMeals = favouriteList);
    });
  }

  // Hiển thị Bottom Sheet
  Future<void> _showBottomSheet(Meal meal) async {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  meal.strMeal,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('Delete', style: TextStyle(color: Colors.red),),
                        onTap: () {
                          Navigator.pop(ctx);
                          _confirmDeleteMeal(meal);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  // Xóa 1 món ăn
  Future<void> _confirmDeleteMeal(Meal meal) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete'),
        content: Text('Are you sure to delete "${meal.strMeal}" out of favourite list'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: Colors.grey),),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await FavouriteMealService.deleteMeal(meal.idMeal);
              setState(() {
                _favouriteMeals.removeWhere((m) => m.idMeal == meal.idMeal);
              });
              Fluttertoast.showToast(
                msg: '"${meal.strMeal}" has been deleted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      )
    );
  }

  // Xác nhận trước khi xóa tất cả
  Future<void> _confirmDeleteAll() async{
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete All'),
        content: Text('Are you sure to delete all the meals in favourite list'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await FavouriteMealService.deleteAll();
              setState(() => _favouriteMeals = []);
              Fluttertoast.showToast(
                msg: 'All meals has been deleted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            },
            child: Text('Xóa', style: TextStyle(color: Colors.red)),
          )
        ],
      )
    );
  }

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
                    _confirmDeleteAll();
                  } else if( value == 'option 1'){

                  } else if(value == 'option 2'){

                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem<String>(
                    value: 'DeleteAll',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.black, size: 20),
                        Text('Delete All', style: TextStyle(color: Colors.black),),
                      ],
                    ),
                  ),
                ]
            ),
          ],
        ),
        body: _favouriteMeals.isEmpty ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Chưa có món ăn yêu thích nào',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ) : Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            itemCount: _favouriteMeals.length,
            separatorBuilder: (_,__) => SizedBox(height: 1,),
            itemBuilder: (context, index){
              final meal = _favouriteMeals[index];
              return MealCard(
                strMealThumb: meal.strMealThumb,
                strMeal: meal.strMeal,
                strCountry: meal.strCountry ?? '',
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(idMeal: meal.idMeal),
                    ),
                  );
                  _loadFavouriteMeal(); // ✅ Reload lại sau khi quay về
                },
                onLongPress: () => _showBottomSheet(meal),
              );
            }
          ),
        )
      ),
    );
  }
}