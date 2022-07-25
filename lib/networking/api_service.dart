import 'dart:convert';

import 'package:http/http.dart';

class ApiService {
  final baseUrl = "https://openmensa.org/api/v2/";

  dynamic _rawApiCall(String endpoint) async {
    try {
      final response = await get(Uri.parse(baseUrl + endpoint));
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  dynamic getCanteen(int id) async {
    return _rawApiCall("canteens/$id");
  }

  dynamic getMealPlan(int canteenId, String date) async {
    return _rawApiCall("canteens/$canteenId/days/$date/meals");
  }
}
