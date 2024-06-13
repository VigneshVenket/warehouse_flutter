import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/contact_us_response.dart';

abstract class ContactUsRepo {
  Future<ContactUsResponse> submitContactUs(String firstName, String lastName, String email, String message);
}

class RealContactUsRepo implements ContactUsRepo{
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ContactUsResponse> submitContactUs(String firstName, String lastName, String email, String message) {
    return _apiProvider.submitContactUs(firstName, lastName, email, message);
  }
}