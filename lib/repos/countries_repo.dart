// import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/countries_response.dart';
//
// abstract class CountriesRepo {
//   Future<CountriesResponse> fetchCountries();
// }
//
// class RealCountriesRepo implements CountriesRepo {
//   ApiProvider _apiProvider = ApiProvider();
//
//   @override
//   Future<CountriesResponse> fetchCountries() {
//     return _apiProvider.getCountries();
//   }
// }
//
// class FakeCountriesRepo implements CountriesRepo {
//   @override
//   Future<CountriesResponse> fetchCountries() {
//     throw UnimplementedError();
//   }
// }
