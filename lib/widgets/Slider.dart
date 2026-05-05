import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<String> images = [
    'assets/banner-4.webp',
    'assets/banner-2.jpg',
    'assets/banner-3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      ),
    );
  }

}