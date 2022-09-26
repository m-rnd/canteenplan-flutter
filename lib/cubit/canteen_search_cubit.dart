import 'package:bloc/bloc.dart';
import 'package:canteenplan/models/canteen_search_result.dart';
import 'package:canteenplan/repository/canteen_repository.dart';
import 'package:canteenplan/repository/canteen_search_repository.dart';
import 'package:meta/meta.dart';

import '../models/canteen.dart';

part 'canteen_search_state.dart';

class CanteenSearchCubit extends Cubit<CanteenSearchState> {
  final CanteenSearchRepository _searchRepository;
  final CanteenRepository _repository;

  CanteenSearchCubit(this._repository, this._searchRepository)
      : super(CanteenSearchInitial());

  void getCanteens() {
    _searchRepository.getCanteenSearchResults().then((value) {
      if (value.isEmpty) {
        emit(CanteenSearchError());
      } else {
        emit(CanteenSearchResultsLoaded(value));
      }
    });
  }

  void addNewCanteen(Canteen c) {
    _repository.addCanteen(c);
  }
}
