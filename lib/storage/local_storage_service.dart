import 'dart:async';
import 'dart:convert';

import 'package:canteenplan/models/canteen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StreamController<List<Canteen>> canteenController =
      StreamController<List<Canteen>>.broadcast();

  LocalStorageService() {
    getCanteens().then((value) => canteenController.add(value));
  }

  static const String CANTEEN_KEY = "canteens";

  Future<Map<String, Canteen>> _getCanteensAsMap() async {
    return _prefs.then((prefs) {
      final Map<String, dynamic> canteensJSON =
          jsonDecode(prefs.getString(CANTEEN_KEY) ?? "{}");

      return canteensJSON
          .map((id, canteen) => MapEntry(id, Canteen.fromJSON(canteen)));
    });
  }

  Stream<List<Canteen>> getCanteenStream() {
    return canteenController.stream;
  }

  Future<List<Canteen>> getCanteens() async {
    return _prefs.then((prefs) {
      final Map<String, dynamic> canteensJSON =
          jsonDecode(prefs.getString(CANTEEN_KEY) ?? "{}");

      return canteensJSON.values
          .map((canteen) => Canteen.fromJSON(canteen))
          .toList();
    });
  }

  void addCanteen(Canteen canteen) async {
    _prefs.then((prefs) async {
      final canteens = await getCanteens();

      canteens.add(canteen);

      prefs.setString(CANTEEN_KEY, canteens.toJSON());

      canteenController.add(await getCanteens());
    });
  }

  void toggleCanteenVisibility(Canteen canteen) async {
    _prefs.then((prefs) async {
      final canteens = await _getCanteensAsMap();

      final canteenInList = canteens[canteen.id.toString()];
      canteenInList?.isVisible = !canteenInList.isVisible;

      prefs.setString(CANTEEN_KEY, canteens.toJSON());
      canteenController.add(await getCanteens());
    });
  }
}
