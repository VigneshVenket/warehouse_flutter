import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/reviews_data.dart';
import 'package:flutter_kundol/repos/reviews_repo.dart';

part 'reviews_state.dart';
part 'reviews_event.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewsRepo reviewsRepo;

  ReviewsBloc(this.reviewsRepo) : super(const ReviewsInitial());

  @override
  Stream<ReviewsState> mapEventToState(ReviewsEvent event) async* {
    if (event is GetReviews) {
      try {
        final reviewsResponse = await reviewsRepo.getReviews(event.productId!);
        if (reviewsResponse.status == AppConstants.STATUS_SUCCESS &&
            reviewsResponse.data != null) {
          yield ReviewsLoaded(reviewsResponse.data!);
        } else {
          yield ReviewsError(reviewsResponse.message!);
        }
      } on Error {
        yield const ReviewsError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is AddReviews) {
      print("Entered");
      try {
        print("object");
        final addReviewsResponse = await reviewsRepo.addReview(event.productId!, event.comment!, event.rating!, event.title!);
        if (addReviewsResponse.status == AppConstants.STATUS_SUCCESS) {
          yield ReviewsAdded(addReviewsResponse.message!);
        } else {
          yield ReviewsError(addReviewsResponse.message!);
        }
      } on Error {
        yield const ReviewsError("Couldn't fetch weather. Is the device online?");
      }
      print("Exit");
    }

  }

}
