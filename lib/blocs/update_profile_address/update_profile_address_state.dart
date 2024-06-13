

import 'package:equatable/equatable.dart';

import '../../api/responses/profile_address_response.dart';
// import '../../repos/profile_address_response.dart';

abstract class UpdateProfileAddressState extends Equatable {
  const UpdateProfileAddressState();
}

class UpdateProfileAddressInitial extends UpdateProfileAddressState {
  const UpdateProfileAddressInitial();

  @override
  List<Object> get props => [];
}

class UpdateProfileAddressLoading extends UpdateProfileAddressState {
  const UpdateProfileAddressLoading();

  @override
  List<Object> get props => [];
}

class UpdateProfileAddressLoaded extends UpdateProfileAddressState {
  final UpdateProfileAddressResponse updateProfileAddressResponse;

  const UpdateProfileAddressLoaded(this.updateProfileAddressResponse);

  @override
  List<Object> get props => [updateProfileAddressResponse];
}

class UpdateProfileAddressError extends UpdateProfileAddressState {
  final String error;

  const UpdateProfileAddressError(this.error);

  @override
  List<Object> get props => [error];
}