import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loavi_project/blocs/place_review/place_review_cubit.dart';
import 'package:loavi_project/frontend/app_theme.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String review = '';
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => PlaceReviewCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'review'.tr(),
                      style: AppTheme.interBold.copyWith(
                          fontSize: 32, color: const Color(0xFF1A1D1F)),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * (50 / 812),
                  ),
                  RatingBar(
                    initialRating: 3,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    glow: false,
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      empty: const Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                      half: Container(),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value.toInt();
                      });
                    },
                  ),
                  SizedBox(
                    height: screenHeight * (50 / 812),
                  ),
                  Container(
                    height: screenHeight * (300 / 812),
                    padding: EdgeInsets.only(left: screenWidth * (16 / 375)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFCA3939))),
                    child: TextField(
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          review = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'write_your_review'.tr(),
                          hintStyle: AppTheme.interMedium
                              .copyWith(color: const Color(0xFF1A1B2D))),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * (20 / 812),
                  ),
                  BlocConsumer<PlaceReviewCubit, PlaceReviewState>(
                    listener: (context, state) {
                      if (state is PlaceReviewSuccess) {
                        Navigator.pop(context);
                        AppTheme.showSnackBar(context, 'success'.tr());
                      }
                      if (state is PlaceReviewFailure) {
                        AppTheme.showSnackBar(
                            context, 'failure_try_again'.tr());
                      }
                    },
                    builder: (context, state) {
                      if (state is PlaceReviewInProgress) {
                        return Container(
                          width: screenWidth,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * (20 / 812)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppTheme.accent7),
                          child:
                              const Center(child: CupertinoActivityIndicator()),
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<PlaceReviewCubit>(context)
                              .placeReview(review, rating);
                        },
                        child: Container(
                          width: screenWidth,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * (20 / 812)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppTheme.accent7),
                          child: Center(
                              child: Text(
                            'submit'.tr(),
                            style: AppTheme.interRegular
                                .copyWith(color: const Color(0xFFFFFFFF)),
                          )),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
