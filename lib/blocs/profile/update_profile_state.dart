part of 'update_profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();

  @override
  List<Object> get props => [];
}

class ProfileUpdated extends ProfileState {
  final UpdateProfileResponse updateProfileResponse;

  const ProfileUpdated(this.updateProfileResponse);

  @override
  List<Object> get props => [updateProfileResponse];
}

class ProfileError extends ProfileState {
  final String error;

  const ProfileError(this.error);

  @override
  List<Object> get props => [error];
}
