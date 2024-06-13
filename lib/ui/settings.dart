import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/get_currencies/get_currency_bloc.dart';
import 'package:flutter_kundol/blocs/get_languages/get_language_bloc.dart';
import 'package:flutter_kundol/blocs/page/page_bloc.dart';
import 'package:flutter_kundol/blocs/theme/theme_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/repos/get_currency_repo.dart';
import 'package:flutter_kundol/repos/get_language_repo.dart';
import 'package:flutter_kundol/repos/pages_repo.dart';
import 'package:flutter_kundol/ui/content_screen.dart';
import 'package:flutter_kundol/ui/currencies_screen.dart';
import 'package:flutter_kundol/ui/language_screen.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share/share.dart';

import '../constants/app_config.dart';
import '../tweaks/app_localization.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,

      appBar: AppConfig.APP_BAR_COLOR == 2 ?
      AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Theme.of(context).brightness ==
              Brightness.dark
              ? Colors.white
              : Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.translate("Settings")!,
          style: TextStyle( color: Theme.of(context).brightness ==
              Brightness.dark
              ? Colors.white
              : Colors.black,),),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0.0,
      ):
          AppConfig.APP_BAR_COLOR == 1 ?
      AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Theme.of(context).brightness ==
              Brightness.dark
              ? Colors.black
              : Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.translate("Settings")!,
          style: TextStyle( color: Theme.of(context).brightness ==
              Brightness.dark
              ? Colors.black
              : Colors.white,),),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
        elevation: 0.0,
      ):
          AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).brightness ==
                  Brightness.dark
                  ? Colors.white
                  : Colors.black,),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Settings",style: TextStyle( color: Theme.of(context).brightness ==
                Brightness.dark
                ? Colors.white
                : Colors.black,),),
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0,
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: AppConfig.APP_BAR_COLOR == 2 ?
              BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 0.0), // set border width
                borderRadius: const BorderRadius.all(
                    Radius.circular(
                        15.0)), // set rounded corner radius
              ):
              BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                    width: 0.0), // set border width
                borderRadius: const BorderRadius.all(
                    Radius.circular(
                        15.0)), // set rounded corner radius
              ),
              margin: const EdgeInsets.all(15),
              child: ClipRRect(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(15.0),
                // ),
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                    width: double.maxFinite,
                    color:  Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor :  Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                create: (BuildContext context) {
                                                  return GetLanguageBloc(RealGetLanguageRepo());
                                                },
                                                child: LanguagesScreen())));
                                  },
                                  child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
                                    AppLocalizations.of(context)!.translate("Languages")!,
                                    style: const TextStyle(fontSize: 16),))),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                create: (BuildContext context) {
                                                  return GetCurrenciesBloc(RealGetCurrencyRepo());
                                                },
                                                child: CurrenciesScreen())));
                                  },
                                  child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
                                    AppLocalizations.of(context)!.translate("Currencies")!,
                                    style: const TextStyle(fontSize: 16),))),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              BlocBuilder<ThemeBloc, ThemeState>(
                                builder: (context, state) => SwitchListTile(
                                  activeColor: AppConfig.APP_BAR_COLOR == 2 ?
                                  Colors.black:
                                  Theme.of(context).primaryColor,
                                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  title:   Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
                                    AppLocalizations.of(context)!.translate("Dark Mode")!,
                                    style: const TextStyle(fontSize: 16),)),
                                  value: state.themeData.brightness == Brightness.dark
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    BlocProvider.of<ThemeBloc>(context)
                                        .add(ThemeModeChanged(value));
                                  },
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              // ListView.separated(
                              //   separatorBuilder: (context, index) {
                              //     return Divider(
                              //       height: 1,
                              //       color: Theme.of(context).primaryColor,
                              //     );
                              //   },
                              //   shrinkWrap: true,
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   itemCount: AppData.colors!.length,
                              //   itemBuilder: (context, index) => ListTile(
                              //     onTap: () => BlocProvider.of<ThemeBloc>(context)
                              //         .add(ThemeColorChanged(index)),
                              //     title: Text(
                              //       // "Color"
                              //       AppLocalizations.of(context)!.translate("Color")!
                              //           + index.toString(), style: const TextStyle(fontSize: 16),),
                              //     dense: true,
                              //     contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                              //     visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
                              //   ),
                              // ),
                              // Divider(
                              //   height: 1,
                              //   color: Theme.of(context).primaryColor,
                              // ),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                              create: (BuildContext context) {
                                                return GetPageBloc(RealPageRepo());
                                              },
                                              child:   ContentScreen(1)),
                                        ));
                                  },
                                  child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
                                    AppLocalizations.of(context)!.translate("About Us")!,
                                    style: const TextStyle(fontSize: 16),))),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                              create: (BuildContext context) {
                                                return GetPageBloc(RealPageRepo());
                                              },
                                              child:  ContentScreen(2)),
                                        ));
                                  },
                                  child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
                                    AppLocalizations.of(context)!.translate("Refund Policy")!,
                                    style: const TextStyle(fontSize: 16),))),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                              create: (BuildContext context) {
                                                return GetPageBloc(RealPageRepo());
                                              },
                                              child: ContentScreen(3)),
                                        ));
                                  },
                                  child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
                                    AppLocalizations.of(context)!.translate("Privacy Policy")!,
                                    style: const TextStyle(fontSize: 16),))),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                              create: (BuildContext context) {
                                                return GetPageBloc(RealPageRepo());
                                              },
                                              child:  ContentScreen(4)),
                                        ));
                                  },
    child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
    AppLocalizations.of(context)!.translate("Terms and Condition")!,
    style: const TextStyle(fontSize: 16),))),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              GestureDetector(
                                  onTap: () async{
                                    await Share.share(
                                        AppLocalizations.of(context)!.translate( "Hi there, please check this app. i think you will love it. ")!
                                    );
                                  },
    child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
    AppLocalizations.of(context)!.translate("Share App")!,
    style: const TextStyle(fontSize: 16),))),
                              Divider(
                                height: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              GestureDetector(
                                  onTap: () async{
                                    final InAppReview inAppReview = InAppReview.instance;

                                    if (await inAppReview.isAvailable()) {
                                      inAppReview.openStoreListing(appStoreId: "storeid");
                                    }
                                  },
                                  child: Padding( padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Text(
                                  AppLocalizations.of(context)!.translate("Rate My App")!,
                                  style: const TextStyle(fontSize: 16),))),
                            ],
                          )
                      ),
                    )
                ),
              ),
            ),
            // BlocConsumer<AuthBloc, AuthState>(
            //   builder: (context, state) => Container(
            //     margin: const EdgeInsets.all(15),
            //     height: 40.0,
            //     width: double.maxFinite,
            //     child: ElevatedButton(
            //         style: ButtonStyle(
            //           //  backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),
            //             backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
            //             //  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffCDD2D3)),
            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //                 RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(40.0),
            //                 )
            //             )
            //         ),
            //         onPressed: () {
            //           BlocProvider.of<AuthBloc>(context).add(const PerformLogout());
            //         },
            //         child:
            //         Text(
            //           AppLocalizations.of(context)!.translate("Sign out")!,
            //           style: TextStyle(fontSize: 16,color: Theme.of(context).brightness ==
            //               Brightness.dark
            //               ? Colors.black
            //               : Colors.white,),
            //         ),
            //     ),
            //   ),
            //   listener: (context, state) {
            //     if (state is UnAuthenticated) {
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
            //           AppLocalizations.of(context)!.translate("logout successful")!
            //       )));
            //       Navigator.pop(context);
            //     }
            //   },
            // ),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) => Container(
                margin: EdgeInsets.all(15),
                height: 40.0,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: AppConfig.APP_BAR_COLOR == 2 ?
                    ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                        //backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),

                            )
                        )
                    ):
                    ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                        //backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            )
                        )
                    ),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(PerformLogout());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate("Sign out")!,
                      style: TextStyle(fontSize: 16),)),
              ),
              listener: (context, state) {
                if (state is UnAuthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      AppLocalizations.of(context)!.translate("logout successful")!
                  )));
                  Navigator.pop(context);
                }
              },
            ),
            // ListTile(
            //   title: Text("Languages"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => BlocProvider(
            //                 create: (BuildContext context) {
            //                   return GetLanguageBloc(RealGetLanguageRepo());
            //                 },
            //                 child: LanguagesScreen())));
            //   },
            // ),
            // ListTile(
            //   title: Text("Currencies"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => BlocProvider(
            //                 create: (BuildContext context) {
            //                   return GetCurrenciesBloc(RealGetCurrencyRepo());
            //                 },
            //                 child: CurrenciesScreen())));
            //   },
            // ),
