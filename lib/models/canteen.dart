import 'package:flutter/material.dart';

import 'canteen_color.dart';

class Canteen {
  final int id;
  final String name;
  final CanteenColor color;

  Canteen(this.id, this.name, this.color);

  Canteen.fromJSON(Map json)
      : id = json["id"] as int,
        name = json["name"],
        color = CanteenColor.pink;
}
