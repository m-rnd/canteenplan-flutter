import 'package:flutter/material.dart';

import 'mealplan/meal_plan_card.dart';

class MealPlanGrid extends StatefulWidget {
  const MealPlanGrid({Key? key}) : super(key: key);

  @override
  State<MealPlanGrid> createState() => _MealPlanGridState();
}

class _MealPlanGridState extends State<MealPlanGrid> {
  @override
  Widget build(BuildContext context) {
    List<MealPlanCard> meals = List.empty(growable: true);
    for (int i = 0; i < 10; i++) {
      //meals.add(MealPlanCard());
    }

    return CustomScrollView(slivers: [
      const SliverAppBar(
        pinned: true,
        expandedHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Demo'),
        ),
      ),
      SliverList(delegate: SliverChildListDelegate(meals)),
      SliverList(delegate: SliverChildListDelegate(meals)),
      SliverList(delegate: SliverChildListDelegate(meals))
    ]);
  }
}
