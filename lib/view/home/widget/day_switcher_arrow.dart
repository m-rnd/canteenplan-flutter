import 'package:flutter/material.dart';

class DaySwitcherArrow extends StatefulWidget {
  final bool invertNavDirection;
  final Function onClick;
  const DaySwitcherArrow(
      {super.key, this.invertNavDirection = false, required this.onClick});

  @override
  State<DaySwitcherArrow> createState() => _DaySwitcherArrowState();
}

class _DaySwitcherArrowState extends State<DaySwitcherArrow> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    final _height = _screenHeight * 0.5;
    final _paddingVertical = (_screenHeight - _height - 72) / 2;
    EdgeInsets edgeInsets;
    BorderRadius borderRadius;

    if (widget.invertNavDirection) {
      edgeInsets = const EdgeInsets.only(left: 16, right: 4);
      borderRadius = const BorderRadius.only(
          topRight: Radius.circular(12), bottomRight: Radius.circular(12));
    } else {
      edgeInsets = const EdgeInsets.only(right: 16, left: 4);
      borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(12), bottomLeft: Radius.circular(12));
    }

    return Padding(
        padding: EdgeInsets.only(top: _paddingVertical),
        child: InkWell(
          onTap: () => widget.onClick(),
          borderRadius: borderRadius,
          onHover: (hovering) {
            setState(() => isHovering = hovering);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _height,
            curve: Curves.ease,
            padding: edgeInsets,
            decoration: BoxDecoration(
                color: isHovering
                    ? Theme.of(context).dividerColor
                    : Colors.transparent,
                borderRadius: borderRadius),
            child: Icon(
                (widget.invertNavDirection)
                    ? Icons.arrow_back_ios
                    : Icons.arrow_forward_ios,
                color: isHovering
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.transparent),
          ),
        ));
  }
}
