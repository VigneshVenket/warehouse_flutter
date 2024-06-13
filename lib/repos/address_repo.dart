
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/add_address_response.dart';
import 'package:flutter_kundol/api/responses/delete_address_response.dart';
import 'package:flutter_kundol/api/responses/get_address_response.dart';

abstract class AddressRepo {
  Future<GetAddressResponse> getAddress();
  Future<DeleteAddressResponse> deleteAddress(int id);
  Future<AddAddressResponse> addAddress(String firstName, String lastName, String gender, String company, String streetAddress, String suburb, String postCode, String dob, var city, int countryId, int stateId, String lat, String lng, String phone);
  Future<AddAddressResponse> updateAddress(int id, String firstName, String lastName, String gender, String company, String streetAddress, String suburb, String postCode, String dob, var city, int countryId, int stateId, String lat, String lng, String phone);
  Future<AddAddressResponse> setDefaultAddress(int addressId, String firstName, String lastName, String gender, String company, String streetAddress, String suburb, String postCode, String dob, var city, int countryId, int stateId, String lat, String lng, int isdefault,String phone);
}

class RealAddressRepo implements AddressRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<GetAddressResponse> getAddress() {
    return _apiProvider.getCustomerAddress();
  }

  @override
  Future<AddAddressResponse> addAddress(String firstName, String lastName, String gender, String company, String streetAddress, String suburb, String postCode, String dob, var city, int countryId, int stateId, String lat, String lng, String phone) {
    return _apiProvider.addCustomerAddress(firstName, lastName, gender, company, streetAddress, suburb, postCode, dob, city, countryId, stateId, lat, lng, phone);
  }

  @override
  Future<AddAddressResponse> setDefaultAddress(int addressId, String firstName, String lastName, String gender, String company, String streetAddress, String suburb, String postCode, String dob, var city, int countryId, int stateId, String lat, String lng,int isdefault, String phone) {
    return _apiProvider.setDefaultCustomerAddress(addressId, firstName, lastName, gender, company, streetAddress, suburb, postCode, dob, city, countryId, stateId, lat, lng,isdefault, phone);
  }

  @override
  Future<DeleteAddressResponse> deleteAddress(int id) {
    return _apiProvider.deleteCustomerAddress(id);
  }

  @override
  Future<AddAddressResponse> updateAddress(int id, String firstName, String lastName, String gender, String company, String streetAddress, String suburb, String postCode, String dob, var city, int countryId, int stateId, String lat, String lng, String phone) {
    return _apiProvider.updateCustomerAddress(id, firstName, lastName, gender, company, streetAddress, suburb, postCode, dob, city, countryId, stateId, lat, lng, phone);
  }
}