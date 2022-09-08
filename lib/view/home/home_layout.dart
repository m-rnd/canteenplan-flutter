import 'package:canteenplan/cubit/daily_meal_plans_cubit.dart';
import 'package:canteenplan/view/home/widget/mealplan/meal_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DailyMealPlansCubit>(context).getMealPlan(63, "2022-09-07");

    return BlocBuilder<DailyMealPlansCubit, DailyMealPlansState>(
      builder: (context, state) {
        if (state is DailyMealPlansInitial) {
          return CircularProgressIndicator();
        } else {
          final mealPlan = (state as DailyMealPlansLoaded).mealPlan;

          return MealPlanCard(mealPlan: mealPlan);
        }
      },
    );
  }
}
