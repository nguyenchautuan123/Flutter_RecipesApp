//Đây là screen hiển thị các món ăn theo quốc gia được chọn ở widget CountrySelected.dart

import 'package:flutter/material.dart';

class MealFromCountryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country'),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  
}