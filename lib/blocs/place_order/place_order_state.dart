part of 'place_order_cubit.dart';

@immutable
abstract class PlaceOrderState {}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderInProgress extends PlaceOrderState {}

class PlaceOrderSuccess extends PlaceOrderState {}

class PlaceOrderFailure extends PlaceOrderState {}
