import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:canteenplan/cubit/daily_meal_plans_cubit.dart';
import 'package:canteenplan/view/home/widget/mealplan/meal_plan_card.dart';
import 'package:canteenplan/view/home/widget/top_app_bar/cateen_filter_list.dart';
import 'package:canteenplan/view/home/widget/top_app_bar/day_tab_list.dart';
import 'package:canteenplan/view/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(body: LayoutBuilder(
      builder: (context, constrains) {
        final amountChildren = constrains.maxWidth ~/ 300;

        pageController = PageController(viewportFraction: 1 / amountChildren);
        tabController = PageController(viewportFraction: 1 / amountChildren);

        pageController.addListener(() {
          tabController.jumpTo(pageController.offset);
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
              title: CanteenList(),
              centerTitle: true,
              bottom: DayTabList(
                  pageController: tabController, amountOfDays: amountOfDays),
            ),
            SliverToBoxAdapter(
                child: Container(
              height: 2000.0,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: amountOfDays,
                  padEnds: false,
                  itemBuilder: (context, index) {
                    return _buildMealPlansWithDateOffset(context, index);
                  }),
            ))
          ],
        );
      },
    ));
  }

  Widget _buildMealPlansWithDateOffset(BuildContext context, int dateOffset) {
    final day = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(Duration(days: dateOffset)));

    return BlocBuilder<CanteenCubit, CanteenState>(
        builder: (context, canteenState) {
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
          buildWhen: (previous, current) {
        return _widgetRebuildCondition(previous, current, day);
      }, builder: (context, mealPlanState) {
        if (mealPlanState is DailyMealPlansLoaded &&
            canteenState is CanteensLoaded) {
          final mealPlans = (mealPlanState).mealPlans[day] ?? [];
          final canteenColorMap = {
            for (var v in (canteenState).canteens) v.id: v.color
          };

          return ListView(
              children: mealPlans
                  .map((e) => MealPlanCard(
                        mealPlan: e,
                        color: canteenColorMap[e.canteenId] ?? Colors.pink,
                      ))
                  .toList());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });
    });
  }

  bool _widgetRebuildCondition(
      DailyMealPlansState previous, DailyMealPlansState current, String day) {
    if (previous is DailyMealPlansInitial || current is DailyMealPlansInitial) {
      return true;
    } else if (previous is DailyMealPlansLoaded &&
        current is DailyMealPlansLoaded) {
      // print(
      //     "${previous.mealPlans[day].hashCode}, current: ${previous.mealPlans[day].hashCode}");
      // return previous.mealPlans[day].hashCode !=
      //     current.mealPlans[day].hashCode;
      return true;
    } else {
      return true;
    }
  }
}
