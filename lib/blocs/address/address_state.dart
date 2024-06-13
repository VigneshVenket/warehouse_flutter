part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  const AddressInitial();

  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {
  const AddressLoading();

  @override
  List<Object> get props => [];
}

class AddressLoaded extends AddressState {
  final List<AddressData> addressData;

  const AddressLoaded(this.addressData);

  @override
  List<Object> get props => [addressData];
}

class AddressError extends AddressState {
  final String error;

  const AddressError(this.error);

  @override
  List<Object> get props => [error];
}
