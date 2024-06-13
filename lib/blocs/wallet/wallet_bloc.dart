import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_event.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/orders_data.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';

import '../../repos/wallet_repo.dart';

// part 'orders_event.dart';
//
// part 'orders_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepo walletRepo;

  WalletBloc(this.walletRepo) : super(WalletInitial());

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is GetWallet && AppData.user != null) {
      try {
        final walletResponse = await walletRepo.getWallet();
        if (walletResponse.status == AppConstants.STATUS_SUCCESS &&
            walletResponse.data != null)
          yield WalletLoaded(walletResponse.data!);
        else
          yield WalletError(walletResponse.message!);
      } on Error {
        yield WalletError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
