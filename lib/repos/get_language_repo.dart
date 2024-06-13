import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/languages_response.dart';

abstract class GetLanguageRepo {
  Future<LanguagesResponse> fetchLanguages();
}

class RealGetLanguageRepo implements GetLanguageRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<LanguagesResponse> fetchLanguages() {
    return _apiProvider.getLanguages();
  }
}

class FakeBannersRepo implements GetLanguageRepo {
  @override
  Future<LanguagesResponse> fetchLanguages() {
    throw UnimplementedError();
  }
}
