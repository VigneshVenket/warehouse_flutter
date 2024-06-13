import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/add_address_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';

part 'add_addressbook_event.dart';

part 'add_addressbook_state.dart';

class AddAddressBookBloc
    extends Bloc<AddAddressBookEvent, AddAddressBookState> {
  final AddressRepo addressRepo;

  AddAddressBookBloc(this.addressRepo) : super(const AddAddressBookInitial());

  @override
  Stream<AddAddressBookState> mapEventToState(
      AddAddressBookEvent event) async* {
    if (event is AddAddressBook) {
      if (AppData.user == null) {
        yield  AddAddressBookLoaded(null!);
        return;
      }
      try {
        final addressResponse = await addressRepo.addAddress(
            event.firstName,
            event.lastName,
            event.gender,
            event.company,
            event.streetAddress,
            event.suburb,
            event.postCode,
            event.dob,
          //  event.city,
            event.countryId,
            event.state_id,
            event.city,
            event.lat,
            event.lng,
            event.phone
        );
        if (addressResponse.status == AppConstants.STATUS_SUCCESS) {
          yield AddAddressBookLoaded(addressResponse);
        } else {
          yield AddAddressBookError(addressResponse.message!);
        }
      } on Error {
        yield const AddAddressBookError(
            "Couldn't fetch weather. Is the device online?");
      }
    } else if (event is UpdateAddressBook) {
      if (AppData.user == null) {
        yield  AddAddressBookLoaded(null!);
        return;
      }
      try {
        final addressResponse = await addressRepo.updateAddress(
            event.id,
            event.firstName,
            event.lastName,
            event.gender,
            event.company,
            event.streetAddress,
            event.suburb,
            event.postCode,
            event.dob,
          //  event.city,
            event.countryId,
            event.state_id,
            event.city,
            event.lat,
            event.lng,
            event.phone);
        if (addressResponse.status == AppConstants.STATUS_SUCCESS) {
          yield AddAddressBookLoaded(addressResponse);
        } else {
          yield AddAddressBookError(addressResponse.message!);
        }
      } on Error {
        yield const AddAddressBookError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
