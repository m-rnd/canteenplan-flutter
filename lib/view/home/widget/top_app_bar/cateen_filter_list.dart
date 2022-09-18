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
        return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: Wrap(
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
          clipBehavior: Clip.antiAlias,
          height: 48,
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
                style:
                    Theme.of(context).textTheme.button?.apply(color: textColor),
              ))),
      onTap: () {
        onClick();
      },
    );
  }
}
