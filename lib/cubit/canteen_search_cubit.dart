import 'package:bloc/bloc.dart';
import 'package:canteenplan/models/canteen_search_result.dart';
import 'package:canteenplan/repository/canteen_search_repository.dart';
import 'package:meta/meta.dart';

import '../models/canteen.dart';

part 'canteen_search_state.dart';

class CanteenSearchCubit extends Cubit<CanteenSearchState> {
  final CanteenSearchRepository _repository;

  CanteenSearchCubit(this._repository) : super(CanteenSearchInitial());

  void getCanteens() {
    _repository
        .getCanteenSearchResults()
        .then((value) => emit(CanteenSearchResultsLoaded(value)));
  }

  void addNewCanteen(Canteen c) {
    print(c);
  }
}
