part of 'get_service_categories_cubit.dart';

@immutable
abstract class GetServiceCategoriesState {}

class GetServiceCategoriesInitial extends GetServiceCategoriesState {}

class GetServiceCategoriesInProgress extends GetServiceCategoriesState {}

class GetServiceCategoriesSuccess extends GetServiceCategoriesState {
  final List<CategoryService> services;
  GetServiceCategoriesSuccess({required this.services});
}

class GetServiceCategoriesFailure extends GetServiceCategoriesState {}
