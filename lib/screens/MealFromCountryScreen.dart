//Đây là screen hiển thị các món ăn theo quốc gia được chọn ở widget CountrySelected.dart

import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../services/meal_service.dart';
import '../widgets/MealCard.dart';
import 'MealDetailScreen.dart';

class MealFromCountryScreen extends StatefulWidget {
  final String strCountry;

  const MealFromCountryScreen({super.key, required this.strCountry});

  @override
  State<MealFromCountryScreen> createState() => _MealFromCountryScreenState();
}

class _MealFromCountryScreenState extends State<MealFromCountryScreen>{
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
      final meals = await MealService.getMealByCountry(widget.strCountry);

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
        title: Text(widget.strCountry),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepOrange,
                Colors.yellow,
              ]
            )
          ),
        ),
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(color: Colors.deepOrange,)
      ) : _error != null ? Center(
        child: Text(_error!),
      ) : _meals.isEmpty ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_meals, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'Khu vực hiện tại chưa cập nhật món ăn',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ): Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          itemCount: _meals.length,
          separatorBuilder: (_,__) => const SizedBox(height: 1,),
          itemBuilder: (context, index) {
            final meal = _meals[index];
            return MealCard(
              strMealThumb: meal.strMealThumb,
              strMeal: meal.strMeal,
              strCountry: widget.strCountry,
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
      )
    );
  }
  
}