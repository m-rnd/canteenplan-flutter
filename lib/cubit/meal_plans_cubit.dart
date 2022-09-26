import 'package:bloc/bloc.dart';
import 'package:canteenplan/models/meal_plan.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'meal_plans_state.dart';

class DailyMealPlansCubit extends Cubit<MealPlansState> {
  final MealPlanRepository _repository;

  DailyMealPlansCubit(this._repository) : super(MealPlansInitial());

  void getMealPlans(List<int> canteenIds, int amountOfDays) async {
    final dates = List.generate(
        amountOfDays,
        (i) => DateFormat("yyyy-MM-dd")
            .format(DateTime.now().add(Duration(days: i))));

    final plans = dates.map((d) => _repository.getMealPlans(canteenIds, d));

    Future.wait(plans).then((value) => emit(MealPlansLoaded(value)));
  }
}
