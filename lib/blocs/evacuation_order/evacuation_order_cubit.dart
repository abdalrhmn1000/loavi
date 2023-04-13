// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'evacuation_order_state.dart';

class EvacuationOrderCubit extends Cubit<EvacuationOrderState> {
  EvacuationOrderCubit() : super(EvacuationOrderInitial());

  Future<void> placeEvacuationOrder(DateTime evacDate, int buildingId,
      String roomNumber, String reason, bool isEmpty, int tenancyYears) async {
    emit(EvacuationOrderInProgress());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var loginToken = localStorage.get('token');
      var response = await http.post(
          Uri.parse(
            'https://Skygulfapp.gulfsky-app.website//api/user/evacuation_orders?is_real_estate_tanent=1&address=\'\'&started_at=$evacDate&building_id=$buildingId&room_number=$roomNumber&is_the_flat_empty=${(isEmpty) ? 1 : 0}&number_of_lease_years=$tenancyYears&reason=$reason',
          ),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $loginToken'
          });
      var body = jsonDecode(response.body);
      if (body['success'] == true) {
        emit(EvacuationOrderSuccess());
      }
    } catch (e) {
      emit(EvacuationOrderFailure(reason: e.toString()));
    }
  }
}
