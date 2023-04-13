import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:loavi_project/blocs/signup/signup_event.dart';
import 'package:loavi_project/blocs/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignUpRequested>(_mapSignUpRequestedToState);
  }

  void _mapSignUpRequestedToState(
      SignUpRequested event, Emitter<SignupState> emit) async {
    emit(SignUpInProgress());
    try {
      var url =
          'https://Skygulfapp.gulfsky-app.website/api/auth/register?email=${event.email}&first_name=${event.firstName}&last_name=${event.lastName}&phone=${event.phoneNumber}&gender=${event.gender}&password=${event.password}&profile_image=\'http://skygulf.zona.ae/images/hero-image.png\'&date_of_birth=${event.birthDate}&room_number=22&building_id=22';
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        emit(SignUpSuccess());
      } else {
        throw ('SignUp failure, Try again');
      }
    } catch (e) {
      emit(SignUpFailure(reason: e.toString()));
    }
  }
}
