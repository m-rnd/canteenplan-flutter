import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/canteen.dart';

var myColor = {
  "low": Colors.green,
  "medium": Colors.amberAccent,
  "high": Colors.red
};

class CanteenList extends StatelessWidget {
  const CanteenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CanteenCubit>(context).getCanteens();

    return BlocBuilder<CanteenCubit, CanteenState>(builder: (context, state) {
      if (state is CanteensLoaded) {
        final canteens = (state).canteens;
        return SizedBox(
            height: 48,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: canteens
                    .map((e) => _canteenButton(
                        e.name,
                        e.color,
                        e.isVisible,
                        context,
                        () => BlocProvider.of<CanteenCubit>(context)
                            .toggleCanteenVisibility(e)))
                    .toList()));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget _canteenButton(String name, Color color, bool isActive,
      BuildContext context, Function onClick) {
    final textColor =
        isActive ? color : Theme.of(context).unselectedWidgetColor;
    final boxColor = isActive ? color.withAlpha(30) : Colors.transparent;
    return InkWell(
      child: Container(
          height: 48,
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: boxColor,
              border: Border.all(
                  width: 1,
                  strokeAlign: StrokeAlign.inside,
                  color: Theme.of(context).dividerColor)),
          child: Center(
              widthFactor: 1,
              child: Text(
                name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.button?.apply(color: textColor),
              ))),
      onTap: () {
        onClick();
      },
    );
  }
}
