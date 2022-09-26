part of 'meal_plans_cubit.dart';

@immutable
abstract class MealPlansState {}

class MealPlansInitial extends MealPlansState {}

class MealPlansLoaded extends MealPlansState {
  final List<List<MealPlan>> mealPlans;

  MealPlansLoaded(this.mealPlans);
}
