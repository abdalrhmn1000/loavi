part of 'get_buildings_cubit.dart';

@immutable
abstract class GetBuildingsState {}

class GetBuildingsInitial extends GetBuildingsState {}

class GetBuildingsInProgress extends GetBuildingsState {}

class GetBuildingsSuccess extends GetBuildingsState {
  final List<Building> buildings;
  GetBuildingsSuccess({required this.buildings});
}

class GetBuildingsFailure extends GetBuildingsState {}
