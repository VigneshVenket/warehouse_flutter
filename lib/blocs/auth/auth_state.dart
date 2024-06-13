part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

class AuthenticatedRegisterManual extends AuthState {
  final User? user;
  final String? message;

  const AuthenticatedRegisterManual(this.user,this.message);

  @override
  List<Object> get props => [this.user!];
}

class AuthenticatedLoginManual extends AuthState {
  final User? user;
  final String? message;

  const AuthenticatedLoginManual(this.user,this.message);

  @override
  List<Object> get props => [this.user!];
}

class Authenticated extends AuthState {
  final User? user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [this.user!];
}

class UnAuthenticated extends AuthState {
  const UnAuthenticated();

  @override
  List<Object> get props => [];
}

class AuthRegisterFailed extends AuthState {
  final String? message;

  const AuthRegisterFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}

class AuthLoginFailed extends AuthState {
  final String? message;

  const AuthLoginFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}

class AuthFailed extends AuthState {
  final String? message;

  const AuthFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}

class EmailSent extends AuthState {

  final String? message;

  const EmailSent(this.message);

  @override
  List<Object> get props => [this.message!];
}