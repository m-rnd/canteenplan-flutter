import 'package:canteenplan/cubit/daily_meal_plans_cubit.dart';
import 'package:canteenplan/view/home/widget/mealplan/meal_plan_card.dart';
import 'package:canteenplan/view/home/widget/top_app_bar/cateen_filter_list.dart';
import 'package:canteenplan/view/home/widget/top_app_bar/day_tab_list.dart';
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

    BlocProvider.of<DailyMealPlansCubit>(context)
        .getMealPlans([63, 64, 65, 66], day);

    return BlocBuilder<DailyMealPlansCubit, DailyMealPlansState>(
      buildWhen: (previous, current) {
        return _widgetRebuildCondition(previous, current, day);
      },
      builder: (context, state) {
        if (state is DailyMealPlansInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final mealPlans =
              (state as DailyMealPlansLoaded).mealPlans[day] ?? [];

          return ListView(
              children:
                  mealPlans.map((e) => MealPlanCard(mealPlan: e)).toList());
        }
      },
    );
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
