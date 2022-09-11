import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:canteenplan/cubit/daily_meal_plans_cubit.dart';
import 'package:canteenplan/repository/canteen_repository.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:canteenplan/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const ROUTE_MAIN = "/";

class AppRouter {
  final CanteenRepository _canteenRepository;
  final MealPlanRepository _mealPlanRepository;

  AppRouter(this._canteenRepository, this._mealPlanRepository);

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_MAIN:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (BuildContext context) =>
                          CanteenCubit(_canteenRepository),
                    ),
                    BlocProvider(
                      create: (context) =>
                          DailyMealPlansCubit(_mealPlanRepository),
                    ),
                  ],
                  child: const HomePage(),
                ));
      default:
        return null;
    }
  }
}
