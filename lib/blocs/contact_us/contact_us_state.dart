
part of 'contact_us_bloc.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();
}

class ContactUsInitial extends ContactUsState {
  const ContactUsInitial();

  @override
  List<Object> get props => [];
}

class ContactUsLoading extends ContactUsState {
  const ContactUsLoading();

  @override
  List<Object> get props => [];
}

class ContactUsLoaded extends ContactUsState {
  final String message;

  const ContactUsLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class ContactUsError extends ContactUsState {
  final String error;

  const ContactUsError(this.error);

  @override
  List<Object> get props => [error];
}
