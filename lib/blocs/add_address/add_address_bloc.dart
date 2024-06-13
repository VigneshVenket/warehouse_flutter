import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/add_address_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';

part 'add_address_event.dart';

part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddressRepo addressRepo;

  AddAddressBloc(this.addressRepo) : super(const AddAddressInitial());

  @override
  Stream<AddAddressState> mapEventToState(AddAddressEvent event) async* {
    if (event is AddAddress) {
      if (AppData.user == null) {
        yield  AddAddressLoaded(null!);
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
            //event.city,
            event.countryId,
            event.state_id,
            event.city,
            event.lat,
            event.lng,
            event.phone);
        if (addressResponse.status == AppConstants.STATUS_SUCCESS) {
          yield AddAddressLoaded(addressResponse);
        } else {
          yield AddAddressError(addressResponse.message!);
        }
      } on Error {
        yield const AddAddressError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
