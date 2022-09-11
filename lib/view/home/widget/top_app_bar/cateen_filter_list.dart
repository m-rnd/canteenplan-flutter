import 'package:flutter/material.dart';

class CanteenList extends StatelessWidget {
  const CanteenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(width: 200, height: 56, child: ColoredBox(color: Colors.red)),
      SizedBox(width: 200, height: 56, child: ColoredBox(color: Colors.orange))
    ]);
  }
}
