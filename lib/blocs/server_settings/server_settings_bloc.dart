import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/settings_repo.dart';

part 'server_settings_event.dart';

part 'server_settings_state.dart';

class ServerSettingsBloc
    extends Bloc<ServerSettingsEvent, ServerSettingsState> {
  final ServerSettingsRepo serverSettingsRepo;

  ServerSettingsBloc(this.serverSettingsRepo) : super(const ServerSettingsInitial());

  @override
  Stream<ServerSettingsState> mapEventToState(ServerSettingsEvent event) async* {
    if (event is GetServerSettings) {
      try {
        final settingsResponse = await serverSettingsRepo.fetchServerSettings();
        if (settingsResponse.status == AppConstants.STATUS_SUCCESS &&
            settingsResponse.data != null) {
          yield ServerSettingsLoaded(settingsResponse);
        } else {
          yield ServerSettingsError(settingsResponse.message!);
        }
      } on Error catch (error) {
        print(error.stackTrace);
        yield const ServerSettingsError("Something went wrong!");
      }
    }
  }
}
