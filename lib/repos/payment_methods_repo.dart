import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/payment_method_response.dart';

abstract class PaymentMethodsRepo {
  Future<PaymentMethodsResponse> fetchPaymentMethods();
}

class RealPaymentMethodsRepo implements PaymentMethodsRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<PaymentMethodsResponse> fetchPaymentMethods() {
    return _apiProvider.getPaymentMethods();
  }
}

class FakePaymentMethodsRepo implements PaymentMethodsRepo {
  @override
  Future<PaymentMethodsResponse> fetchPaymentMethods() {
    throw UnimplementedError();
  }
}
