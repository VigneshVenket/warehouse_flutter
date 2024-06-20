import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepo addressRepo;

  AddressBloc(this.addressRepo) : super(const AddressInitial());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    if (event is GetAddress && AppData.user != null) {
      print("AddressEvent");
      try {
        yield const AddressLoading();
        // print("AddressEvent");
        final addressResponse = await addressRepo.getAddress();
        // print("AddressEvent");
        // print(addressResponse);
        if (addressResponse.status == AppConstants.STATUS_SUCCESS &&
            addressResponse.data != null) {
          yield AddressLoaded(addressResponse.data!);
        } else {
          yield AddressError(addressResponse.message!);
        }
      } on Error {
        yield const AddressError("Couldn't fetch weather. Is the device online?");
      }
    }  else if (event is SetDefaultAddress) {
      try {
        yield const AddressLoading();
        final addressDefaultResponse = await addressRepo.setDefaultAddress(
            event.addressID,
            event.firstName,
            event.lastName,
            event.gender,
            event.company,
            event.streetAddress,
            event.suburb,
            event.postCode,
            event.dob,
            event.city,
            event.countryId,
            event.state_id,
            //  event.city,
            event.lat,
            event.lng,
            event.isdefault,
            event.phone);
        final addressResponse = await addressRepo.getAddress();
        print(addressDefaultResponse);
        if (addressResponse.status == AppConstants.STATUS_SUCCESS &&
            addressResponse.data != null) {
          yield AddressLoaded(addressResponse.data!);
        } else {
          yield AddressError(addressResponse.message!);
        }
      } on Error {
        yield const AddressError("Couldn't fetch weather. Is the device online?");
      }
    }else if (event is DeleteAddress) {
      try {
        yield const AddressLoading();
        final deleteAddressResponse = await addressRepo.deleteAddress(event.addressId);
        final addressResponse = await addressRepo.getAddress();
        if (addressResponse.status == AppConstants.STATUS_SUCCESS &&
            addressResponse.data != null) {
          yield AddressLoaded(addressResponse.data!);
        } else {
          yield AddressError(addressResponse.message!);
        }
      } on Error {
        yield const AddressError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
