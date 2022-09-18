import 'package:canteenplan/models/canteen.dart';
import 'package:canteenplan/storage/local_storage_service.dart';

class CanteenRepository {
  final LocalStorageService _localStorage;

  CanteenRepository(this._localStorage);

  Future<List<Canteen>> getCanteens() async {
    return _localStorage.getCanteens();
  }

  Stream<List<Canteen>> getCanteenStream() => _localStorage.getCanteenStream();

  void addCanteen(Canteen canteen) async {
    _localStorage.addCanteen(canteen);
  }

  Future<void> toggleCanteenVisibility(Canteen canteen) async {
    return _localStorage.toggleCanteenVisibility(canteen);
  }
}
