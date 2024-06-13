import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/user.dart';
import 'package:flutter_kundol/repos/auth_repo.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is PerformLogin) {
      String? errorMessage;
      try {
        final loginResponse =
            await authRepo.loginUser(event.email, event.password);
        if (loginResponse.status == AppConstants.STATUS_SUCCESS &&
            loginResponse.data != null)
          yield AuthenticatedLoginManual(
              loginResponse.data!, loginResponse.status);
        else {
          print(loginResponse.message);
          // loginResponse.errors!.forEach((field, errorMessages) {
          //   print('  $field: ${errorMessages.join(', ')}');
          //   print(errorMessages[0]);
          //   errorMessage=errorMessages[0];
          // });
          // yield AuthFailed(registerResponse.message!);
          errorMessage = loginResponse.message;
          yield AuthLoginFailed(errorMessage);
        }
        // yield AuthLoginFailed(loginResponse.message!);
      } on Error {
        yield AuthLoginFailed("Some error occured");
      }
    } else if (event is PerformRegister) {
      String? errorMessage;
      try {
        final registerResponse = await authRepo.registerUser(event.firstName,
            event.lastName, event.email, event.password, event.confirmPassword,event.phoneNumber);
        if (registerResponse.status == AppConstants.STATUS_SUCCESS &&
            registerResponse.data != null)
          yield AuthenticatedRegisterManual(
              registerResponse.data!, registerResponse.status);
        else {
          print(registerResponse.message);
          registerResponse.errors!.forEach((field, errorMessages) {
            print('  $field: ${errorMessages.join(', ')}');
            print(errorMessages[0]);
            errorMessage = errorMessages[0];
          });
          // yield AuthFailed(registerResponse.message!);
          yield AuthRegisterFailed(errorMessage);
        }
      } on Error {
        yield AuthRegisterFailed("Some error occurred");
      }
    }
    else if (event is PerformLogout) {
      try {
        final logoutResponse = await authRepo.logoutUser();
        if (logoutResponse.status == AppConstants.STATUS_SUCCESS) {
          AppData.user = null;
          final sharedPrefService = await SharedPreferencesService.instance;
          sharedPrefService.logoutUser();
          yield UnAuthenticated();
        } else
          yield AuthFailed(logoutResponse.message!);
      } on Error {
        yield AuthFailed("Some error occured");
      }
    } else if (event is PerformAutoLogin) {
      yield Authenticated(event.user);
    } else if (event is PerformForgotPassword) {
      try {
        final forgotPasswordResponse =
            await authRepo.forgotPassword(event.email);
        if (forgotPasswordResponse.status == AppConstants.STATUS_SUCCESS) {
          yield EmailSent(forgotPasswordResponse.message!);
        } else
          yield AuthFailed(forgotPasswordResponse.message!);
      } on Error {
        yield AuthFailed("Some error occured");
      }
    } else if (event is PerformFacebookLogin) {
      try {
        final facebookLoginResponse =
            await authRepo.loginWithFacebook(event.accessToken);
        if (facebookLoginResponse.status == AppConstants.STATUS_SUCCESS) {
          yield Authenticated(facebookLoginResponse.data!);
        } else
          yield AuthFailed(facebookLoginResponse.message!);
      } on Error {
        yield AuthFailed("Some error occured");
      }
    } else if (event is PerformGoogleLogin) {
      try {
        final googleLoginResponse = await authRepo.loginWithGoogle(event.accessToken);
        if (googleLoginResponse.status == AppConstants.STATUS_SUCCESS) {
          yield Authenticated(googleLoginResponse.data!);
        } else
          yield AuthFailed(googleLoginResponse.message!);
      } on Error {
        yield AuthFailed("Some error occured");
      }
    }
  }
}
