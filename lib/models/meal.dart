class Meal {
  final int id;
  final Set<String> names;
  final Set<String> notes;
  final double price;
  final String category;

  Meal(this.id, this.names, this.notes, this.price, this.category);

  Map toJson() => {
        'id': id,
        'names': names.toList(),
        'notes': notes.toList(),
        'price': price,
        'category': category
      };

  Meal.fromJSON(Map<String, dynamic> json)
      : id = json["id"],
        names = List<String>.from(json["names"]).toSet(),
        notes = List<String>.from(json["notes"]).toSet(),
        price = json["price"],
        category = json["category"];
}
