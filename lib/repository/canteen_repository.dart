import 'package:canteenplan/models/canteen.dart';
import 'package:canteenplan/networking/api_service.dart';

class CanteenRepository {
  final ApiService _api;

  CanteenRepository(this._api);

  Future<Canteen> getCanteen(int id) async {
    final rawCanteen = await _api.getCanteen(id);
    return Canteen.fromJSON(rawCanteen);
  }
}
