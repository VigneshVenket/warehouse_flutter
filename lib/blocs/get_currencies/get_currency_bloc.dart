import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/currencies_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/get_currency_repo.dart';

part 'get_currency_event.dart';

part 'get_currency_state.dart';

class GetCurrenciesBloc extends Bloc<GetCurrencyEvent, GetCurrencyState> {
  final GetCurrencyRepo getCurrencyRepo;

  GetCurrenciesBloc(this.getCurrencyRepo) : super(const GetCurrencyInitial());

  @override
  Stream<GetCurrencyState> mapEventToState(GetCurrencyEvent event) async* {
    if (event is GetCurrencies) {
      try {
        final currenciesResponse = await getCurrencyRepo.fetchCurrencies();
        if (currenciesResponse.status == AppConstants.STATUS_SUCCESS &&
            currenciesResponse.data != null) {
          yield GetCurrencyLoaded(currenciesResponse);
        } else {
          yield GetCurrencyError(currenciesResponse.message!);
        }
      } on Error {
        yield const GetCurrencyError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
