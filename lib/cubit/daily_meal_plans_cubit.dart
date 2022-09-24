import 'package:bloc/bloc.dart';
import 'package:canteenplan/models/meal_plan.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'daily_meal_plans_state.dart';

class DailyMealPlansCubit extends Cubit<DailyMealPlansState> {
  final MealPlanRepository _repository;

  DailyMealPlansCubit(this._repository) : super(DailyMealPlansInitial());

  void getMealPlans(List<int> canteenIds, int amountOfDays) async {
    final dates = List.generate(
        amountOfDays,
        (i) => DateFormat("yyyy-MM-dd")
            .format(DateTime.now().add(Duration(days: i))));

    final plans = dates.map((d) => _repository.getMealPlans(canteenIds, d));

    Future.wait(plans).then((value) => emit(DailyMealPlansLoaded(value)));
  }
}
