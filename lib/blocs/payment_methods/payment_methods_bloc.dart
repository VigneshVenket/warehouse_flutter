import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/payment_method_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/payment_methods_repo.dart';

part 'payment_methods_event.dart';

part 'payment_methods_state.dart';

class PaymentMethodsBloc extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  final PaymentMethodsRepo paymentMethodsRepo;

  PaymentMethodsBloc(this.paymentMethodsRepo) : super(const PaymentMethodsInitial());

  @override
  Stream<PaymentMethodsState> mapEventToState(
      PaymentMethodsEvent event,
      ) async* {
    if (event is GetPaymentMethods) {
      try {
        final paymentMethodsResponse = await paymentMethodsRepo.fetchPaymentMethods();
        if (paymentMethodsResponse.status == AppConstants.STATUS_SUCCESS &&
            paymentMethodsResponse.data != null) {
          yield PaymentMethodsLoaded(paymentMethodsResponse);
        } else {
          yield PaymentMethodsError(paymentMethodsResponse.message!);
        }
      } on Error {
        yield const PaymentMethodsError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

