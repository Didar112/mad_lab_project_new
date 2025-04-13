import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategorySelector({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'general', 'business', 'entertainment', 'health', 'science', 'sports', 'technology'
    ];

    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onCategorySelected(categories[index]),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  categories[index].toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}