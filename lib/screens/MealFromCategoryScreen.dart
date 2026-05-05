// Đây là Screen hiển thị các món ăn được chọn theo Category

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealFromCategoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  
}