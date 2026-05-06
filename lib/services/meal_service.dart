import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal_model.dart';

class MealService {
  static const String API_URL = 'http://192.168.1.98:8000/api';

  // Tìm kiếm món ăn
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('$API_URL/meals/search?q=$query'),
    );
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final meals = data['meals'];
      if(meals == null){
        return [];
      }
      return (meals as List).map((m) => Meal.fromJson(m)).toList();
    }
    throw Exception('Lỗi tìm kiếm món ăn');
  }

  // Lấy tất cả categories
  static Future<List<dynamic>> getCategories() async {
    final response = await http.get(Uri.parse('$API_URL/meals/categories'));
    if(response.statusCode == 200){
      return jsonDecode(response.body)['categories'] ?? [];
    }
    throw Exception('Lỗi lấy category');
  }

  // Lấy món ăn theo category
  static Future<List<Meal>> getMealByCategory(String category) async {
    final response = await http.get(Uri.parse('$API_URL/meals/by-category?c=$category'));
    if(response.statusCode == 200){
      final meals = jsonDecode(response.body)['meals'];
      if(meals == null){
        return [];
      }
      return(meals as List).map((m) => Meal.fromJson(m)).toList();
    }
    throw Exception('Lỗi lấy món ăn theo category');
  }
  
  //Lấy món ăn theo quốc gia
  static Future<List<Meal>> getMealByCountry(String area) async {
    final response = await http.get(
      Uri.parse('$API_URL/meals/by-country?a=$area'),
    );
    if (response.statusCode == 200) {
      final meals = jsonDecode(response.body)['meals'];
      if (meals == null) {
        return [];
      }
      return (meals as List).map((m) => Meal.fromJson(m)).toList();
    }
    throw Exception('Không thể lấy món ăn theo quốc gia');
  }

  // Lấy món ăn theo ingredient
  static Future<List<Meal>> getMealsByIngredient(String ingredient) async {
    final response = await http.get(
      Uri.parse('$API_URL/meals/by-ingredient?i=$ingredient'),
    );
    if (response.statusCode == 200) {
      final meals = jsonDecode(response.body)['meals'];
      if (meals == null) return [];
      return (meals as List).map((m) => Meal.fromJson(m)).toList();
    }
    throw Exception('Lỗi lấy món theo ingredient');
  }

  // Lấy chi tiết món ăn
  static Future<Meal?> getMealDetail(String id) async {
    final response = await http.get(Uri.parse('$API_URL/meals/$id'));
    if (response.statusCode == 200) {
      final meals = jsonDecode(response.body)['meals'];
      if (meals == null || meals.isEmpty) return null;
      return Meal.fromJson(meals[0]);
    }
    throw Exception('Lỗi lấy chi tiết món');
  }

  // Lấy danh sách quốc gia
  static Future<List<dynamic>> getCountries() async {
    final response = await http.get(Uri.parse('$API_URL/meals/countries'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['meals'] ?? [];
    }
    throw Exception('Lỗi lấy danh sách quốc gia');
  }
}