import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/canteen.dart';
import '../repository/canteen_repository.dart';

part 'canteen_state.dart';

class CanteenCubit extends Cubit<CanteenState> {
  final CanteenRepository _repository;

  CanteenCubit(this._repository) : super(CanteenInitial());

  void getCanteen(int id) {
    _repository
        .getCanteen(id)
        .then((canteen) => {emit(CanteenLoaded(canteen))});
  }
}
