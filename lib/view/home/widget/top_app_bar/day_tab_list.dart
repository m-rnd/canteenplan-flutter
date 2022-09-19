import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayTabList extends StatelessWidget implements PreferredSizeWidget {
  final PageController pageController;
  final int amountOfDays;
  final height = 56.0;

  const DayTabList(
      {Key? key, required this.pageController, required this.amountOfDays})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: PageView.builder(
            controller: pageController,
            itemCount: amountOfDays,
            padEnds: false,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (itemContext, index) {
              return _dayTab(index, context);
            }));
  }

  Widget _dayTab(offset, context) {
    final date =
        DateFormat("EEEE").format(DateTime.now().add(Duration(days: offset)));
    return Center(
        child: Text(date, style: Theme.of(context).textTheme.titleLarge));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
