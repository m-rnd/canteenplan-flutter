import 'package:canteenplan/networking/api_service.dart';
import 'package:canteenplan/repository/canteen_repository.dart';
import 'package:canteenplan/repository/meal_plan_repository.dart';
import 'package:canteenplan/view/router.dart';
import 'package:flutter/material.dart';

void main() {
  final _api = ApiService();
  runApp(MyApp(
      router: AppRouter(CanteenRepository(_api), MealPlanRepository(_api))));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generateRoute,
    );
  }
}
