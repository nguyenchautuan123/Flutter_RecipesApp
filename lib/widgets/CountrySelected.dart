//ĐÂY LÀ WIDGET SẼ LÀM MỘT BỘ LỌC ĐỂ CHỌN CÁC QUỐC GIA VÀ SẼ DẪN ĐẾN TRANG HIỂN THỊ CÁC MÓN ĂN ĐẾN TỪ QUỐC GIA ĐÓ

import 'package:flutter/material.dart';

class CountrySelected extends StatelessWidget{
  final String strCountry;
  final String strCountryThumb;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CountrySelected({
    super.key,
    required this.strCountry,
    required this.strCountryThumb,
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
                strCountryThumb, width: 150, height: 100, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                  const Icon(Icons.flag, size: 50, color: Colors.grey),
              ),
            ),
            Text(
              strCountry, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}