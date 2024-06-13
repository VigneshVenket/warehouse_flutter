
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/update_profile_address/update_profile_address_event.dart';
import 'package:flutter_kundol/blocs/update_profile_address/update_profile_address_state.dart';
import 'package:flutter_kundol/repos/update_profile_address_repo.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_data.dart';

class UpdateProfileAddressBloc extends Bloc<UpdateProfileAddressEvent,UpdateProfileAddressState> {
  final UpdateProfileAddressRepo updateProfileAddressRepo;

  UpdateProfileAddressBloc(this.updateProfileAddressRepo) : super(const UpdateProfileAddressInitial());

  @override
  Stream<UpdateProfileAddressState> mapEventToState(UpdateProfileAddressEvent event) async* {
  if (event is UpdateProfileAddress) {
      if (AppData.user == null) {
        yield UpdateProfileAddressLoaded(null!);
        return;
      }
      try {
        final updateProfileAddressResponse = await updateProfileAddressRepo.updateProfileAddress(
            event.id,
            event.firstName,
            event.lastName,
            event.gender,
            event.dob,
            event.lat,
            event.long,
            event.phone);
        if (updateProfileAddressResponse.status == AppConstants.STATUS_SUCCESS) {
          yield UpdateProfileAddressLoaded(updateProfileAddressResponse);
        } else {
          yield UpdateProfileAddressError(updateProfileAddressResponse.message!);
        }
      } on Error {
        yield const UpdateProfileAddressError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}