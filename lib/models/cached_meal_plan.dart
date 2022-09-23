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
}
