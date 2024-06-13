

import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/add_address_response.dart';
import 'package:flutter_kundol/api/responses/delete_address_response.dart';
import 'package:flutter_kundol/api/responses/get_address_response.dart';
// import 'package:flutter_kundol/repos/profile_address_response.dart';

import '../api/responses/profile_address_response.dart';

abstract class UpdateProfileAddressRepo {
  Future<UpdateProfileAddressResponse> updateProfileAddress(int id, String firstName, String lastName, String gender, String dob, String lat,String long,String phone);
}

class RealUpdateProfileAddressRepo implements UpdateProfileAddressRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<UpdateProfileAddressResponse> updateProfileAddress(int id, String firstName, String lastName, String gender,String dob,String lat,String long, String phone) {
    return _apiProvider.updateProfileAddress(id, firstName, lastName, gender, dob,lat,long, phone);
  }
}