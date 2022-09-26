import 'package:canteenplan/models/canteen_search_result.dart';
import 'package:canteenplan/networking/api_service.dart';

class CanteenSearchRepository {
  final ApiService _api;

  CanteenSearchRepository(this._api);

  Future<List<CanteenSearchResult>> getCanteenSearchResults() async {
    final rawCanteens = await _api.getCanteens();
    if (rawCanteens == null) return [];
    return (rawCanteens as List<dynamic>)
        .map((e) => CanteenSearchResult.fromJSON(e))
        .toList();
  }
}
