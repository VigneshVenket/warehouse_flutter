
part of 'update_profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const  ProfileEvent();
}

class UpdateProfile extends ProfileEvent {

  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;

  const UpdateProfile(this.firstName, this.lastName, this.password, this.confirmPassword);

  @override
  List<Object> get props => [firstName, lastName, password, confirmPassword];
}
