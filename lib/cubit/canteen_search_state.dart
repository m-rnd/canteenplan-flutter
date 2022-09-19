part of 'canteen_search_cubit.dart';

@immutable
abstract class CanteenSearchState {}

class CanteenSearchInitial extends CanteenSearchState {}

class CanteenSearchError extends CanteenSearchState {}

class CanteenSearchResultsLoaded extends CanteenSearchState {
  final List<CanteenSearchResult> canteens;

  CanteenSearchResultsLoaded(this.canteens);
}
