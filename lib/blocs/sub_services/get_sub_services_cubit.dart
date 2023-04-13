import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:loavi_project/models/sub_service.dart';
import 'package:meta/meta.dart';

part 'get_sub_services_state.dart';

class GetSubServicesCubit extends Cubit<GetSubServicesState> {
  GetSubServicesCubit() : super(GetSubServicesInitial());

  Future<void> getSubServices(int serviceId) async {
    emit(GetSubServicesInProgress());
    try {
      var response = await http.get(
          Uri.parse('https://Skygulfapp.gulfsky-app.website/api/services/main/$serviceId'));
      Map<String, dynamic> body = jsonDecode(response.body);

      List<SubService> subServices = [];

      for (int i = 0; i < (body['data']['sub_services'] as List).length; i++) {
        subServices.add(SubService.fromJson(
            (body['data']['sub_services'] as List).elementAt(i)));
      }
      if (response.statusCode == 200) {
        emit(GetSubServicesSuccess(subServices: subServices));
      } else {
        throw ('error');
      }
    } catch (e) {
      emit(GetSubServicesFailure());
    }
  }
}
