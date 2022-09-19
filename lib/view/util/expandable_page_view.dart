import 'dart:math';

import 'package:canteenplan/view/util/size_reporting_widget.dart';
import 'package:flutter/material.dart';

// solution from https://stackoverflow.com/questions/54522980/flutter-adjust-height-of-pageview-horizontal-listview-based-on-current-child

class ExpandablePageView extends StatefulWidget {
  final List<Widget> children;
  final PageController pageController;

  const ExpandablePageView({
    Key? key,
    required this.children,
    required this.pageController,
  }) : super(key: key);

  @override
  _ExpandablePageViewState createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  late List<double> _heights;
  int _currentPage = 0;
  final topAppBarHeight = 56 * 2;

  double get _currentHeight => max(
      MediaQuery.of(context).size.height - topAppBarHeight,
      _heights.reduce((current, next) => current > next ? current : next));

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    widget.pageController.addListener(() {
      final _newPage = widget.pageController.page?.round();
      if (_newPage != null && _currentPage != _newPage) {
        setState(() => _currentPage = _newPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        padEnds: false,
        controller: widget.pageController,
        children: _sizeReportingChildren
            .asMap() //
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            //needed, so that parent won't impose its constraints on the children, thus skewing the measurement results.
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) =>
                  setState(() => _heights[index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}
