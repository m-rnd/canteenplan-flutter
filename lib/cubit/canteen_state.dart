part of 'canteen_cubit.dart';

@immutable
abstract class CanteenState {}

class CanteenInitial extends CanteenState {}

class CanteenLoaded extends CanteenState {
  final Canteen canteen;

  CanteenLoaded(this.canteen);
}
