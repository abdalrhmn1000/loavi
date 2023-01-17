part of 'get_sub_services_cubit.dart';

@immutable
abstract class GetSubServicesState {}

class GetSubServicesInitial extends GetSubServicesState {}

class GetSubServicesInProgress extends GetSubServicesState {}

class GetSubServicesSuccess extends GetSubServicesState {
  final List<SubService> subServices;
  GetSubServicesSuccess({required this.subServices});
}

class GetSubServicesFailure extends GetSubServicesState {}
