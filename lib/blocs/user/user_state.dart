

import 'package:equatable/equatable.dart';

import '../../api/responses/user_response.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  const UserLoading ();

  @override
  List<Object> get props => [];
}

class UserUpdated extends UserState {
  final UpdateUserResponse updateUserResponse;

  const UserUpdated(this.updateUserResponse);

  @override
  List<Object> get props => [updateUserResponse];
}

class UserError extends UserState {
  final String error;

  const UserError(this.error);

  @override
  List<Object> get props => [error];
}