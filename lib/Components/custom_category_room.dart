import 'package:flutter/material.dart';

class CustomCategoryRoom extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CustomCategoryRoom({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        bool isSelected = selectedCategory == category;

        return GestureDetector(
          onTap: () => onCategorySelected(category),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? Color(0xFF8C7D5D) : Color(0xA6000000),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}
