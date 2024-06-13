
part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GetPage extends PageEvent {

  final int pageNo;

  const GetPage(this.pageNo);

  @override
  List<Object> get props => [pageNo];
}