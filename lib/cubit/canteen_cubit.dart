import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/canteen.dart';
import '../repository/canteen_repository.dart';

part 'canteen_state.dart';

class CanteenCubit extends Cubit<CanteenState> {
  final CanteenRepository _repository;

  CanteenCubit(this._repository) : super(CanteenInitial()) {
    _repository.getCanteenStream().listen((canteens) {
      emit(CanteensLoaded(canteens));
    });
  }

  void getCanteens() {
    _repository
        .getCanteens()
        .then((canteens) => {emit(CanteensLoaded(canteens))});
  }

  void toggleCanteenVisibility(Canteen canteen) {
    _repository.toggleCanteenVisibility(canteen);
  }
}
