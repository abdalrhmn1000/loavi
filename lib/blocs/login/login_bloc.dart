import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:loavi_project/blocs/login/login_event.dart';
import 'package:loavi_project/blocs/login/login_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_mapLoginRequestedToState);
    on<LogoutRequested>(_mapLogoutRequestedToState);
  }

  void _mapLoginRequestedToState(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    try {
      var url =
          'http://skygulf.zona.ae/api/auth/login?email=${event.email}&password=${event.password}';
      var response = await http.post(Uri.parse(url));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await localStorage.clear();
        localStorage.setString('token', body['data']['token']);
        print(localStorage.get('token'));
        emit(LoginSuccess());
      } else {
        throw ('Login Failure, Try again');
      }
    } catch (e) {
      print(e);
      emit(LoginFailure(reason: e.toString()));
    }
  }

  void _mapLogoutRequestedToState(
          LogoutRequested event, Emitter<LoginState> emit) =>
      emit(LoginInitial());
}
