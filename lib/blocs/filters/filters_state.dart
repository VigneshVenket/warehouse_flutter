part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();
}

class FiltersInitial extends FiltersState {
  const FiltersInitial();

  @override
  List<Object> get props => [];
}

class FiltersLoading extends FiltersState {
  const FiltersLoading();

  @override
  List<Object> get props => [];
}

class FiltersLoaded extends FiltersState {
  final FiltersResponse? filtersResponse;

  const FiltersLoaded(this.filtersResponse);

  @override
  List<Object> get props => [filtersResponse!];
}

class FiltersError extends FiltersState {
  final String error;

  const FiltersError(this.error);

  @override
  List<Object> get props => [error];
}
