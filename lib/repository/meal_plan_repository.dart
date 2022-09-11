import 'package:canteenplan/models/meal_plan.dart';
import 'package:canteenplan/networking/api_service.dart';

class MealPlanRepository {
  final ApiService _api;

  MealPlanRepository(this._api);

  Future<MealPlan> getMealPlan(int canteenId, String date) async {
    final rawMealPlan = await _api.getMealPlan(canteenId, date) ?? [];
    return MealPlan.fromJSON(canteenId, rawMealPlan);
  }
}
