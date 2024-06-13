
part of 'contact_us_bloc.dart';

abstract class ContactUsEvent extends Equatable {
  const ContactUsEvent();
}

class SubmitContactUs extends ContactUsEvent {

  final String firstName;
  final String lastName;
  final String email;
  final String comment;

  const SubmitContactUs(this.firstName, this.lastName, this.email, this.comment);

  @override
  List<Object> get props => [firstName, lastName, email, comment];
}
