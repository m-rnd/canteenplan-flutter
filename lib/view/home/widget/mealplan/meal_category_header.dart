import 'package:flutter/material.dart';

class MealCategoryHeader extends StatelessWidget {
  final String categoryName;

  const MealCategoryHeader({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(categoryName, style: Theme.of(context).textTheme.overline));
  }
}
