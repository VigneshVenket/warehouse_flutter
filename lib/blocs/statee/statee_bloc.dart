import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/statee/statee_event.dart';
import 'package:flutter_kundol/blocs/statee/statee_state.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_event.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import '../../repos/countryy_repo.dart';
import '../../repos/statee_repo.dart';



class StateeBloc extends Bloc<StateeEvent, StateeState> {
  final StateeRepo stateeRepo;

  StateeBloc(this.stateeRepo) : super(StateeInitial());

  @override
  Stream<StateeState> mapEventToState(StateeEvent event) async* {
    print("states call");
    if (event is GetStatee && AppData.user != null) {
      try {
        final stateeResponse = await stateeRepo.getStatee(event.value);
        if (stateeResponse.status == AppConstants.STATUS_SUCCESS &&
            stateeResponse.data != null){
          print("states call");
        print(stateeResponse.data);
          yield StateeLoaded(stateeResponse.data!);}
        else
          yield StateeError(stateeResponse.message!);
      } on Error {
        yield StateeError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
