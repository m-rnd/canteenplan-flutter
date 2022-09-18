part of 'canteen_cubit.dart';

@immutable
abstract class CanteenState {}

class CanteenInitial extends CanteenState {}

class CanteensLoaded extends CanteenState {
  final List<Canteen> canteens;

  CanteensLoaded(this.canteens);
}
