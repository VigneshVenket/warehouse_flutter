



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/check_email_repo.dart';
import 'package:http/http.dart' as http;

import 'check_email_event.dart';
import 'check_email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final CheckEmailRepo _checkEmailRepo;

  EmailBloc(this._checkEmailRepo) : super(EmailInitial());

  @override
  Stream<EmailState> mapEventToState(EmailEvent event) async* {
    if (event is CheckEmail) {
      yield EmailLoading();
      try {
        final response = await _checkEmailRepo.checkEmail(event.email);
        print(event.email);
        print(response);
        print(response.status);
     //   print(AppConstants.STATUS_SUCCESS);
        if (response.status == AppConstants.STATUS_SUCCESS) {
          yield EmailLoaded(response: response);
        } else {
          yield EmailError(message:response.message!);
        }
      } catch (e) {
        yield EmailError(message: 'An error occurred: $e');
      }
    }
  }
}
