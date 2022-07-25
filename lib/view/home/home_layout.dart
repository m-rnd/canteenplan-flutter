import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/canteen_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CanteenCubit>(context).getCanteen(1);
    return BlocBuilder<CanteenCubit, CanteenState>(
      builder: (context, state) {
        if (state is CanteenInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final canteen = (state as CanteenLoaded).canteen;
          return Text(canteen.name);
        }
      },
    );
  }
}
