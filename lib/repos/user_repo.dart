

import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/update_profile_response.dart';

import '../api/responses/user_response.dart';

abstract class UserRepo {
  Future<UpdateUserResponse> updateUser(String firstName, String lastName);
}

class RealUserRepo implements UserRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<UpdateUserResponse> updateUser(String firstName, String lastName) {
    return _apiProvider.updateUser(firstName, lastName);
  }
}