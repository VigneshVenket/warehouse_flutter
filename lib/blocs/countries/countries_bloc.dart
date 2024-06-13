// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/countries_response.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
// import '../../repos/countries_repo.dart';
// import 'countries_event.dart';
//
//
// part 'countries_state.dart';
//
// class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
//   final CountriesRepo countriesRepo;
//
//   CountriesBloc(this.countriesRepo) : super(const CountriesInitial());
//
//   @override
//   Stream<CountriesState> mapEventToState(
//       CountriesEvent event,
//       ) async* {
//     if (event is GetCountries) {
//       try {
//         yield const CountriesLoading();
//         final bannersResponse = await countriesRepo.fetchCountries();
//         if (bannersResponse.status == AppConstants.STATUS_SUCCESS &&
//             bannersResponse.data != null) {
//           yield CountriesLoaded(bannersResponse);
//         } else {
//           yield CountriesError(bannersResponse.message!);
//         }
//       } on Error {
//         yield const CountriesError("Couldn't fetch weather. Is the device online?");
//       }
//     }
//   }
// }
