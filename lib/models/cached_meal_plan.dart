import 'dart:convert';

import 'package:canteenplan/models/meal_plan.dart';

import 'meal.dart';

class CachedMealPlan {
  final int canteenId;
  final DateTime lastModified;
  final List<Meal> meals;

  CachedMealPlan(this.canteenId, this.lastModified, this.meals);

  MealPlan toMealPlan() {
    return MealPlan(canteenId, meals);
  }

  Map toJson() => {
        "canteenId": canteenId,
        "lastModified": lastModified.millisecondsSinceEpoch,
        "meals": jsonEncode(meals.map((e) => e.toJson()).toList())
      };

  CachedMealPlan.fromJSON(Map<String, dynamic> json)
      : canteenId = json["canteenId"],
        lastModified =
            DateTime.fromMillisecondsSinceEpoch(json["lastModified"]),
        meals = (jsonDecode(json["meals"]) as List<dynamic>)
            .map((e) => Meal.fromJSON(e))
            .toList();
}
