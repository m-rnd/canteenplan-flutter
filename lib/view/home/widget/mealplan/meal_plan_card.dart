import 'dart:math';

import 'package:canteenplan/models/meal_plan.dart';
import 'package:flutter/material.dart';

import '../../../../models/meal.dart';
import 'meal_category_header.dart';
import 'meal_item.dart';

class MealPlanCard extends StatelessWidget {
  final MealPlan mealPlan;

  MealPlanCard({Key? key, required this.mealPlan}) : super(key: key);

  final mealCount = Random.secure().nextInt(10);

  @override
  Widget build(BuildContext context) {
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

    return Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
            width: 400,
            child: Card(
                elevation: 0,
                color: generateRandomColor1(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: listItems)))));
  }
}

Color generateRandomColor1() {
  // Define all colors you want here
  const predefinedColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.white
  ];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}
