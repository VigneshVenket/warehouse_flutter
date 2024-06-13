import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/contact_us_repo.dart';

part 'contact_us_event.dart';

part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final ContactUsRepo contactUsRepo;

  ContactUsBloc(this.contactUsRepo) : super(const ContactUsInitial());

  @override
  Stream<ContactUsState> mapEventToState(ContactUsEvent event) async* {
    if (event is SubmitContactUs) {
      try {
        final contactusResponse = await contactUsRepo.submitContactUs(
            event.firstName, event.lastName, event.email, event.comment);
        if (contactusResponse.status == AppConstants.STATUS_SUCCESS &&
            contactusResponse.data != null) {
          yield ContactUsLoaded(contactusResponse.message!);
        } else {
          yield ContactUsError(contactusResponse.message!);
        }
      } on Error {
        yield const ContactUsError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
