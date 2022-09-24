import 'dart:math';

import 'package:canteenplan/view/home/widget/mealplan/meal_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/canteen_cubit.dart';
import '../../cubit/daily_meal_plans_cubit.dart';
import '../../models/meal_plan.dart';
import '../router.dart';
import '../util/expandable_page_view.dart';
import 'widget/top_app_bar/cateen_filter_list.dart';
import 'widget/top_app_bar/day_tab_list.dart';

class HomeDefaultLayout extends StatelessWidget {
  final CanteenState canteenState;
  final int amountOfDays;

  const HomeDefaultLayout(
      {super.key, required this.canteenState, required this.amountOfDays});

  @override
  Widget build(BuildContext context) {
    final amountChildren =
        min(MediaQuery.of(context).size.width ~/ 400, amountOfDays);

    final pageController = PageController(viewportFraction: 1 / amountChildren);
    final tabController = PageController(viewportFraction: 1 / amountChildren);

    pageController.addListener(() {
      if (tabController.positions.isNotEmpty) {
        tabController.jumpTo(pageController.offset);
      }
    });
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, ROUTE_ADD_CANTEEN);
              },
              splashRadius: 24,
            )
          ],
          title: CanteenList(canteenState: canteenState),
          centerTitle: true,
          bottom: DayTabList(
              pageController: tabController, amountOfDays: amountOfDays),
        ),
        SliverToBoxAdapter(
            child: _buildMealPager(context, pageController, canteenState))
      ],
    );
  }

  Widget _buildMealPager(BuildContext context, PageController pageController,
      CanteenState canteenState) {
    if (canteenState is CanteensLoaded) {
      final canteens = (canteenState).canteens;
      final canteenIds = canteens
          .where((element) => element.isVisible)
          .map((e) => e.id)
          .toList();

      BlocProvider.of<DailyMealPlansCubit>(context)
          .getMealPlans(canteenIds, amountOfDays);

      return BlocBuilder<DailyMealPlansCubit, DailyMealPlansState>(
          builder: (context, mealPlanState) {
        if (mealPlanState is DailyMealPlansLoaded) {
          final mealPlans = (mealPlanState).mealPlans;
          final canteenColorMap = {
            for (var v in (canteenState).canteens) v.id: v.color
          };

          return ExpandablePageView(
              pageController: pageController,
              children: List.generate(
                  amountOfDays,
                  (i) => _buildMealPlansForSingleDay(
                      context, mealPlans[i], canteenColorMap)));
        } else {
          return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()));
        }
      });
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildMealPlansForSingleDay(BuildContext context,
      List<MealPlan> mealPlans, Map<int, Color> canteenColorMap) {
    return Column(
        children: mealPlans
            .map((e) => MealPlanCard(
                  mealPlan: e,
                  color: canteenColorMap[e.canteenId] ?? Colors.pink,
                ))
            .toList());
  }
}
