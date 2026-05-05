//Đây là widget hiển thị các Ingredient phổ biến

import 'package:flutter/material.dart';

class Ingredient extends StatelessWidget {
  final String strIngredient;
  final String strThumb;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const Ingredient({
    super.key,
    required this.strIngredient,
    required this.strThumb,
    required this.onTap,
    required this.onLongPress,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              child: Image.asset(
                strThumb, width: 200, height: 200, fit: BoxFit.cover,
              ),
            ),
            Text(
              strIngredient,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}