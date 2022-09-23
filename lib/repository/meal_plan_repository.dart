import 'dart:async';

import 'package:canteenplan/models/meal_plan.dart';
import 'package:canteenplan/networking/api_service.dart';
import 'package:flutter/material.dart';

import '../models/cached_meal_plan.dart';

const inMemoryCacheDuration = Duration(minutes: 5);

class MealPlanRepository {
  final ApiService _api;

  String _getCacheKey(int canteenId, String date) => "$date $canteenId";
  final Map<String, CachedMealPlan> cache = {};

  MealPlanRepository(this._api);

  Future<List<MealPlan>> getMealPlans(List<int> canteenIds, String date) async {
    final futures = canteenIds.map((id) => getMealPlan(id, date));
    return Future.wait(futures);
  }

  Future<MealPlan> getMealPlan(int canteenId, String date) async {
    final cacheKey = _getCacheKey(canteenId, date);

    print(cache.containsKey(cacheKey));
    if (cache.containsKey(cacheKey)) {
      // saved in ram
      final plan = cache[cacheKey]!;
      final elapsedTime =
          DateTimeRange(start: plan.lastModified, end: DateTime.now()).duration;

      if (elapsedTime < inMemoryCacheDuration) {
        print("loaded meal plan $cacheKey from inMemory cache");
        return plan.toMealPlan();
      }
    }
    return _getPlanFromApi(canteenId, date);
  }

  Future<MealPlan> _getPlanFromApi(int canteenId, String date) async {
    final cacheKey = _getCacheKey(canteenId, date);
    final rawMealPlan = await _api.getMealPlan(canteenId, date) ?? [];
    final mealPlan = MealPlan.fromJSON(canteenId, rawMealPlan);
    final cachedPlan =
        CachedMealPlan(canteenId, DateTime.now(), mealPlan.meals);

    cache.update(cacheKey, (value) => cachedPlan, ifAbsent: () => cachedPlan);
    return mealPlan;
  }
}
