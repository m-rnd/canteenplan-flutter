import 'package:canteenplan/cubit/canteen_cubit.dart';
import 'package:canteenplan/view/home/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeLayout();
  }
}
