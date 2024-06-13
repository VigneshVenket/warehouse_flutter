part of 'add_address_bloc.dart';

abstract class AddAddressState extends Equatable {
  const AddAddressState();
}

class AddAddressInitial extends AddAddressState {
  const AddAddressInitial();

  @override
  List<Object> get props => [];
}

class AddAddressLoading extends AddAddressState {
  const AddAddressLoading();

  @override
  List<Object> get props => [];
}

class AddAddressLoaded extends AddAddressState {
  final AddAddressResponse addAddressResponse;

  const AddAddressLoaded(this.addAddressResponse);

  @override
  List<Object> get props => [addAddressResponse];
}

class AddAddressError extends AddAddressState {
  final String error;

  const AddAddressError(this.error);

  @override
  List<Object> get props => [error];
}
