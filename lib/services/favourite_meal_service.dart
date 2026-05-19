import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';

class FavouriteMealService {
  static const String _key = 'favourite_meals';

  //Lấy danh sách yêu thích
  static Future<List<Meal>> getFavouriteMeals() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonList = preferences.getStringList(_key) ?? [];
    return jsonList .map((e) => Meal.fromJson(jsonDecode(e))).toList();
  }

  //Thêm món ăn yêu thích
  static Future<bool> addFavouriteMeal(Meal meal) async {
    final preferences = await SharedPreferences.getInstance();
    final jsonList = preferences.getStringList(_key) ?? [];

    // Kiểm tra đã có trong danh sách chưa
    final exists = jsonList.any((e) {
      final item = jsonDecode(e);
      return item['idMeal'] == meal.idMeal;
    });
    
    if(exists){
      return false;
    }
    
    jsonList.add(jsonEncode(meal.toJson()));
    await preferences.setStringList(_key, jsonList);
    return true;
  }

  // Xóa tất cả yêu thích
  static Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  //Xóa món ăn
  static Future<void> deleteMeal(String idMeal) async {
   final preferences = await SharedPreferences.getInstance();
   final jsonList = preferences.getStringList(_key) ?? [];

   jsonList.removeWhere((e) {
     final item = jsonDecode(e);
     return item['idMeal'] == idMeal;
   });

   await preferences.setStringList(_key, jsonList);
  }

  // Kiểm tra món ăn có trong yêu thích không
  static Future<bool> isFavourite(String idMeal) async {
    final preferences = await SharedPreferences.getInstance();
    final jsonList = preferences.getStringList(_key) ?? [];
    return jsonList.any((e) {
      final item = jsonDecode(e);
      return item['idMeal'] == idMeal;
    });
  }
}