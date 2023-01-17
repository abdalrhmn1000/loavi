import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  Future<void> placeOrder(
    bool isTenant,
    String name,
    String address,
    String phone,
    String buildingId,
    String roomNumber,
    int serviceId,
    int? subServiceId,
  ) async {
    emit(PlaceOrderInProgress());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var loginToken = localStorage.get('token');
      late Map data;
      if (isTenant) {
        data = {
          "address": "",
          "phone": phone,
          "is_real_estate_tanent": 1,
          "is_draft": 0,
          "building_id": int.parse(buildingId),
          "room_number": int.parse(roomNumber),
          "tax_number": "10",
          "order_details": [
            {"services_id": serviceId, "sub_service_id": subServiceId}
          ]
        };
      } else {
        data = {
          "address": address,
          "phone": phone,
          "is_real_estate_tanent": 0,
          "is_draft": 0,
          "building_id": null,
          "room_number": null,
          "tax_number": "10",
          "order_details": [
            {"services_id": serviceId, "sub_service_id": subServiceId}
          ]
        };
      }
      var response = await http.post(
          Uri.parse(
            'http://skygulf.zona.ae/api/user/orders',
          ),
          body: jsonEncode(data),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $loginToken'
          });
      if (response.statusCode == 200) {
        emit(PlaceOrderSuccess());
      }
    } catch (e) {
      emit(PlaceOrderFailure());
    }
  }
}
