
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/user/user_event.dart';
import 'package:flutter_kundol/blocs/user/user_state.dart';

import '../../constants/app_constants.dart';
import '../../repos/user_repo.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;

  UserBloc(this.userRepo) : super(const UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UpdateUser) {
      try {
        yield const UserLoading();
        final updateUserResponse = await userRepo.updateUser(
            event.firstName,
            event.lastName,);
        if (updateUserResponse.status == AppConstants.STATUS_SUCCESS &&
            updateUserResponse.data != null) {
          yield UserUpdated(updateUserResponse);
        } else {
          yield UserError(updateUserResponse.message!);
        }
      } on Error {
        yield const UserError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
