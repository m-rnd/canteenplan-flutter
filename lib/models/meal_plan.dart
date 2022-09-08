import '../networking/models/api_meal.dart';
import 'meal.dart';

class MealPlan {
  final int canteenId;
  final List<Meal> meals;

  MealPlan(this.canteenId, this.meals);

// https://codewithandrea.com/articles/parse-json-dart/
  factory MealPlan.fromJSON(int cantenId, List<dynamic> json) {
    final apiMeals = json.map((json) => ApiMeal.fromJson(json)).toList();

    // group simiar meals
    final Map<String, List<ApiMeal>> groupedMeals = {};
    for (var meal in apiMeals) {
      var hash = meal.price.toString() + meal.category + meal.notes.toString();
      groupedMeals.putIfAbsent(hash, () => []);
      groupedMeals[hash]?.add(meal);
    }
    var meals = groupedMeals.values
        .map((apiMealGroup) => apiMealGroup.toMeal())
        .toList();

    return MealPlan(cantenId, meals);
  }
}
