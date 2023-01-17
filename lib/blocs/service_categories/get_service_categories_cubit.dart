import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:loavi_project/models/service.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'get_service_categories_state.dart';

class GetServiceCategoriesCubit extends Cubit<GetServiceCategoriesState> {
  GetServiceCategoriesCubit() : super(GetServiceCategoriesInitial());

  Future<void> getServiceCategories(int categoryId) async {
    emit(GetServiceCategoriesInProgress());
    try {
      var response = await http.get(Uri.parse(
          'http://skygulf.zona.ae/api/categories/services/$categoryId'));
      Map<String, dynamic> body = jsonDecode(response.body);
      List<CategoryService> services = [];

      for (int i = 0; i < (body['data'] as List).length; i++) {
        services
            .add(CategoryService.fromJson((body['data'] as List).elementAt(i)));

        if (response.statusCode == 200) {
          emit(GetServiceCategoriesSuccess(services: services));
        } else {
          throw ('error');
        }
      }
    } catch (e) {
      emit(GetServiceCategoriesFailure());
    }
  }
}
