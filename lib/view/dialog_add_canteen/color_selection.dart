import 'package:flutter/material.dart';

import '../../models/canteen_color.dart';

class ColorSelection extends StatelessWidget {
  final CanteenColor selectedColor;
  final Function(CanteenColor) onColorClick;

  const ColorSelection(
      {super.key, required this.selectedColor, required this.onColorClick});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: CanteenColor.values
                .map((e) => ColorCircle(
                    color: e,
                    active: selectedColor == e,
                    onClick: onColorClick))
                .toList()));
  }
}

class ColorCircle extends StatelessWidget {
  final CanteenColor color;
  final bool active;
  final Function(CanteenColor) onClick;

  const ColorCircle(
      {super.key,
      required this.color,
      required this.active,
      required this.onClick});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick(color);
        },
        child: Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color.value,
            shape: BoxShape.circle,
          ),
          child: Visibility(visible: active, child: const Icon(Icons.check)),
        ));
  }
}
