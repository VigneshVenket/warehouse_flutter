import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String SELECTED_LANG_TITLE = 'selected_language_title';
  static const String SELECTED_LANG_ID = 'selected_language_id';
  static const String SELECTED_LANG_CODE = 'selected_language_code';
  static const String SELECTED_CURRENCY_TITLE = 'selected_currency_title';
  static const String SELECTED_CURRENCY_ID = 'selected_currency_id';
  static const String SELECTED_CURRENCY_SYMBOL = 'selected_currency_symbol';
  static const String SELECTED_COLOR_INDEX = 'selected_color_index';
  static const String SELECTED_THEME_DARK = "selected_theme_dark";

  static const String USER_ID = 'user_id';
  static const String USER_FIRST_NAME = 'user_first_name';
  static const String USER_LAST_NAME = 'user_last_name';
  static const String USER_EMAIL = 'user_email';
  static const String USER_TOKEN = 'user_token';
}

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    _instance ??= SharedPreferencesService._internal();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  Future<void> setSelectedLangTitle(String langTitle) async =>
      await _preferences?.setString(SharedPrefKeys.SELECTED_LANG_TITLE, langTitle);

  String? get selectedLangTitle =>
      _preferences?.getString(SharedPrefKeys.SELECTED_LANG_TITLE);

  Future<void> setSelectedLangId(int langId) async =>
      await _preferences?.setInt(SharedPrefKeys.SELECTED_LANG_ID, langId);

  int? get selectedLangId =>
      _preferences?.getInt(SharedPrefKeys.SELECTED_LANG_ID);

  Future<void>? setSelectedLangCode(String langCode) async =>
      await _preferences?.setString(SharedPrefKeys.SELECTED_LANG_CODE, langCode);

  String? get selectedLangCode =>
      _preferences?.getString(SharedPrefKeys.SELECTED_LANG_CODE);

  Future<void>? setSelectedCurrencyTitle(String currencyTitle) async =>
      await _preferences?.setString(SharedPrefKeys.SELECTED_CURRENCY_TITLE, currencyTitle);

  String? get selectedCurrencyTitle =>
      _preferences?.getString(SharedPrefKeys.SELECTED_CURRENCY_TITLE);

  Future<void> setSelectedCurrencyId(int currencyId) async =>
      await _preferences?.setInt(SharedPrefKeys.SELECTED_CURRENCY_ID, currencyId);

  int ? get selectedCurrencyId =>
      _preferences?.getInt(SharedPrefKeys.SELECTED_CURRENCY_ID);

  Future<void> setSelectedCurrencySymbol(String currencySymbol) async =>
      await _preferences?.setString(SharedPrefKeys.SELECTED_CURRENCY_SYMBOL, currencySymbol);

  String ? get selectedCurrencySymbol =>
      _preferences?.getString(SharedPrefKeys.SELECTED_CURRENCY_SYMBOL);

  Future<void> setSelectedColorIndex(int selectedIndex) async =>
      await _preferences?.setInt(
          SharedPrefKeys.SELECTED_COLOR_INDEX, selectedIndex);

  int ? get selectedColorIndex =>
      _preferences?.getInt(SharedPrefKeys.SELECTED_COLOR_INDEX);

  Future<void> setSelectedThemeDark(bool isDark) async =>
      await _preferences?.setBool(SharedPrefKeys.SELECTED_THEME_DARK, isDark);

  bool ? get selectedThemeDark =>
      _preferences?.getBool(SharedPrefKeys.SELECTED_THEME_DARK);

  Future<void> setUserID(int userId) async =>
      await _preferences?.setInt(SharedPrefKeys.USER_ID, userId);

  int ? get userId => _preferences?.getInt(SharedPrefKeys.USER_ID);

  Future<void> setUserFirstName(String userName) async =>
      await _preferences?.setString(SharedPrefKeys.USER_FIRST_NAME, userName);

  String ? get userFirstName =>
      _preferences?.getString(SharedPrefKeys.USER_FIRST_NAME);

  Future<void> setUserLastName(String userName) async =>
      await _preferences?.setString(SharedPrefKeys.USER_LAST_NAME, userName);

  String ? get userLastName =>
      _preferences?.getString(SharedPrefKeys.USER_LAST_NAME);

  Future<void> setUserEmail(String userEmail) async =>
      await _preferences?.setString(SharedPrefKeys.USER_EMAIL, userEmail);

  String ? get userEmail => _preferences?.getString(SharedPrefKeys.USER_EMAIL);

  Future<void> setUserToken(String userToken) async =>
      await _preferences?.setString(SharedPrefKeys.USER_TOKEN, userToken);

  String ? get userToken => _preferences?.getString(SharedPrefKeys.USER_TOKEN);

  Future<void> logoutUser() async {
    _preferences?.remove(SharedPrefKeys.USER_ID);
    _preferences?.remove(SharedPrefKeys.USER_FIRST_NAME);
    _preferences?.remove(SharedPrefKeys.USER_LAST_NAME);
    _preferences?.remove(SharedPrefKeys.USER_EMAIL);
    _preferences?.remove(SharedPrefKeys.USER_TOKEN);
  }
}
