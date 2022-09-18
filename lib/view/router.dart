import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:canteenplan/cubit/canteen_search_cubit.dart';
import 'package:canteenplan/cubit/daily_meal_plans_cubit.dart';
import 'package:canteenplan/main.dart';
import 'package:canteenplan/repository/canteen_search_repository.dart';
import 'package:canteenplan/repository/canteen_repository.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:canteenplan/view/dialog_add_canteen/add_canteen_dialog.dart';
import 'package:canteenplan/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const ROUTE_MAIN = "/";
const ROUTE_ADD_CANTEEN = "/add_canteen";

class AppRouter {
  final CanteenRepository _canteenRepository;
  final CanteenSearchRepository _canteenSearchRepository;
  final MealPlanRepository _mealPlanRepository;

  AppRouter(this._canteenRepository, this._mealPlanRepository,
      this._canteenSearchRepository);

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
      case ROUTE_ADD_CANTEEN:
        return DialogRoute(
            context: navigatorKey.currentContext!,
            builder: (_) => BlocProvider(
                  create: (context) => CanteenSearchCubit(
                      _canteenRepository, _canteenSearchRepository),
                  child: const AddCanteenDialog(),
                ));
      default:
        return null;
    }
  }
}
