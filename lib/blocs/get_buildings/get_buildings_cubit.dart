// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:loavi_project/models/building_dart.dart';

part 'get_buildings_state.dart';

class GetBuildingsCubit extends Cubit<GetBuildingsState> {
  GetBuildingsCubit() : super(GetBuildingsInitial());
  Future<void> getBuildings(String lang) async {
    emit(GetBuildingsInProgress());
    try {
      var response =
          await http.get(Uri.parse("http://skygulf.zona.ae/api/$lang/building/"));
      Map<String, dynamic> body = jsonDecode(response.body);
      List<Building> buildings = [];

      for (int i = 0; i < (body['data'] as List).length; i++) {
        buildings.add(Building.fromJson((body['data'] as List).elementAt(i)));
      }

      if (response.statusCode == 200) {
        emit(GetBuildingsSuccess(buildings: buildings));
      } else {
        throw ('error');
      }
    } catch (e) {
      emit(GetBuildingsFailure());
    }
  }
}
