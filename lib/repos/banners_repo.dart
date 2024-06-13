
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/banners_response.dart';

abstract class BannersRepo {
  Future<BannersResponse> fetchBanners();
}

class RealBannersRepo implements BannersRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<BannersResponse> fetchBanners() {
    return _apiProvider.getBanners();
  }
}

class FakeBannersRepo implements BannersRepo {
  @override
  Future<BannersResponse> fetchBanners() {
    throw UnimplementedError();
  }
}
