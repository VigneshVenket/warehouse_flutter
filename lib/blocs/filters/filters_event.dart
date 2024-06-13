part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();
}

class GetFilters extends FiltersEvent {
  const GetFilters();

  @override
  List<Object> get props => [];
}
