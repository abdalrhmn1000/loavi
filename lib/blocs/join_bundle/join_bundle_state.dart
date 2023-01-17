part of 'join_bundle_cubit.dart';

@immutable
abstract class JoinBundleState {}

class JoinBundleInitial extends JoinBundleState {}

class JoinBundleInProgress extends JoinBundleState {}

class JoinBundleSuccess extends JoinBundleState {
  final String contactId;
  JoinBundleSuccess({required this.contactId});
}

class JoinBundleFailure extends JoinBundleState {
  final String reason;

  JoinBundleFailure({required this.reason});
}
