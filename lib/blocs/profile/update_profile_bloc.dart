import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/update_profile_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/profile_repo.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo profileRepo;

  ProfileBloc(this.profileRepo) : super(const ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateProfile) {
      try {
        yield const ProfileLoading();
        final updateProfileResponse = await profileRepo.updateProfile(
            event.firstName,
            event.lastName,
            event.password,
            event.confirmPassword);
        if (updateProfileResponse.status == AppConstants.STATUS_SUCCESS &&
            updateProfileResponse.data != null) {
          yield ProfileUpdated(updateProfileResponse);
        } else {
          yield ProfileError(updateProfileResponse.message!);
        }
      } on Error {
        yield const ProfileError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
