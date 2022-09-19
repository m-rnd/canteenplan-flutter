import 'package:bloc/bloc.dart';
import 'package:canteenplan/models/meal_plan.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:meta/meta.dart';

part 'daily_meal_plans_state.dart';

class DailyMealPlansCubit extends Cubit<DailyMealPlansState> {
  final MealPlanRepository _repository;
  final Map<String, List<MealPlan>> _cache = {};

  DailyMealPlansCubit(this._repository) : super(DailyMealPlansInitial());

  void getMealPlans(List<int> canteenIds, String date) {
    if (_cache.containsKey(date) && _cache[date]?.length == canteenIds.length) {
      emit(DailyMealPlansLoaded(_cache));
    } else {
      final futures = canteenIds.map((id) => _repository.getMealPlan(id, date));
      Future.wait(futures).then((List<MealPlan> plans) {
        _cache[date] = plans;

        emit(DailyMealPlansLoaded(_cache));
      });
    }
  }
}
