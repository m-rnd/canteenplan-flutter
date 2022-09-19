import 'dart:math';

import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:canteenplan/cubit/daily_meal_plans_cubit.dart';
import 'package:canteenplan/view/home/home_default_layout.dart';
import 'package:canteenplan/view/home/home_empty_layout.dart';
import 'package:canteenplan/view/home/widget/mealplan/meal_plan_card.dart';
import 'package:canteenplan/view/home/widget/top_app_bar/cateen_filter_list.dart';
import 'package:canteenplan/view/home/widget/top_app_bar/day_tab_list.dart';
import 'package:canteenplan/view/router.dart';
import 'package:canteenplan/view/util/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

final Function eq = const ListEquality().equals;

class HomeLayout extends StatelessWidget {
  final amountOfDays = 7;
  late PageController pageController;
  late PageController tabController;

  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CanteenCubit>(context).getCanteens();
    return Scaffold(
        body: BlocBuilder<CanteenCubit, CanteenState>(
            buildWhen: (previous, current) {
      if (previous is CanteensLoaded && current is CanteensLoaded) {
        return !eq(previous.canteens, current.canteens);
      }
      return true;
    }, builder: (context, canteenState) {
      if (canteenState is CanteensLoaded) {
        final canteens = (canteenState).canteens;

        if (canteens.isEmpty) {
          return HomeEmptyLayout();
        } else {
          return HomeDefaultLayout(
              canteenState: canteenState, amountOfDays: amountOfDays);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }));
  }
}
