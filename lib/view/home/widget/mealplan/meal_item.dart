import 'package:flutter/material.dart';

import '../../../../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> mealTexts = meal.names
        .map((e) => Text(e, style: Theme.of(context).textTheme.subtitle1))
        .toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mealTexts,
        )),
        Text(meal.price.toStringAsFixed(2) + "€",
            style: Theme.of(context).textTheme.bodyMedium)
      ]),
      Text(meal.notes.join(" • "), style: Theme.of(context).textTheme.bodySmall)
    ]);
  }
}
