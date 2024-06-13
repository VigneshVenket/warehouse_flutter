part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class GetPageInitial extends PageState {
  const GetPageInitial();

  @override
  List<Object> get props => [];
}

class GetPageLoading extends PageState {
  const GetPageLoading();

  @override
  List<Object> get props => [];
}

class GetPageLoaded extends PageState {
  final GetPageResponse pageResponse;

  const GetPageLoaded(this.pageResponse);

  @override
  List<Object> get props => [pageResponse];
}

class GetPageError extends PageState {
  final String error;

  const GetPageError(this.error);

  @override
  List<Object> get props => [error];
}
