
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/update_profile_response.dart';

abstract class ProfileRepo {
  Future<UpdateProfileResponse> updateProfile(String firstName, String lastName, String password, String confirmPassword);
}

class RealProfileRepo implements ProfileRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<UpdateProfileResponse> updateProfile(String firstName, String lastName, String password, String confirmPassword) {
    return _apiProvider.updateProfile(firstName, lastName, password, confirmPassword);
  }
}