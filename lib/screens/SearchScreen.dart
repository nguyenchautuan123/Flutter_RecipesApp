import 'package:flutter/material.dart';
import 'package:recipes_app/widgets/MealCard.dart';
import '../widgets/SearchBar.dart';
import '../widgets/MealCard.dart';
import 'MealDetailScreen.dart';
import '../models/meal_model.dart';
import '../services/meal_service.dart';
import '../services/favourite_meal_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Meal> _meals = [];
  bool _loading = true;
  bool _isSearching = false;
  String _query = '';

  @override
  void initState(){
    super.initState();
    _loadRandomMeals();
  }

  //Load món ngẫu nhiên
  Future<void> _loadRandomMeals() async {
    setState(() {
      _loading = true;
      _isSearching = false;
    });
    try{
      final meals = await MealService.getRamdomMeals(count: 10);
      setState(() {
        _meals = meals;
        _loading = false;
      });
    }catch(e){
      setState(() => _loading = false);
    }
  }

  // Tìm kiếm món ăn
  Future<void> _searchMeals(String query) async {
    final q = query.trim();
    if(q.isEmpty){
      _loadRandomMeals();
      return;
    }

    setState(() {
      _loading = true;
      _isSearching = true;
      _query = q;
    });

    try{
      final meals = await MealService.searchMeals(q);
      setState(() {
        _loading = false;
        _meals = meals;
      });
    }catch(e){
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
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
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SearchBarWidget(
                onSubmitted: (value) => _searchMeals(value),
                onChanged: (value) {
                  if(value.trim().isEmpty) { _loadRandomMeals(); }
                }
              ),

              SizedBox(height: 12,),

              Text(
                _isSearching ? 'Searching result for "$_query"' : 'Some great meals you might like', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: _loading ? Center(
                  child: CircularProgressIndicator(color: Colors.deepOrange),
                ) : _meals.isEmpty ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No result for "$_query"',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ) : RefreshIndicator(
                  color: Colors.deepOrange,
                  // ✅ Kéo xuống để refresh random mới
                  onRefresh: _isSearching ? () async => _searchMeals(_query) : _loadRandomMeals,
                  child: ListView.separated(
                    itemCount: _meals.length,
                    separatorBuilder: (_,__) => SizedBox(height: 1,),
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
                              builder: (_) => MealDetailScreen(idMeal: meal.idMeal),
                            ),
                          );
                        },
                        onLongPress: () {},
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}