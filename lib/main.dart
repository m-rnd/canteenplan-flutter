import 'package:canteenplan/networking/api_service.dart';
import 'package:canteenplan/repository/canteen_search_repository.dart';
import 'package:canteenplan/repository/canteen_repository.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:canteenplan/storage/local_cache_service.dart';
import 'package:canteenplan/storage/local_storage_service.dart';
import 'package:canteenplan/view/router.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final _api = ApiService();
  final _localStorage = LocalStorageService();
  final _localCache = LocalCacheService();
  runApp(MediaQuery.fromWindow(
      child: MyApp(
          router: AppRouter(
              CanteenRepository(_localStorage),
              MealPlanRepository(_api, _localCache),
              CanteenSearchRepository(_api)))));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen plan',
      theme: _getTheme(context),
      onGenerateRoute: router.generateRoute,
      navigatorKey: navigatorKey,
    );
  }

  _getTheme(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    final baseTheme = ThemeData(brightness: brightnessValue);
    final backgroundColor = baseTheme.scaffoldBackgroundColor;

    return ThemeData(
        fontFamily: "OpenSans",
        scaffoldBackgroundColor: backgroundColor,
        brightness: brightnessValue,
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
            backgroundColor: backgroundColor,
            foregroundColor: baseTheme.textTheme.bodySmall?.color));
  }
}
