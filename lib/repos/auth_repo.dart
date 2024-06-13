
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/forgot_password_response.dart';
import 'package:flutter_kundol/api/responses/login_response.dart';
import 'package:flutter_kundol/api/responses/logout_response.dart';
import 'package:flutter_kundol/api/responses/register_response.dart';

abstract class AuthRepo {
  Future<LoginResponse> loginUser(String email, String password);
  Future<LoginResponse> loginWithFacebook(String accessToken);
  Future<LoginResponse> loginWithGoogle(String accessToken);
  Future<RegisterResponse> registerUser(String firstName, String lastName, String email, String password, String confirmPassword,String phoneNumber);
  Future<LogoutResponse> logoutUser();
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RealAuthRepo implements AuthRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  Future<LoginResponse> loginUser(String email, String password) {
    return apiProvider.loginUser(email, password);
  }

  @override
  Future<RegisterResponse> registerUser(String firstName, String lastName, String email, String password, String confirmPassword,String phoneNumber) {
    return apiProvider.registerUser(firstName, lastName, email, password, confirmPassword,phoneNumber);
  }

  @override
  Future<LogoutResponse> logoutUser() {
    return ApiProvider().doLogout();
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) {
    return ApiProvider().forgotPassword(email);
  }

  @override
  Future<LoginResponse> loginWithFacebook(String accessToken) {
    return ApiProvider().loginWithFacebook(accessToken);
  }

  @override
  Future<LoginResponse> loginWithGoogle(String accessToken) {
    return ApiProvider().loginWithGoogle(accessToken);
  }
}

class FakeAuthRepo implements AuthRepo {
  @override
  Future<LoginResponse> loginUser(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<RegisterResponse> registerUser(String firstName, String lastName, String email, String password, String confirmPassword,String phoneNumber) {
    throw UnimplementedError();
  }

  @override
  Future<LogoutResponse> logoutUser() {
    throw UnimplementedError();
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> loginWithFacebook(String accessToken) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> loginWithGoogle(String accessToken) {
    throw UnimplementedError();
  }

}