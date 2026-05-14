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
      'Afghanistan': 'af',
      'Albania': 'al',
      'Algeria': 'dz',
      'Andorra': 'ad',
      'Angola': 'ao',
      'Antigua and Barbuda': 'ag',
      'Argentina': 'ar',
      'Armenia': 'am',
      'Aruba': 'aw',
      'Australia': 'au',
      'Austria': 'at',
      'Azerbaijan': 'az',

      'Bahamas': 'bs',
      'Bahrain': 'bh',
      'Bangladesh': 'bd',
      'Barbados': 'bb',
      'Belarus': 'by',
      'Belgium': 'be',
      'Belize': 'bz',
      'Benin': 'bj',
      'Bermuda': 'bm',
      'Bhutan': 'bt',
      'Bolivia': 'bo',
      'Bosnia and Herzegovina': 'ba',
      'Botswana': 'bw',
      'Brazil': 'br',
      'Brunei': 'bn',
      'Bulgaria': 'bg',
      'Burkina Faso': 'bf',
      'Burundi': 'bi',

      'Cambodia': 'kh',
      'Cameroon': 'cm',
      'Canada': 'ca',
      'Cape Verde': 'cv',
      'Cayman Islands': 'ky',
      'Central African Republic': 'cf',
      'Chad': 'td',
      'Chile': 'cl',
      'China': 'cn',
      'Colombia': 'co',
      'Costa Rica': 'cr',
      'Croatia': 'hr',
      'Cuba': 'cu',
      'Cyprus': 'cy',
      'Czechia': 'cz',

      'Denmark': 'dk',
      'Djibouti': 'dj',
      'Dominica': 'dm',
      'Dominican Republic': 'do',
      'DR Congo': 'cd',

      'Ecuador': 'ec',
      'Egypt': 'eg',
      'El Salvador': 'sv',
      'Equatorial Guinea': 'gq',
      'Eritrea': 'er',
      'Estonia': 'ee',
      'Ethiopia': 'et',

      'Faroe Islands': 'fo',
      'Fiji': 'fj',
      'Finland': 'fi',
      'France': 'fr',

      'Gabon': 'ga',
      'Gambia': 'gm',
      'Georgia': 'ge',
      'Germany': 'de',
      'Ghana': 'gh',
      'Gibraltar': 'gi',
      'Greece': 'gr',
      'Greenland': 'gl',
      'Grenada': 'gd',
      'Guadeloupe': 'gp',
      'Guam': 'gu',
      'Guatemala': 'gt',
      'Guernsey': 'gg',
      'Guinea': 'gn',
      'Guinea-Bissau': 'gw',
      'Guyana': 'gy',

      'Haiti': 'ht',
      'Honduras': 'hn',
      'Hong Kong': 'hk',
      'Hungary': 'hu',

      'Iceland': 'is',
      'India': 'in',
      'Indonesia': 'id',
      'Iran': 'ir',
      'Iraq': 'iq',
      'Ireland': 'ie',
      'Israel': 'il',
      'Italy': 'it',
      'Ivory Coast': 'ci',

      'Jamaica': 'jm',
      'Japan': 'jp',
      'Jersey': 'je',
      'Jordan': 'jo',

      'Kazakhstan': 'kz',
      'Kenya': 'ke',
      'Kosovo': 'xk',
      'Kuwait': 'kw',
      'Kyrgyzstan': 'kg',

      'Laos': 'la',
      'Latvia': 'lv',
      'Lebanon': 'lb',
      'Lesotho': 'ls',
      'Liberia': 'lr',
      'Libya': 'ly',
      'Liechtenstein': 'li',
      'Lithuania': 'lt',
      'Luxembourg': 'lu',

      'Madagascar': 'mg',
      'Malawi': 'mw',
      'Malaysia': 'my',
      'Maldives': 'mv',
      'Mali': 'ml',
      'Malta': 'mt',
      'Mauritius': 'mu',
      'Mexico': 'mx',
      'Moldova': 'md',
      'Mongolia': 'mn',
      'Montenegro': 'me',
      'Morocco': 'ma',
      'Mozambique': 'mz',
      'Myanmar': 'mm',

      'Namibia': 'na',
      'Nepal': 'np',
      'Netherlands': 'nl',
      'New Zealand': 'nz',
      'Nicaragua': 'ni',
      'Niger': 'ne',
      'Nigeria': 'ng',
      'North Korea': 'kp',
      'North Macedonia': 'mk',
      'Norway': 'no',

      'Oman': 'om',

      'Pakistan': 'pk',
      'Palestine': 'ps',
      'Panama': 'pa',
      'Papua New Guinea': 'pg',
      'Paraguay': 'py',
      'Peru': 'pe',
      'Philippines': 'ph',
      'Poland': 'pl',
      'Portugal': 'pt',
      'Puerto Rico': 'pr',

      'Qatar': 'qa',

      'Republic of the Congo': 'cg',
      'Romania': 'ro',
      'Russia': 'ru',
      'Rwanda': 'rw',

      'Saint Lucia': 'lc',
      'Samoa': 'ws',
      'San Marino': 'sm',
      'Saudi Arabia': 'sa',
      'Senegal': 'sn',
      'Serbia': 'rs',
      'Seychelles': 'sc',
      'Sierra Leone': 'sl',
      'Singapore': 'sg',
      'Slovakia': 'sk',
      'Slovenia': 'si',
      'Solomon Islands': 'sb',
      'Somalia': 'so',
      'South Africa': 'za',
      'South Korea': 'kr',
      'South Sudan': 'ss',
      'Spain': 'es',
      'Sri Lanka': 'lk',
      'Sudan': 'sd',
      'Suriname': 'sr',
      'Sweden': 'se',
      'Switzerland': 'ch',
      'Syria': 'sy',

      'Taiwan': 'tw',
      'Tajikistan': 'tj',
      'Tanzania': 'tz',
      'Thailand': 'th',
      'Togo': 'tg',
      'Tonga': 'to',
      'Trinidad and Tobago': 'tt',
      'Tunisia': 'tn',
      'Turkey': 'tr',
      'Turkmenistan': 'tm',
      'Tuvalu': 'tv',

      'Uganda': 'ug',
      'Ukraine': 'ua',
      'United Arab Emirates': 'ae',
      'United Kingdom': 'gb',
      'United States': 'us',
      'Uruguay': 'uy',
      'Uzbekistan': 'uz',

      'Vanuatu': 'vu',
      'Venezuela': 've',
      'Vietnam': 'vn',

      'Yemen': 'ye',

      'Zambia': 'zm',
      'Zimbabwe': 'zw',
    };
    final code = codeMap[country] ?? 'un';
    return 'https://flagcdn.com/w1280/$code.png';
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
                          final country = _countries[index]['strCountry'] ?? '';
                          return CountrySelected(
                            strCountry: country,
                            strCountryThumb: _getFlagUrl(country),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MealFromCountryScreen(strCountry: country),
                                ),
                              );
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
                              Navigator.push(context, MaterialPageRoute(builder: (_) => MealFromCategoryScreen(strCategory: cat['name']!),));
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
                                Navigator.push(context, MaterialPageRoute(builder: (_) => MealFromIngredientScreen(strIngredient: ing['name']!,),));
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