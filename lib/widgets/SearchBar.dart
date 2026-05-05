import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget{
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onSubmitted,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: "Search...",
          icon: Icon(Icons.search, color: Colors.black),
        ),
      ),
    );
  }
  
}