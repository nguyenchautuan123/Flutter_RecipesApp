// Đây là Screen hiển thị các món ăn được chọn theo Category

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/meal_service.dart';
import '../models/meal_model.dart';
import '../widgets/MealCard.dart';
import 'MealDetailScreen.dart';

class MealFromCategoryScreen extends StatefulWidget {
  final String strCategory;

  const MealFromCategoryScreen({super.key, required this.strCategory,});

  @override
  State<MealFromCategoryScreen> createState() => _MealFromCategoryScreenState();
}

class _MealFromCategoryScreenState extends State<MealFromCategoryScreen>{
  List<Meal> _meals = [];
  bool _loading = true;
  String? _error;

  @override
  void initState(){
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    try{
      final meals = await MealService.getMealByCategory(widget.strCategory);
      setState(() {
        _meals = meals;
        _loading = false;
      });
    }catch(e){
      setState(() {
        _error = 'Cannot load meals';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.strCategory),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(color: Colors.deepOrange,),
      ) : _error != null ? Center(
        child: Text(_error!),
      ) : _meals.isEmpty ? Center(
        child: Text('No meals found'),
      ) : Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          itemCount: _meals.length,
          separatorBuilder: (_, __) => const SizedBox(height: 1),
          itemBuilder: (context, index) {
            final meal = _meals[index];
            return MealCard(
              strMealThumb: meal.strMealThumb,
              strMeal: meal.strMeal,
              strCountry: meal.strCountry ?? '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MealDetailScreen(idMeal: meal.idMeal), // ✅ truyền idMeal
                  ),
                );
              },
              onLongPress: () {},
            );
          }
        ),
      ),
    );
  }
  
}