import 'dart:convert';

import 'package:canteenplan/models/cached_meal_plan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const preferenceCacheDuration = Duration(days: 1);

class LocalCacheService {
  static const String CACHE_SUPERVISOR_KEY = "mealPlan_supervisor";

  late final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LocalCacheService() {
    _cleanOldCacheEntries();
  }

  String _getCacheKey(int canteenId, String date) =>
      "mealPlan_${date}_$canteenId";

  Future<CachedMealPlan?> getMealPlan(int canteenId, String date) async {
    return _prefs.then((prefs) {
      final mealPlanString = prefs.getString(_getCacheKey(canteenId, date));
      if (mealPlanString != null) {
        final Map<String, dynamic> mealPlanJson = jsonDecode(mealPlanString);

        final mealPlan = CachedMealPlan.fromJSON(mealPlanJson);
        return mealPlan;
      }
      return null;
    });
  }

  setMealPlan(int canteenId, String date, CachedMealPlan mealPlan) {
    if (mealPlan.meals.isEmpty) return;
    _prefs.then((prefs) {
      final key = _getCacheKey(canteenId, date);
      prefs.setString(key, jsonEncode(mealPlan.toJson()));
      _addKeyToCacheSupervisor(key, mealPlan.lastModified);
    });
  }

  _deleteMealPlan(String cacheKey) {
    _prefs.then((prefs) {
      prefs.remove(cacheKey);
    });
  }

  Future<Map<String, int>> _getCacheSupervisor() {
    return _prefs.then((prefs) {
      final supervisorJson = prefs.getString(CACHE_SUPERVISOR_KEY);
      if (supervisorJson == null) return {};

      return (jsonDecode(supervisorJson) as Map<String, dynamic>)
          .map<String, int>((key, value) => MapEntry(key, value as int));
    });
  }

  _saveCacheSupervisor(Map<String, int> cacheSupervisor) {
    return _prefs.then((prefs) {
      prefs.setString(CACHE_SUPERVISOR_KEY, jsonEncode(cacheSupervisor));
    });
  }

  _addKeyToCacheSupervisor(String key, DateTime date) async {
    final cacheSupervisor = await _getCacheSupervisor();

    cacheSupervisor.update(key, (value) => date.millisecondsSinceEpoch,
        ifAbsent: () => date.millisecondsSinceEpoch);

    _saveCacheSupervisor(cacheSupervisor);
  }

  _cleanOldCacheEntries() async {
    final cacheSupervisor = await _getCacheSupervisor();

    cacheSupervisor.forEach((key, value) {});

    cacheSupervisor.removeWhere((key, value) {
      final elapsedTime = DateTimeRange(
              start: DateTime.fromMillisecondsSinceEpoch(value),
              end: DateTime.now())
          .duration;

      if (elapsedTime >= preferenceCacheDuration) {
        _deleteMealPlan(key);
        return true;
      }
      return false;
    });

    _saveCacheSupervisor(cacheSupervisor);
  }
}
