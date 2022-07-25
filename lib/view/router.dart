import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:canteenplan/repository/canteen_repository.dart';
import 'package:canteenplan/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const ROUTE_MAIN = "/";

class AppRouter {
  final CanteenRepository _canteenRepository;

  AppRouter(this._canteenRepository);

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_MAIN:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CanteenCubit(_canteenRepository),
                  child: const HomePage(),
                ));
      default:
        return null;
    }
  }
}
