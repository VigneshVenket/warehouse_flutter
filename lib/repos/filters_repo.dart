
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/filters_response.dart';

abstract class FiltersRepo {
  Future<FiltersResponse> getFilters();
}

class RealFiltersRepo implements FiltersRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<FiltersResponse> getFilters() {
    return _apiProvider.getFilters();
  }
}