part of 'add_addressbook_bloc.dart';

abstract class AddAddressBookState extends Equatable {
  const AddAddressBookState();
}

class AddAddressBookInitial extends AddAddressBookState {
  const AddAddressBookInitial();

  @override
  List<Object> get props => [];
}

class AddAddressBookLoading extends AddAddressBookState {
  const AddAddressBookLoading();

  @override
  List<Object> get props => [];
}

class AddAddressBookLoaded extends AddAddressBookState {
  final AddAddressResponse addAddressResponse;

  const AddAddressBookLoaded(this.addAddressResponse);

  @override
  List<Object> get props => [addAddressResponse];
}

class AddAddressBookError extends AddAddressBookState {
  final String error;

  const AddAddressBookError(this.error);

  @override
  List<Object> get props => [error];
}
