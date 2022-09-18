import 'dart:math';

import 'package:canteenplan/models/meal_plan.dart';
import 'package:flutter/material.dart';

import '../../../../models/canteen_color.dart';
import '../../../../models/meal.dart';
import 'meal_category_header.dart';
import 'meal_item.dart';

class MealPlanCard extends StatelessWidget {
  final MealPlan mealPlan;
  final Color color;

  MealPlanCard({Key? key, required this.mealPlan, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (mealPlan.meals.isEmpty) {
      content = Row(children: const [
        Expanded(
            child: Center(
                child: Text("Kein Speiseplan für diesen Tag verfügbar.")))
      ]);
    } else {
      content = _buildMealPlan();
    }

    return Align(
        alignment: Alignment.topLeft,
        child: Card(
            elevation: 0,
            color: color.withAlpha(30),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: color,
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(padding: const EdgeInsets.all(16), child: content)));
  }

  Widget _buildMealPlan() {
    // group meals by category
    final Map<String, List<Meal>> groupedMeals = {};
    for (var meal in mealPlan.meals) {
      groupedMeals.putIfAbsent(meal.category, () => []);
      groupedMeals[meal.category]?.add(meal);
    }

    // create list items
    List<Widget> listItems = [];

    for (var group in groupedMeals.entries) {
      final category = group.key;
      final meals = group.value;
      listItems.add(MealCategoryHeader(categoryName: category));
      meals.asMap().forEach((key, value) {
        listItems.add(MealItem(meal: value));
        if (key < meals.length - 1) {
          listItems.add(const Divider());
        }
      });
    }
    return Column(children: listItems);
  }
}
