import 'dart:async';

import 'package:canteenplan/models/meal_plan.dart';
import 'package:canteenplan/networking/api_service.dart';
import 'package:canteenplan/storage/local_cache_service.dart';
import 'package:flutter/material.dart';

import '../models/cached_meal_plan.dart';

const inMemoryCacheDuration = Duration(minutes: 5);

class MealPlanRepository {
  final ApiService _api;
  final LocalCacheService _persistentCache;

  String _getCacheKey(int canteenId, String date) => "$date $canteenId";
  final Map<String, CachedMealPlan> cache = {};

  MealPlanRepository(this._api, this._persistentCache);

  Future<List<MealPlan>> getMealPlans(List<int> canteenIds, String date) async {
    final futures = canteenIds.map((id) => getMealPlan(id, date));
    return Future.wait(futures);
  }

  Future<MealPlan> getMealPlan(int canteenId, String date) async {
    final cacheKey = _getCacheKey(canteenId, date);
    if (cache.containsKey(cacheKey)) {
      // saved in ram
      final plan = cache[cacheKey]!;
      final elapsedTime =
          DateTimeRange(start: plan.lastModified, end: DateTime.now()).duration;

      if (elapsedTime < inMemoryCacheDuration) {
        return plan.toMealPlan();
      }
    }
    return _getPlanFromApi(canteenId, date);
  }

  Future<MealPlan> _getPlanFromApi(int canteenId, String date) async {
    final cacheKey = _getCacheKey(canteenId, date);
    final rawMealPlan = await _api.getMealPlan(canteenId, date) ?? [];
    final mealPlan = MealPlan.fromJSON(canteenId, rawMealPlan);

    if (mealPlan.meals.isNotEmpty) {
      final cachedPlan =
          CachedMealPlan(canteenId, DateTime.now(), mealPlan.meals);

      cache.update(cacheKey, (value) => cachedPlan, ifAbsent: () => cachedPlan);
      _persistentCache.setMealPlan(canteenId, date, cachedPlan);
      return mealPlan;
    } else {
      return _getPlanFromPersistentCache(canteenId, date);
    }
  }

  Future<MealPlan> _getPlanFromPersistentCache(int canteenId, String date) {
    final cacheKey = _getCacheKey(canteenId, date);
    return _persistentCache.getMealPlan(canteenId, date).then((mealPlan) {
      if (mealPlan != null) {
        cache.update(cacheKey, (value) => mealPlan, ifAbsent: () => mealPlan);
        return mealPlan.toMealPlan();
      }
      return MealPlan(canteenId, []);
    });
  }
}
