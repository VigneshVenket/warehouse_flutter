


import 'package:flutter_kundol/api/responses/check_email_response.dart';

import '../api/api_provider.dart';

abstract class CheckEmailRepo {

  Future<CheckEmailResponse> checkEmail(String email);

}

class RealCheckEmailRepo implements CheckEmailRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CheckEmailResponse> checkEmail(email){
    return _apiProvider.checkEmail(email);
  }


}