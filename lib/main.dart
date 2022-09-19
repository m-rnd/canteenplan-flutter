import 'package:canteenplan/networking/api_service.dart';
import 'package:canteenplan/repository/canteen_search_repository.dart';
import 'package:canteenplan/repository/canteen_repository.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:canteenplan/storage/local_storage_service.dart';
import 'package:canteenplan/view/router.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  final _api = ApiService();
  final _localStorage = LocalStorageService();
  runApp(MediaQuery.fromWindow(
      child: MyApp(
          router: AppRouter(CanteenRepository(_localStorage),
              MealPlanRepository(_api), CanteenSearchRepository(_api)))));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        scaffoldBackgroundColor: backgroundColor,
        brightness: brightnessValue,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
            backgroundColor: backgroundColor,
            foregroundColor: baseTheme.textTheme.bodySmall?.color));
  }
}
