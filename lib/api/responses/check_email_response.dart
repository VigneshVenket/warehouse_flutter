

import 'package:flutter_kundol/constants/app_constants.dart';

class CheckEmailResponse {
   String ?status;
  String ?message;

  CheckEmailResponse({required this.status, required this.message});

  factory CheckEmailResponse.fromJson(Map<String, dynamic> json) {
    return CheckEmailResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  CheckEmailResponse.withError(String error){
    status=AppConstants.STATUS_ERROR;
    message=error;
  }

}
