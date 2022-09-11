part of 'daily_meal_plans_cubit.dart';

@immutable
abstract class DailyMealPlansState {}

class DailyMealPlansInitial extends DailyMealPlansState {}

class DailyMealPlansLoaded extends DailyMealPlansState {
  final Map<String, List<MealPlan>> mealPlans;

  DailyMealPlansLoaded(this.mealPlans);
}
