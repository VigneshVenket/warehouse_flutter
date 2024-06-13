

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_kundol/blocs/tax/tax_event.dart';
import 'package:flutter_kundol/blocs/tax/tax_state.dart';
// import 'package:your_project/models/tax_rate.dart';
// import 'package:your_project/repositories/tax_rate_repository.dart';
// import 'package:your_project/blocs/tax_rate_event.dart';
// import 'package:your_project/blocs/tax_rate_state.dart';

import '../../repos/tax_repo.dart';

class TaxRateBloc extends Bloc<TaxRateEvent, TaxRateState> {
  final TaxRepo taxRepo;

  TaxRateBloc(this.taxRepo) : super(TaxRateInitial());

  @override
  Stream<TaxRateState> mapEventToState(TaxRateEvent event) async* {
    if (event is FetchTaxRate) {
      yield TaxRateLoading();
      try {
        final taxRates = await taxRepo.getTax(
          event.stateId,
        );
        yield TaxRateLoaded(taxRates.data);
      } catch (e) {
        print(e.toString());
        yield TaxRateError(e.toString());
      }
    }
  }
}
