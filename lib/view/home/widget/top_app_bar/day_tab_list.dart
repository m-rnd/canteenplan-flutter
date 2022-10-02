import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    initializeDateFormatting("de_DE");
    String dayName;

    switch (offset) {
      case 0:
        dayName = "Heute";
        break;
      case 1:
        dayName = "Morgen";
        break;
      default:
        dayName = DateFormat.EEEE("de_DE")
            .format(DateTime.now().add(Duration(days: offset)));
    }

    return Center(
        child: Text(dayName, style: Theme.of(context).textTheme.titleLarge));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
