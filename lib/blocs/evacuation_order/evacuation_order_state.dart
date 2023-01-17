part of 'evacuation_order_cubit.dart';

@immutable
abstract class EvacuationOrderState {}

class EvacuationOrderInitial extends EvacuationOrderState {}

class EvacuationOrderInProgress extends EvacuationOrderState {}

class EvacuationOrderSuccess extends EvacuationOrderState {}

class EvacuationOrderFailure extends EvacuationOrderState {
  final String reason;
  EvacuationOrderFailure({required this.reason});
}
