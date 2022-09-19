import 'dart:math';

import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:canteenplan/cubit/daily_meal_plans_cubit.dart';
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

  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext parentContext) {
    PageController pageController;
    PageController tabController;

    final amountChildren =
        min(MediaQuery.of(parentContext).size.width ~/ 400, amountOfDays);

    pageController = PageController(viewportFraction: 1 / amountChildren);
    tabController = PageController(viewportFraction: 1 / amountChildren);

    pageController.addListener(() {
      if (tabController.positions.isNotEmpty) {
        tabController.jumpTo(pageController.offset);
      }
    });

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(parentContext, ROUTE_ADD_CANTEEN);
              },
              splashRadius: 24,
            )
          ],
          title: const CanteenList(),
          centerTitle: true,
          bottom: DayTabList(
              pageController: tabController, amountOfDays: amountOfDays),
        ),
        SliverToBoxAdapter(
            child: BlocBuilder<CanteenCubit, CanteenState>(
          buildWhen: (previous, current) {
            if (previous is CanteensLoaded && current is CanteensLoaded) {
              return !eq(previous.canteens, current.canteens);
            }
            return true;
          },
          builder: (context, canteenState) {
            final mealPlans = List.generate(amountOfDays,
                (i) => _buildMealPlansWithDateOffset(context, i, canteenState));

            return ExpandablePageView(
                pageController: pageController, children: mealPlans);
          },
        ))
      ],
    ));
  }

  Widget _buildMealPlansWithDateOffset(
      BuildContext context, int dateOffset, CanteenState canteenState) {
    final day = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(Duration(days: dateOffset)));

    if (canteenState is CanteensLoaded) {
      final canteens = (canteenState).canteens;
      final canteenIds = canteens
          .where((element) => element.isVisible)
          .map((e) => e.id)
          .toList();
      BlocProvider.of<DailyMealPlansCubit>(context)
          .getMealPlans(canteenIds, day);
    }

    return BlocBuilder<DailyMealPlansCubit, DailyMealPlansState>(
        builder: (context, mealPlanState) {
      if (mealPlanState is DailyMealPlansLoaded &&
          canteenState is CanteensLoaded) {
        final mealPlans = (mealPlanState).mealPlans[day] ?? [];
        final canteenColorMap = {
          for (var v in (canteenState).canteens) v.id: v.color
        };

        return Column(
            children: mealPlans
                .map((e) => MealPlanCard(
                      mealPlan: e,
                      color: canteenColorMap[e.canteenId] ?? Colors.pink,
                    ))
                .toList());
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
