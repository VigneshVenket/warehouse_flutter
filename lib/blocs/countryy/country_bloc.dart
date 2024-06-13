import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_event.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';

import '../../repos/countryy_repo.dart';
import 'country_event.dart';
import 'country_state.dart';



class CountryyBloc extends Bloc<CountryyEvent, CountryyState> {
  final CountryyRepo countryyRepo;

  CountryyBloc(this.countryyRepo) : super(CountryyInitial());

  @override
  Stream<CountryyState> mapEventToState(CountryyEvent event) async* {
    if (event is GetCountryy && AppData.user != null) {
      try {
        final countryyResponse = await countryyRepo.getCountryy();
        if (countryyResponse.status == AppConstants.STATUS_SUCCESS &&
            countryyResponse.data != null)
          yield CountryyLoaded(countryyResponse.data!);
        else
          yield CountryyError(countryyResponse.message!);
      } on Error {
        yield CountryyError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
