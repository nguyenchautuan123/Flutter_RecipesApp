// ĐÂY LÀ MÀN HÌNH HIỂN THỊ CÁC MÓN ĂN THEO INGREDIENT ĐƯỢC CHỌN TỪ WIDGET Ingredient.dart

import 'package:flutter/material.dart';
import '../services/meal_service.dart';
import '../models/meal_model.dart';
import '../widgets/MealCard.dart';
import 'MealDetailScreen.dart';

class MealFromIngredientScreen extends StatefulWidget{
  final String strIngredient;

  const MealFromIngredientScreen({super.key, required this.strIngredient});

  @override
  State<MealFromIngredientScreen> createState() => _MealFromIngredientScreen();
}

class _MealFromIngredientScreen extends State<MealFromIngredientScreen>{
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
      final meals = await MealService.getMealsByIngredient(widget.strIngredient);
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
        title: Text(widget.strIngredient),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(color: Colors.deepOrange,),
      ) : _error != null ? Center (
        child: Text(_error!),
      ) : _meals.isEmpty ? Center (
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