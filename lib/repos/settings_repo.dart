import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';

abstract class ServerSettingsRepo {
  Future<SettingsResponse> fetchServerSettings();
}

class RealServerSettingsRepo implements ServerSettingsRepo {
  final ApiProvider _apiProvider = ApiProvider();



  @override
  Future<SettingsResponse> fetchServerSettings() {
    return _apiProvider.getSettings();
  }
}

class FakeServerSettingsRepo implements ServerSettingsRepo {
  @override
  Future<SettingsResponse> fetchServerSettings() {
    throw UnimplementedError();
  }
}
