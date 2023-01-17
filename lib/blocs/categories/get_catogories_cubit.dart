import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:loavi_project/models/category.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'get_catogories_state.dart';

class GetCatogoriesCubit extends Cubit<GetCatogoriesState> {
  GetCatogoriesCubit() : super(GetCatogoriesInitial());

  Future<void> getCategories(String lang) async {
    emit(GetCatogoriesInProgress());

    try {
      var response =
          await http.get(Uri.parse("http://skygulf.zona.ae/api/$lang/categories/"));
      Map<String, dynamic> x = jsonDecode(response.body);

      List<Category> categories = [];

      for (int i = 0; i < (x['data'] as List).length; i++) {
        categories.add(Category.fromJson((x['data'] as List).elementAt(i)));
      }
      if (response.statusCode == 200) {
        emit(GetCatogoriesSuccess(categories: categories));
      } else {
        throw ('error');
      }
    } catch (e) {
      emit(GetCatogoriesFailure());
    }
  }
}
