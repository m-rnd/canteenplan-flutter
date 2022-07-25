import 'dart:ui';

import 'package:flutter/material.dart';

import 'meal.dart';

class Canteen {
  final int id;
  final String name;
  final Color color;

  Canteen(this.id, this.name, this.color);

  Canteen.fromJSON(Map json)
      : id = json["id"] as int,
        name = json["name"],
        color = Colors.white;
}
