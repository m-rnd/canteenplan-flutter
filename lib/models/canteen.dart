import 'dart:convert';

import 'package:flutter/material.dart';

class Canteen {
  final int id;
  final String name;
  final Color color;
  bool isVisible;

  Canteen(this.id, this.name, this.color, this.isVisible);

  Canteen.fromJSON(Map json)
      : id = json["id"] as int,
        name = json["name"],
        color = Color(json["color"]),
        isVisible = json["isVisible"];

  Map toJson() => {
        'id': id,
        'name': name,
        'color': color.value,
        'isVisible': isVisible,
      };
}

extension CanteenIterableConversion on Iterable<Canteen> {
  String toJSON() {
    final canteensMap = {for (var v in this) v.id.toString(): v.toJson()};
    return jsonEncode(canteensMap);
  }
}

extension CanteenMapConversion on Map<String, Canteen> {
  String toJSON() {
    return jsonEncode(map((id, canteen) => MapEntry(id, canteen.toJson())));
  }
}
