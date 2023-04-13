import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'place_review_state.dart';

class PlaceReviewCubit extends Cubit<PlaceReviewState> {
  PlaceReviewCubit() : super(PlaceReviewInitial());

  Future<void> placeReview(
    String review,
    int rating,
  ) async {
    emit(PlaceReviewInProgress());
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var loginToken = localStorage.get('token');
      var response = await http.post(
          Uri.parse(
            'https://Skygulfapp.gulfsky-app.website/api/user/review?rating=$rating&content=$review',
          ),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $loginToken'
          });
      if (response.statusCode == 200) {
        emit(PlaceReviewSuccess());
      }
    } catch (e) {
      emit(PlaceReviewFailure());
    }
  }
}
