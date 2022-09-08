import 'package:bloc/bloc.dart';
import 'package:canteenplan/models/meal_plan.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:meta/meta.dart';

part 'daily_meal_plans_state.dart';

class DailyMealPlansCubit extends Cubit<DailyMealPlansState> {
  final MealPlanRepository _repository;

  DailyMealPlansCubit(this._repository) : super(DailyMealPlansInitial());

  void getMealPlan(int canteenId, String date) {
    _repository
        .getMealPlan(canteenId, date)
        .then((mealPlan) => {emit(DailyMealPlansLoaded(mealPlan))});
  }
}
