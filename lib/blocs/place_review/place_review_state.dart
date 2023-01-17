part of 'place_review_cubit.dart';

@immutable
abstract class PlaceReviewState {}

class PlaceReviewInitial extends PlaceReviewState {}

class PlaceReviewInProgress extends PlaceReviewState {}

class PlaceReviewSuccess extends PlaceReviewState {}

class PlaceReviewFailure extends PlaceReviewState {}
