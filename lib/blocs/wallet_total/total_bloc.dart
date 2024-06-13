import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_event.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_state.dart';
import 'package:flutter_kundol/blocs/wallet_total/total_event.dart';
import 'package:flutter_kundol/blocs/wallet_total/total_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/orders_data.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';

import '../../repos/total_repo.dart';
import '../../repos/wallet_repo.dart';

// part 'orders_event.dart';
//
// part 'orders_state.dart';

class TotalBloc extends Bloc<TotalEvent, TotalState> {
  final TotalRepo totalRepo;

  TotalBloc(this.totalRepo) : super(TotalInitial());

  @override
  Stream<TotalState> mapEventToState(TotalEvent event) async* {
    if (event is GetTotal && AppData.user != null) {
   //   try {
        final totalResponse = await totalRepo.getTotal();
        if (totalResponse.status == AppConstants.STATUS_SUCCESS &&
            totalResponse.data != null)
          yield TotalLoaded(totalResponse.data!);

      //   else
      //     yield TotalError(totalResponse.message!);
      // } on Error {
      //   yield TotalError("Couldn't fetch weather. Is the device online?");
      // }
    }
  }
}
