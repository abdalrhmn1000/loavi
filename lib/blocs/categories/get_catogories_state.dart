part of 'get_catogories_cubit.dart';

@immutable
abstract class GetCatogoriesState {}

class GetCatogoriesInitial extends GetCatogoriesState {}

class GetCatogoriesInProgress extends GetCatogoriesState {}

class GetCatogoriesSuccess extends GetCatogoriesState {
  final List<Category> categories;

  GetCatogoriesSuccess({required this.categories});
}

class GetCatogoriesFailure extends GetCatogoriesState {}
