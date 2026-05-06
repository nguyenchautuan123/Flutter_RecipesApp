import 'package:flutter/material.dart';
import '../widgets/Slider.dart';
import '../widgets/CountrySelected.dart';
import '../widgets/Ingredient.dart';
import '../widgets/Categories.dart';

import '../services/meal_service.dart';

import 'MealFromCategoryScreen.dart';
import 'MealFromCountryScreen.dart';
import 'MealFromIngredientScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  List<dynamic> _countries = [];
  bool _loadingCountries = true;

  // Hardcode 5 categories — dùng ảnh từ TheMealDB
  final List<Map<String, String>> _categories = [
    {'name': 'Breakfast',   'thumb': 'https://www.themealdb.com/images/category/breakfast.png'},
    {'name': 'Seafood',     'thumb': 'https://www.themealdb.com/images/category/seafood.png'},
    {'name': 'Dessert',     'thumb': 'https://www.themealdb.com/images/category/dessert.png'},
    {'name': 'Pasta',       'thumb': 'https://www.themealdb.com/images/category/pasta.png'},
    {'name': 'Vegetarian',  'thumb': 'https://www.themealdb.com/images/category/vegetarian.png'},
  ];

  // Hardcode 4 ingredients — dùng ảnh từ TheMealDB
  final List<Map<String, String>> _ingredients = [
    {'name': 'Chicken', 'thumb': 'https://www.themealdb.com/images/ingredients/Chicken-Small.png'},
    {'name': 'Salmon',  'thumb': 'https://www.themealdb.com/images/ingredients/Salmon-Small.png'},
    {'name': 'Beef',    'thumb': 'https://www.themealdb.com/images/ingredients/Beef-Small.png'},
    {'name': 'Pork',    'thumb': 'https://www.themealdb.com/images/ingredients/Pork-Small.png'},
  ];

  @override
  void initState(){
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final countries = await MealService.getCountries();
      print('✅ Countries loaded: ${countries.length}'); // debug
      setState(() {
        _countries = countries;
        _loadingCountries = false;
      });
    } catch (e) {
      print('❌ Error: $e'); // debug — xem lỗi là gì
      setState(() => _loadingCountries = false);
    }
  }

  // Map tên quốc gia TheMealDB → ISO code để lấy cờ
  String _getFlagUrl(String country) {
    const codeMap = {
      'American': 'us',   'British': 'gb',    'Canadian': 'ca',
      'Chinese': 'cn',    'Croatian': 'hr',   'Dutch': 'nl',
      'Egyptian': 'eg',   'French': 'fr',     'Greek': 'gr',
      'Indian': 'in',     'Irish': 'ie',      'Italian': 'it',
      'Jamaican': 'jm',   'Japanese': 'jp',   'Kenyan': 'ke',
      'Malaysian': 'my',  'Mexican': 'mx',    'Moroccan': 'ma',
      'Polish': 'pl',     'Portuguese': 'pt', 'Russian': 'ru',
      'Spanish': 'es',    'Thai': 'th',       'Tunisian': 'tn',
      'Turkish': 'tr',    'Ukrainian': 'ua',  'Vietnamese': 'vn',
      'Filipino': 'ph',
    };
    final code = codeMap[country] ?? 'un';
    return 'https://flagcdn.com/w80/$code.png';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ImageSlider(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Countries',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 200,
                      child: _loadingCountries
                          ? const Center(
                          child: CircularProgressIndicator(color: Colors.deepOrange))
                          : _countries.isEmpty
                          ? const Center(child: Text('Không có dữ liệu'))
                          : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _countries.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 5),
                        itemBuilder: (context, index) {
                          final country = _countries[index]['strArea'] ?? '';
                          return CountrySelected(
                            strCountry: country,
                            strCountryThumb: _getFlagUrl(country),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCountryScreen(),));
                            },
                            onLongPress: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categories', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 300,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          return Categories(
                            strCategory: cat['name']!,
                            strCategoryThumb: cat['thumb']!,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromCategoryScreen(),));
                            },
                            onLongPress: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Popular Ingredients', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
                    SizedBox(
                      height: 270,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _ingredients.length,
                        separatorBuilder: (_, __) => SizedBox(width: 10,),
                        itemBuilder: (context, index) {
                          final ing = _ingredients[index];
                          return Ingredient(
                              strIngredient: ing['name']!,
                              strThumb: ing['thumb']!,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MealFromIngredientScreen(),));
                                },
                              onLongPress: () {}
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}