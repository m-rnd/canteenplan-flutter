import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../router.dart';

class HomeEmptyLayout extends StatelessWidget {
  const HomeEmptyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Hier sieht es ziemlich leer aus!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: 16),
        Text("Füge eine Mensa hinzu, von der du den Speiseplan sehen willst.",
            style: Theme.of(context).textTheme.bodyText1),
        Text("Später kannst du noch weitere Mensen hinzufügen.",
            style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(height: 16),
        OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, ROUTE_ADD_CANTEEN),
            icon: const Icon(Icons.add),
            label: const Text("Mensa hinzufügen"))
      ],
    ));
  }
}
