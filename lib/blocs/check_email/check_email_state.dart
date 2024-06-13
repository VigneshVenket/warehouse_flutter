


import '../../api/responses/check_email_response.dart';

abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailLoaded extends EmailState {
  final CheckEmailResponse response;

  EmailLoaded({required this.response});
}

class EmailError extends EmailState {
  final String message;

  EmailError({required this.message});
}
