// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:loavi_project/models/bundle.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'bundles_state.dart';

class BundlesCubit extends Cubit<BundlesState> {
  BundlesCubit() : super(BundlesInitial());

  Future<void> getBundles(String lang) async {
    emit(BundlesInProgress());
    try {
      var response =
          await http.get(Uri.parse("https://Skygulfapp.gulfsky-app.website/api/$lang/bundles/"));
      var response2 =
          await http.get(Uri.parse('https://Skygulfapp.gulfsky-app.website/api/bundlePrices'));
      Map<String, dynamic> x = jsonDecode(response.body);
      Map<String, dynamic> y = jsonDecode(response2.body);
      List<Bundle> bundles = [];

      for (int i = 0; i < (x['data'] as List).length; i++) {
        Map<String, dynamic> json1 = (x['data'] as List).elementAt(i);
        for (int j = 0; j < (y['data'] as List).length; j++) {
          Map<String, dynamic> json2 = (y['data'] as List).elementAt(j);

          if (json1['maintenance_package_id'] == json2['id']) {
            bundles.add(Bundle.fromJson(json1, json2));
          }
        }
      }
      if (response.statusCode == 200) {
        emit(BundlesSuccess(bundles: bundles));
      } else {
        throw ('error');
      }
      emit(BundlesSuccess(bundles: bundles));
    } catch (e) {
      emit(BundlesFailure());
    }
  }
}
