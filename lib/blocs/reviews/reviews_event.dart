
part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const  ReviewsEvent();
}

class GetReviews extends ReviewsEvent {

  final int? productId;

  const GetReviews(this.productId);

  @override
  List<Object> get props => [productId!];
}

class AddReviews extends ReviewsEvent {

  final int? productId;
  final String?  comment;
  final double? rating;
  final String? title;
  const AddReviews(this.productId, this.comment, this.rating, this.title);

  @override
  List<Object> get props => [productId!, comment!, rating!, title!];
}