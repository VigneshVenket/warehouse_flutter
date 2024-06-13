
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/get_page_response.dart';

abstract class PageRepo {
  Future<GetPageResponse> getPages(int pageNo);
}

class RealPageRepo implements PageRepo {

  final ApiProvider? _apiProvider = ApiProvider();

  @override
  Future<GetPageResponse> getPages(int pageNo) {
    return _apiProvider!.getPage(pageNo);
  }
}

class FakePageRepo implements PageRepo {
  @override
  Future<GetPageResponse> getPages(int pageNo) {
    throw UnimplementedError();
  }
}