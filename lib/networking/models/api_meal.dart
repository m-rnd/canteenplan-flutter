import '../../models/meal.dart';

class ApiMeal {
  final int id;
  final String name;
  final List<String> notes;
  final double price;
  final String category;

  ApiMeal(this.id, this.name, this.notes, this.price, this.category);

  factory ApiMeal.fromJson(Map<String, dynamic> json) {
    final notes = List<String>.from(json["notes"]);
    return ApiMeal(json["id"], json["name"], notes, json["prices"]["students"],
        json["category"]);
  }
}

extension MealConversion on Iterable<ApiMeal> {
  Meal toMeal() {
    final names = map((e) => e.name).toSet();
    return Meal(
        first.id, names, first.notes.toSet(), first.price, first.category);
  }
}
