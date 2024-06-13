import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/filters_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/filters_repo.dart';

part 'filters_event.dart';

part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final FiltersRepo? filtersRepo;

  FiltersBloc(this.filtersRepo) : super(const FiltersInitial());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is GetFilters) {
      try {
        final filtersResponse = await filtersRepo!.getFilters();
        if (filtersResponse.status == AppConstants.STATUS_SUCCESS &&
            filtersResponse.data != null) {
          yield FiltersLoaded(filtersResponse);
        } else {
          yield FiltersError(filtersResponse.message!);
        }
      } on Error {
        yield const FiltersError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
