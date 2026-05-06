import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final String strCategory;
  final String strCategoryThumb;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const Categories({
    super.key,
    required this.strCategory,
    required this.strCategoryThumb,
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
              child: Image.network(
                strCategoryThumb,width: 300, height: 200, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                  const Icon(Icons.category, size: 100, color: Colors.grey),
              ),
            ),
            Text(
              strCategory,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}