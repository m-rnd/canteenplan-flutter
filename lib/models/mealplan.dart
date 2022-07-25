import 'package:canteenplan/models/canteen.dart';

import 'meal.dart';

class Mealplan {
  final DateTime day;
  final Canteen canteen;
  final List<Meal> meals;

  Mealplan(this.day, this.canteen, this.meals);
}
