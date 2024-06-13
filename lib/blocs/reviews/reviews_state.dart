part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();

  @override
  List<Object> get props => [];
}

class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();

  @override
  List<Object> get props => [];
}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewsData> reviewsData;

  const ReviewsLoaded(this.reviewsData);

  @override
  List<Object> get props => [reviewsData];
}

class ReviewsError extends ReviewsState {
  final String error;

  const ReviewsError(this.error);

  @override
  List<Object> get props => [error];
}

class ReviewsAdded extends ReviewsState {
  final String message;

  const ReviewsAdded(this.message);

  @override
  List<Object> get props => [message];
}
