import 'dart:convert';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'join_bundle_state.dart';

class JoinBundleCubit extends Cubit<JoinBundleState> {
  JoinBundleCubit() : super(JoinBundleInitial());

  Future<void> joinBundle(int bundleId) async {
    emit(JoinBundleInProgress());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var loginToken = localStorage.get('token');
      var response = await http.post(
          Uri.parse(
            'https://Skygulfapp.gulfsky-app.website/api/user/createContract?bundle_id=$bundleId&location=Dubai',
          ),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $loginToken'
          });
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(JoinBundleSuccess(contactId: body['data']['id'].toString()));
      } else {
        throw (body['message']);
      }
    } catch (e) {
      emit(JoinBundleFailure(reason: e.toString()));
    }
  }
}
