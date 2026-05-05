import 'package:flutter/material.dart';

import 'screens/HomeScreen.dart';
import 'screens/SearchScreen.dart';
import 'screens/FavouriteScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(
      ),
    );
  }
}

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  int _selectedScreen = 0;

  final List<Widget> _screen = [
    const HomeScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
  ];

  void _onScreenSelected(int screen){
    setState(() {
      _selectedScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedScreen],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreen,
        onTap: _onScreenSelected,
        selectedItemColor: Colors.deepOrange,
        selectedIconTheme: const IconThemeData(
          color: Colors.deepOrange,
        ),
        selectedLabelStyle: const TextStyle(
          color: Colors.deepOrange,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: 'Favourite',
          ),
        ],
      ),
    );
  }
  
}