/*
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => BlocProvider.of<LanguageBloc>(context)
                      .add(LanguageSelected(index)),
                  title: Text(AppData.languages[index].languageCode),
                );
              },
              itemCount: AppData.languages.length,
            ),
*/
            // BlocBuilder<ThemeBloc, ThemeState>(
            //   builder: (context, state) => SwitchListTile(
            //     title: Text("Dark Mode"),
            //     value: state.themeData.brightness == Brightness.dark
            //         ? true
            //         : false,
            //     onChanged: (value) {
            //       BlocProvider.of<ThemeBloc>(context)
            //           .add(ThemeModeChanged(value));
            //     },
            //   ),
            // ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: AppData.colors.length,
            //   itemBuilder: (context, index) => ListTile(
            //     onTap: () => BlocProvider.of<ThemeBloc>(context)
            //         .add(ThemeColorChanged(index)),
            //     title: Text("Color " + index.toString()),
            //   ),
            // ),
            // BlocConsumer<AuthBloc, AuthState>(
            //   builder: (context, state) => ListTile(
            //     title: Text("Logout"),
            //     onTap: () {
            //       BlocProvider.of<AuthBloc>(context).add(PerformLogout());
            //     },
            //   ),
            //   listener: (context, state) {
            //     if (state is UnAuthenticated) {
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("logout successful")));
            //       Navigator.pop(context);
            //     }
            //   },
            // ),
            // ListTile(
            //   title: Text("About us"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => BlocProvider(
            //               create: (BuildContext context) {
            //                 return GetPageBloc(RealPageRepo());
            //               },
            //               child: ContentScreen(1)),
            //         ));
            //   },
            // ),
            // ListTile(
            //   title: Text("Refund Policy"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => BlocProvider(
            //               create: (BuildContext context) {
            //                 return GetPageBloc(RealPageRepo());
            //               },
            //               child: ContentScreen(2)),
            //         ));
            //   },
            // ),
            // ListTile(
            //   title: Text("Privacy Policy"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => BlocProvider(
            //               create: (BuildContext context) {
            //                 return GetPageBloc(RealPageRepo());
            //               },
            //               child: ContentScreen(3)),
            //         ));
            //   },
            // ),
            // ListTile(
            //   title: Text("Terms and Conditions"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => BlocProvider(
            //               create: (BuildContext context) {
            //                 return GetPageBloc(RealPageRepo());
            //               },
            //               child: ContentScreen(4)),
            //         ));
            //   },
            // ),
            // ListTile(
            //   title: Text("Share App"),
            //   onTap: () async {
            //     await Share.share(
            //         "Hi there, please check this app. i think you will love it. ");
            //   },
            // ),
            // ListTile(
            //   title: Text("Rate My App"),
            //   onTap: () async {
            //     final InAppReview inAppReview = InAppReview.instance;
            //
            //     if (await inAppReview.isAvailable()) {
            //       inAppReview.openStoreListing(appStoreId: "storeid");
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
