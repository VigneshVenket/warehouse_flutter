import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/language/language_bloc.dart';
import 'package:flutter_kundol/blocs/currency/currency_bloc.dart';
import 'package:flutter_kundol/blocs/server_settings/server_settings_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/currency_date.dart';
import 'package:flutter_kundol/models/language_data.dart';
import 'package:flutter_kundol/models/user.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:flutter_kundol/ui/intro_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ServerSettingsBloc serverSettingsBloc;
  bool isNewUser = false;
  @override
  void initState() {
    super.initState();

    // checkIfUserLoggedIn();
    _init();
    serverSettingsBloc = BlocProvider.of<ServerSettingsBloc>(context);
    serverSettingsBloc.add(const GetServerSettings());
  }

  Future<void> _init() async {
    isNewUser = await checkIfUserLoggedIn();

    serverSettingsBloc = BlocProvider.of<ServerSettingsBloc>(context);
    serverSettingsBloc.add(const GetServerSettings());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServerSettingsBloc, ServerSettingsState>(
      listener: (context, state) {
        if (state is ServerSettingsLoaded) {
          AppData.settingsResponse = state.settingsResponse;

          AppData.settingsResponse?.setKeyValue(
              SettingsResponse.HOME_STYLE,
              AppData.settingsResponse!
                  .getKeyValue(SettingsResponse.HOME_STYLE)
                  .replaceAll(RegExp(r'[^0-9]'), ''));
          AppData.settingsResponse?.setKeyValue(
              SettingsResponse.CATEGORY_STYLE,
              AppData.settingsResponse!
                  .getKeyValue(SettingsResponse.CATEGORY_STYLE)
                  .replaceAll(RegExp(r'[^0-9]'), ''));
          AppData.settingsResponse?.setKeyValue(
              SettingsResponse.BANNER_STYLE,
              AppData.settingsResponse!
                  .getKeyValue(SettingsResponse.BANNER_STYLE)
                  .replaceAll(RegExp(r'[^0-9]'), ''));
          AppData.settingsResponse?.setKeyValue(
              SettingsResponse.CARD_STYLE,
              AppData.settingsResponse!
                  .getKeyValue(SettingsResponse.CARD_STYLE)
                  .replaceAll(RegExp(r'[^0-9]'), ''));

          CurrencyData currencyData = CurrencyData();

          currencyData.title = AppData.settingsResponse!
              .getKeyValue(SettingsResponse.CURRENCY_CODE)
              .trim();
          currencyData.currencyId = int.parse(AppData.settingsResponse!
              .getKeyValue(SettingsResponse.CURRENCY_ID)
              .toString());
          currencyData.code = AppData.settingsResponse!
              .getKeyValue(SettingsResponse.CURRENCY_SYMBOL)
              .trim();

          BlocProvider.of<CurrencyBloc>(context)
              .add(CurrencyLoadServer(currencyData));

          LanguageData languageData = LanguageData();

          languageData.languageName = AppData.settingsResponse
              ?.getKeyValue(SettingsResponse.LANGUAGE_CODE)
              .toUpperCase()
              .trim();
          languageData.id = int.parse(AppData.settingsResponse!
              .getKeyValue(SettingsResponse.LANGUAGE_ID)
              .toString());
          languageData.code = AppData.settingsResponse
              ?.getKeyValue(SettingsResponse.LANGUAGE_CODE)
              .toLowerCase()
              .trim();

          BlocProvider.of<LanguageBloc>(context)
              .add(LanguageLoadServer(languageData));
          Future.microtask(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      isNewUser ? const Intro_Screen() : MainScreen(),
                ),
              ));


          // Future.microtask(() => Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(
          //         builder: (BuildContext context) =>Intro_Screen())));
        } else if (state is ServerSettingsError) {
          showSnackbar(context, state.error);
        }
      },
      child: ScreenUi(),
    );
  }

  void showSnackbar(context, String error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(error,style: GoogleFonts.gothicA1(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),),
          duration: const Duration(days: 1),
        ))
        .closed
        .then((reason) {
      if (reason == SnackBarClosedReason.swipe) showSnackbar(context, error);
    });
  }

  Future<bool> checkIfUserLoggedIn() async {
    final sharedPrefService = await SharedPreferencesService.instance;
    int? userId = sharedPrefService.userId;

    if (userId != null) {
      User user = User();
      user.id = userId;
      user.firstName = sharedPrefService.userFirstName;
      user.lastName = sharedPrefService.userLastName;
      user.email = sharedPrefService.userEmail;
      user.token = sharedPrefService.userToken;
      AppData.user = user;
      AppData.accessToken = user.token;
      BlocProvider.of<AuthBloc>(context).add(PerformAutoLogin(user));

      // Existing user
      return false;
    }

    // New user
    setState(() {
      isNewUser = true;
    });

    return true;
  }

//   Future<void> checkIfUserLoggedIn() async {
//     final sharedPrefService = await SharedPreferencesService.instance;
//     int? userId = sharedPrefService.userId;
//     if (userId != null) {
//       User user = User();
//       user.id = userId;
//       user.firstName = sharedPrefService.userFirstName;
//       user.lastName = sharedPrefService.userLastName;
//       user.email = sharedPrefService.userEmail;
//       user.token = sharedPrefService.userToken;
//       AppData.user = user;
//       AppData.accessToken = user.token;
//       BlocProvider.of<AuthBloc>(context).add(PerformAutoLogin(user));
//     }
//   }
}

class ScreenUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromRGBO(0, 0, 0, 1)
              : const Color.fromRGBO(255, 255, 255, 1),
          body: Theme.of(context).brightness == Brightness.dark
              ? Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:BorderRadius.circular(15),
                              child: Container(
                                width: 90.0,
                                height: 70.0,
                                child: Image.asset(
                                  "assets/images/livekart_logo.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Text(
                              "Shopping the way you like it!",
                              style: GoogleFonts.gothicA1(
                                  color: const Color.fromRGBO(160, 160, 160, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
// Container(
//   child: Column(
//     children: [
//       Padding(
//         padding: EdgeInsets.only(bottom: 25),
//         child: CircularProgressIndicator(),
//       ),
//       Padding(
//         padding: EdgeInsets.only(bottom: 50),
//         child: Text("By Themes Coder"),
//       ),
//     ],
//   ),
// ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:BorderRadius.circular(15),
                              child: Container(
                                width: 90.0,
                                height: 70.0,
                                child: Image.asset(
                                  "assets/images/livekart_logo.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              "Shopping the way you like it!",
                              style: GoogleFonts.gothicA1(
                                  color: const Color.fromRGBO(112, 112, 112, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
// Container(
//   child: Column(
//     children: [
//       Padding(
//         padding: EdgeInsets.only(bottom: 25),
//         child: CircularProgressIndicator(),
//       ),
//       Padding(
//         padding: EdgeInsets.only(bottom: 50),
//         child: Text("By Themes Coder"),
//       ),
//     ],
//   ),
// ),
                    ],
                  ),
                )),
    );
  }
}
