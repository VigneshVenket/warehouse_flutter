import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_event.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';

import '../../repos/cityy_repo.dart';
import '../../repos/countryy_repo.dart';
import 'city_event.dart';
import 'city_state.dart';




class CityyBloc extends Bloc<CityyEvent, CityyState> {
  final CityyRepo cityyRepo;

  CityyBloc(this.cityyRepo) : super(CityyInitial());

  @override
  Stream<CityyState> mapEventToState(CityyEvent event) async* {
    if (event is GetCityy && AppData.user != null) {
      try {
        final cityyResponse = await cityyRepo.getCityy(event.countryvalue);
        if (cityyResponse.status == AppConstants.STATUS_SUCCESS &&
            cityyResponse.data != null)
          yield CityyLoaded(cityyResponse.data!);
        else
          yield CityyError(cityyResponse.message!);
      } on Error {
        yield CityyError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
