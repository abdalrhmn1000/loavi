part of 'bundles_cubit.dart';

@immutable
abstract class BundlesState {}

class BundlesInitial extends BundlesState {}

class BundlesInProgress extends BundlesState {}

class BundlesSuccess extends BundlesState {
  final List<Bundle> bundles;
  BundlesSuccess({required this.bundles});
}

class BundlesFailure extends BundlesState {}
