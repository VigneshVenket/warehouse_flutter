
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/language_data.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(LanguageData languageData)
      : super(LanguageState(languageData));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageLoadStarted) {
      yield* _mapLanguageLoadStartedToState();
    } else if (event is LanguageSelected) {
      yield* _mapLanguageSelectedToState(event.language);
    } else if (event is LanguageLoadServer) {
      yield* _mapLanguageLoadServerToState(event.language);
    }
  }

  Stream<LanguageState> _mapLanguageLoadStartedToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    final String? selectedLangTitle = sharedPrefService.selectedLangTitle;
    final int? selectedLangId = sharedPrefService.selectedLangId;
    final String? selectedLangCode = sharedPrefService.selectedLangCode;

    LanguageData languageData = LanguageData();

    if (selectedLangId == null) {
      languageData.languageName = "English";
      languageData.id = 1;
      languageData.code = "en";
    } else {
      languageData.languageName = selectedLangTitle;
      languageData.id = selectedLangId;
      languageData.code = selectedLangCode;
    }

    yield LanguageState(languageData);
  }

  Stream<LanguageState> _mapLanguageSelectedToState(LanguageData language) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    await sharedPrefService.setSelectedLangTitle(language.languageName!);
    await sharedPrefService.setSelectedLangId(language.id!);
    await sharedPrefService.setSelectedLangCode(language.code!);
    yield LanguageState(language);
  }

  Stream<LanguageState> _mapLanguageLoadServerToState(LanguageData language) async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    LanguageData languageData = LanguageData();

    final String? selectedLangTitle = sharedPrefService.selectedLangTitle;
    final int? selectedLangId = sharedPrefService.selectedLangId;
    final String? selectedLangCode = sharedPrefService.selectedLangCode;

    if (selectedLangId == null) {

      final String? selectedLangTitle = AppData.settingsResponse!.getKeyValue(SettingsResponse.LANGUAGE_CODE).toUpperCase().trim();
      final int? selectedLangId = int.parse(AppData.settingsResponse!.getKeyValue(SettingsResponse.LANGUAGE_ID).toString());
      final String? selectedLangCode = AppData.settingsResponse!.getKeyValue(SettingsResponse.LANGUAGE_CODE).toLowerCase().trim();

      await sharedPrefService.setSelectedLangTitle(selectedLangTitle!);
      await sharedPrefService.setSelectedLangId(selectedLangId!);
      await sharedPrefService.setSelectedLangCode(selectedLangCode!);

      languageData.languageName = selectedLangTitle;
      languageData.id = selectedLangId;
      languageData.code = selectedLangCode;

    } else {
      languageData.languageName = selectedLangTitle;
      languageData.id = selectedLangId;
      languageData.code = selectedLangCode;
    }
    yield LanguageState(languageData);
  }
}
