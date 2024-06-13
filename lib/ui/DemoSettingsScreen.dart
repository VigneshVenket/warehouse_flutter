
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/ui/language_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../blocs/currency/currency_bloc.dart';
import '../blocs/get_currencies/get_currency_bloc.dart';
import '../blocs/get_languages/get_language_bloc.dart';
import '../blocs/language/language_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../constants/app_config.dart';
import '../main.dart';
import '../tweaks/app_localization.dart';

class DemoSettingsScreen extends StatefulWidget {
  const DemoSettingsScreen({super.key});
  @override
  _DemoSettingsScreenState createState() => _DemoSettingsScreenState();
}

class _DemoSettingsScreenState extends State<DemoSettingsScreen> {
  late GetLanguageBloc languageBloc;
  late GetCurrenciesBloc currencyBloc;
  @override
  void initState() {
    super.initState();
    languageBloc = BlocProvider.of<GetLanguageBloc>(context);
    languageBloc.add(const GetLanguages());
    currencyBloc = BlocProvider.of<GetCurrenciesBloc>(context);
    currencyBloc.add(const GetCurrencies());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
            AppLocalizations.of(context)!.translate("Settings")!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child:Column(
            children: [
              const SizedBox(height: 15,),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black26,
                child: const Center(child: Text("Change App Theme",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
                ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                     // crossAxisSpacing: 0.1,
                      mainAxisExtent: 75,
                     // mainAxisSpacing: 0.1,
                      childAspectRatio: 0.1
                      ),
                  itemCount: AppData.colors.length,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: (){
                        setState(() {
                          AppData.settingsResponse?.setKeyValue(
                              SettingsResponse.BANNER_STYLE,
                              (index + 1).toString());
                          BlocProvider.of<ThemeBloc>(context)
                          .add(ThemeColorChanged(index),);
                        });

                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: (AppData.settingsResponse?.getKeyValue(
                                  SettingsResponse.BANNER_STYLE) ==
                                  (index + 1).toString())
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                              width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: AppData.colors[index],
                          )
                          // child: Container(
                          //   child:
                          //   Text(item),
                          // ),
                        ),
                      ),
                    );
                  },
                ),
              ),



          // ListView.separated(
          //     separatorBuilder: (context, index) {
          //       return Divider(
          //         height: 1,
          //         color: Theme.of(context).primaryColor,
          //       );
          //     },
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: AppData.colors!.length,
          //     itemBuilder: (context, index) => ListTile(
          //       onTap: () => BlocProvider.of<ThemeBloc>(context)
          //           .add(ThemeColorChanged(index)),
          //       title: Text(
          //         // "Color"
          //         AppLocalizations.of(context)!.translate("Color")!
          //             + index.toString(), style: const TextStyle(fontSize: 16),),
          //       dense: true,
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          //       visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
          //     ),
          //   ),
          //   Divider(
          //     height: 1,
          //     color: Theme.of(context).primaryColor,
          //   ),
              const SizedBox(height: 15,),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black26,
                child: const Center(child: Text("Choose Color Mode",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                ),
              ),
              const SizedBox(height: 15,),

              // ToggleButtons(
              //     children:[
              //       Icon(Icons.edit,size: 200),
              //       Icon(Icons.edit,size: 200,),
              //     ],
              //   onPressed: (int index){
              //       setState((){
              //         _Selections[index] = !_Selections[index];
              //       });
              //   },
              //   isSelected: _Selections,
              //   color: Colors.green,
              //   selectedColor: Colors.red,
              //   fillColor: Colors.blueGrey,
              // ),

              // ToggleSwitch(
              //   minWidth: double.infinity,
              //   minHeight: 120,
              //   fontSize: 16,
              //   initialLabelIndex: 0,
              //   totalSwitches: 2,
              //   labels: ['Dark','Light'],
              //   activeBgColor: [Colors.green],
              //   activeFgColor: Colors.white,
              //   inactiveBgColor: Colors.grey,
              //   inactiveFgColor: Colors.grey[900],
              //   onToggle: (index) {
              //     print('switched to: $index');
              //   },
              // ),


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

            const SizedBox(height: 15,),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black26,
                child:const Center(child: Text("Multi Language",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder(
                  bloc: languageBloc,
                  builder: (BuildContext context, state1) {
                    if (state1 is GetLanguageLoaded) {
                      return BlocBuilder<LanguageBloc, LanguageState>(
                        builder: (context, state) => Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              width: double.maxFinite,
                              color:  Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor :  Colors.white,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      BlocProvider.of<LanguageBloc>(context).add(
                                          LanguageSelected(state1
                                              .languageResponse.data![index]));
                                      RestartWidget.restartApp(context);
                                    },
                                    child: state1.languageResponse.data![index].code?.toLowerCase().trim() == state.languageData.code?.toLowerCase().trim()  ?
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      color: Theme.of(context).primaryColor,
                                      child: Text("${state1.languageResponse.data![index].languageName} (${state1.languageResponse.data![index].code})",style: const TextStyle(color: Colors.white),),
                                    ): Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text("${state1.languageResponse.data![index].languageName} (${state1.languageResponse.data![index].code})"),
                                    ),
                                  );
                                },
                                itemCount: state1.languageResponse.data?.length,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state1 is GetLanguageError) {
                      return Text(state1.error);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black26,
                child: const Center(child: Text("Multi Currency",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder(
                  bloc: currencyBloc,
                  builder: (BuildContext context, state1) {
                    if (state1 is GetCurrencyLoaded) {
                      return BlocBuilder<CurrencyBloc, CurrencyState>(
                        builder: (context, state) => Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              width: double.maxFinite,
                              color:  Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor :  Colors.white,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      BlocProvider.of<CurrencyBloc>(context).add(
                                          CurrencySelected(state1
                                              .currenciesResponse.data![index]));
                                      RestartWidget.restartApp(context);
                                    },
                                    child: state1.currenciesResponse.data![index].currencyId == state.currency.currencyId ?
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      color: Theme.of(context).primaryColor,
                                      child: Text("${state1.currenciesResponse.data![index].title} (${state1.currenciesResponse.data![index].code})",style: const TextStyle(color: Colors.white),),
                                    ): Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text("${state1.currenciesResponse.data![index].title} (${state1.currenciesResponse.data![index].code})"),
                                    ),
                                  );
                                },
                                itemCount: state1.currenciesResponse.data?.length,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state1 is GetLanguageError) {
                      return Text(state1.error);
                    } else {
                      return  Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black26,
                child: const Center(child: Text("Home Page Styles",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: 300,
                      childAspectRatio: 0.5),
                  itemCount: AppData.itemss.length,
                  itemBuilder: (BuildContext context, index) {
                  //  final item =itemss[index];
                    return InkWell(
                      onTap: (){
                     setState(() {
                     AppData.settingsResponse?.setKeyValue(
                     SettingsResponse.HOME_STYLE,
                     (index + 1).toString());
            });

                      },
                  child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: (AppData.settingsResponse?.getKeyValue(
                                                SettingsResponse.HOME_STYLE) ==
                                            (index + 1).toString())
                                        ? Theme.of(context).colorScheme.secondary
                                        : Colors.transparent,
                                    width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                      child:
                                    //  Image.asset("assets/images/card_newarrivals.png",fit: BoxFit.cover,),
                                      Image.asset(
                                       AppData.itemss[index],fit: BoxFit.cover,
                                        //AppLocalizations.of(context)!.translate("Style")!
                                            //.toString(),
                                  ),
                                  ),



                      // child: Container(
                      //   child:
                      //   Text(item),
                      // ),
                    ),
                  ),
                    );
                  },
                ),
              ),



              // GridView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 5,
              //       crossAxisSpacing: 10.0,
              //       childAspectRatio: 1),
              //   itemCount: 9,
              //   itemBuilder: (BuildContext context, int index) {
              //     return GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           AppData.settingsResponse?.setKeyValue(
              //               SettingsResponse.HOME_STYLE,
              //               (index + 1).toString());
              //         });
              //       },
              //        child: Card(
              //           shape: RoundedRectangleBorder(
              //             side: BorderSide(
              //                 color: (AppData.settingsResponse?.getKeyValue(
              //                             SettingsResponse.HOME_STYLE) ==
              //                         (index + 1).toString())
              //                     ? Theme.of(context).colorScheme.secondary
              //                     : Colors.transparent,
              //                 width: 1),
              //             borderRadius: BorderRadius.circular(6),
              //           ),
              //           child: Padding(
              //               padding: const EdgeInsets.all(4.0),
              //               child: Center(
              //                   child:
              //                 //  Image.asset("assets/images/card_newarrivals.png",fit: BoxFit.cover,),
              //                   Text(
              //                     AppLocalizations.of(context)!.translate("Style")!
              //                         + (index + 1).toString(),
              //                     textAlign: TextAlign.center,
              //                 style: const TextStyle(fontSize: 12),
              //
              //               ),
              //               ),
              //           ),
              //         ),
              //
              //     );
              //   },
              // ),
              const SizedBox(height: 15,),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black26,
                child: const Center(child: Text("Categories Styles",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.5),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          AppData.settingsResponse?.setKeyValue(
                              SettingsResponse.CATEGORY_STYLE,
                              (index + 1).toString());
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: (AppData.settingsResponse?.getKeyValue(
                                          SettingsResponse.CATEGORY_STYLE) ==
                                      (index + 1).toString())
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                              width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                                child: Image.asset(
                                 AppData.category[index],fit: BoxFit.cover,
                                ),
                            ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(height: 15,),
              // Container(
              //   height: 50,
              //   width: double.infinity,
              //   color: Colors.black26,
              //   child: Center(child: Text("Banners Styles",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 15
              //     ),
              //   ),
              //   ),
              // ),
              // SizedBox(height: 15,),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GridView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 5.0,
              //         childAspectRatio: 1),
              //     itemCount: 6,
              //     itemBuilder: (BuildContext context, int index) {
              //       return GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             AppData.settingsResponse?.setKeyValue(
              //                 SettingsResponse.BANNER_STYLE,
              //                 (index + 1).toString());
              //           });
              //         },
              //         child: Card(
              //           shape: RoundedRectangleBorder(
              //             side: BorderSide(
              //                 color: (AppData.settingsResponse?.getKeyValue(
              //                     SettingsResponse.BANNER_STYLE) ==
              //                     (index + 1).toString())
              //                     ? Theme.of(context).colorScheme.secondary
              //                     : Colors.transparent,
              //                 width: 1),
              //             borderRadius: BorderRadius.circular(6),
              //           ),
              //           child: Padding(
              //               padding: const EdgeInsets.all(4.0),
              //               child: Center(
              //                   child: Text(
              //                     AppLocalizations.of(context)!.translate("Style")!
              //                         + (index + 1).toString(),
              //                     textAlign: TextAlign.center,
              //                     style: const TextStyle(fontSize: 12),
              //                   ))),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(height: 15,),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black26,
                child: const Center(child: Text("Product Card Styles",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: 200,
                      childAspectRatio: 0.5),
                  itemCount: 27,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          AppData.settingsResponse?.setKeyValue(
                              SettingsResponse.CARD_STYLE,
                              (index + 1).toString());
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: (AppData.settingsResponse?.getKeyValue(
                                          SettingsResponse.CARD_STYLE) ==
                                      (index + 1).toString())
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                              width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                                child:Image.asset(
                                  AppData.card[index],fit: BoxFit.cover,
                                ),
                            ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
        ),
    ),
    );
  }
}

