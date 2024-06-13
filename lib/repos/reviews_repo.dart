import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/add_review_response.dart';
import 'package:flutter_kundol/api/responses/reviews_response.dart';

abstract class ReviewsRepo {
  Future<ReviewsResponse> getReviews(int productId);
  Future<AddReviewResponse> addReview(int productId, String comment, double rating, String title);
}

class RealReviewsRepo implements ReviewsRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ReviewsResponse> getReviews(int productId) {
    return _apiProvider.getReviews(productId);
  }

  @override
  Future<AddReviewResponse> addReview(int productId, String comment, double rating, String? title) {
    return _apiProvider.addReview(productId, comment, rating ,title!);

}}