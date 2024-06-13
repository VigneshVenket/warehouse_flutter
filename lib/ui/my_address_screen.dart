import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/add_addressbook/add_addressbook_bloc.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/ui/add_addressbook_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/cityy/city_bloc.dart';
import '../blocs/countryy/country_bloc.dart';
import '../blocs/statee/statee_bloc.dart';
import '../constants/app_config.dart';
import '../constants/app_constants.dart';
import '../repos/cityy_repo.dart';
import '../repos/countries_repo.dart';
import '../repos/countryy_repo.dart';
import '../repos/statee_repo.dart';
import '../tweaks/app_localization.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen();

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<MyAddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
        // appBar: AppConfig.APP_BAR_COLOR == 2 ?
        // AppBar(
        //   centerTitle: true,
        //   iconTheme: IconThemeData(
        //     color:AppConfig.APP_BAR_COLOR == 2 ?
        //     Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
        //     Colors.white,
        //   ),
        //   backgroundColor:Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
        //   title: Text(
        //     AppLocalizations.of(context)!.translate("Address book")!,
        //     style: TextStyle(
        //       color:AppConfig.APP_BAR_COLOR == 2 ?
        //       Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
        //       Colors.white,
        //     ),),
        //   elevation: 0.0,
        // ):
        //     AppConfig.APP_BAR_COLOR == 1 ?
        // AppBar(
        //   centerTitle: true,
        //   iconTheme: IconThemeData(
        //     color:AppConfig.APP_BAR_COLOR == 1 ?
        //     Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
        //     Colors.white,
        //   ),
        //   backgroundColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
        //   title: Text(
        //     AppLocalizations.of(context)!.translate("Address book")!,
        //     style: TextStyle(
        //       color:AppConfig.APP_BAR_COLOR == 1 ?
        //       Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
        //       Colors.white,
        //     ),),
        //   elevation: 0.0,
        // ):
        // AppConfig.APP_BAR_COLOR == 3 ?
        // AppBar(
        //   centerTitle: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).brightness ==
        //         Brightness.dark
        //         ? Colors.white
        //         : Colors.black,),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   iconTheme: Theme.of(context).iconTheme,
        //   backgroundColor: Theme.of(context).cardColor,
        //   title: Text("Address book",
        //       style: Theme.of(context).textTheme.titleLarge),
        //   elevation: 0.0,
        // ):null,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(0, 0, 0, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,
                color:Theme.of(context).brightness ==
                    Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color.fromRGBO(18, 18, 18, 1)
                : Color.fromRGBO(255, 255, 255, 1),
            title: Text(
              "My Address",
              style: GoogleFonts.gothicA1(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(18, 18, 18, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            )),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<AddressBloc, AddressState>(
                  bloc: BlocProvider.of<AddressBloc>(context),
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(255, 76, 59, 1),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(18, 18, 18, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                        ),
                      );
                    } else if (state is AddressLoaded) {
                      if (state.addressData.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.addressData.length,
                          itemBuilder: (context, index) =>
                              //   Container(
                              // margin: const EdgeInsets.only(left: 0,right: 0,top: 20,bottom: 0),
                              // child: ClipRRect(
                              //   borderRadius: BorderRadius.circular(
                              //       AppStyles.CARD_RADIUS),
                              //   child: Container(
                              //     padding: const EdgeInsets.only(top: 10),
                              //     decoration: AppConfig.APP_BAR_COLOR == 2 ?
                              //     BoxDecoration(
                              //       border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                              //       borderRadius: const BorderRadius.all(
                              //           Radius.circular( AppStyles.CARD_RADIUS) //                 <--- border radius here
                              //       ),
                              //     ):
                              //     BoxDecoration(
                              //       border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                              //       borderRadius: const BorderRadius.all(
                              //           Radius.circular( AppStyles.CARD_RADIUS) //                 <--- border radius here
                              //       ),
                              //     ),
                              //     child:
                              Column(
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                child: ListTile(
                                  onTap: () {
                                    // if (state.addressData[index].defaultAddress != 1) {
                                    if (state.addressData[index]
                                            .defaultAddress !=
                                        1) {
                                      BlocProvider.of<AddressBloc>(context).add(
                                          SetDefaultAddress(
                                              state.addressData[index].id!,
                                              state.addressData[index].customer!
                                                  .customerFirstName!,
                                              state.addressData[index].customer!
                                                  .customerLastName!,
                                              state.addressData[index].gender!,
                                              state.addressData[index].company!,
                                              state.addressData[index]
                                                  .streetAddress!,
                                              state.addressData[index].suburb!,
                                              state
                                                  .addressData[index].postcode!,
                                              state.addressData[index].dob!,
                                              state.addressData[index]
                                                  .countryId!.countryId!,
                                              state.addressData[index].stateId!
                                                  .countryId!,
                                              // state.addressData[index].city!.countryId.toString(),
                                              state.addressData[index].city!,
                                              state.addressData[index]
                                                      .lattitude ??
                                                  "123",
                                              state.addressData[index]
                                                      .longitude ??
                                                  "123",
                                              state.addressData[index]
                                                          .defaultAddress ==
                                                      1
                                                  ? 0
                                                  : 1,
                                              state.addressData[index].phone!));
                                    }
                                    // }
                                  },
                                  // enabled: true,
                                  // isThreeLine: true,
                                  leading:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(29, 29, 29, 1),
                                          ),
                                          child: Image.asset(
                                              "assets/images/Icon address dark.png"),
                                        )
                                      : Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromRGBO(
                                                240, 240, 240, 1),
                                          ),
                                          child: Image.asset(
                                              "assets/images/Icon addresss light.png"),
                                        ),
                                  trailing: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                        create: (context) =>
                                                            AddAddressBookBloc(
                                                                RealAddressRepo())),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            CountryyBloc(
                                                                RealCountryyRepo())),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            StateeBloc(
                                                                RealStateeRepo())),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            CityyBloc(
                                                                RealCityyRepo())),
                                                  ],
                                                  child: AddAddressBookScreen(
                                                      state.addressData[index]),
                                                );
                                              },
                                            ));
                                          },
                                          child: Image.asset(
                                              "assets/images/Button - address dark.png"),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                        create: (context) =>
                                                            AddAddressBookBloc(
                                                                RealAddressRepo())),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            CountryyBloc(
                                                                RealCountryyRepo())),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            StateeBloc(
                                                                RealStateeRepo())),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            CityyBloc(
                                                                RealCityyRepo())),
                                                  ],
                                                  child: AddAddressBookScreen(
                                                      state.addressData[index]),
                                                );
                                              },
                                            ));
                                          },
                                          child: Image.asset(
                                              "assets/images/Button - address light.png"),
                                        ),

                                  // (state.addressData[index].defaultAddress == 1)
                                  //     ? const Icon(Icons.check)
                                  //     : null,
                                  // title: Text("${state.addressData[index].customer
                                  //         ?.customerFirstName} ${state.addressData[index].customer
                                  //         ?.customerLastName}",style: TextStyle(
                                  //      color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                                  //          Color.fromRGBO(0, 0, 0, 1),
                                  //   fontSize: 16,
                                  //   fontWeight: FontWeight.w600
                                  // ),),
                                  title: Text(
                                    state.addressData[index].streetAddress!,
                                    style: GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromRGBO(160, 160, 160, 1)
                                          : Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),

                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: <Widget>[
                                  //   //  Text(state.addressData[index].city!),
                                  //     Text(state.addressData[index].streetAddress!),
                                  //     Row(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         IconButton(
                                  //             onPressed: () {
                                  //               BlocProvider.of<AddressBloc>(context)
                                  //                   .add(DeleteAddress(
                                  //                       state.addressData[index].id!));
                                  //             },
                                  //             icon: const Icon(Icons.delete)),
                                  //         const SizedBox(width: 12.0),
                                  //         IconButton(
                                  //             onPressed: () {
                                  //               Navigator.push(context,
                                  //                   MaterialPageRoute(
                                  //                      builder: (context) {
                                  //                   return MultiBlocProvider(
                                  //                     providers: [
                                  //                       BlocProvider(
                                  //                           create: (context) =>
                                  //                               AddAddressBookBloc(
                                  //                                   RealAddressRepo())),
                                  //                       BlocProvider(
                                  //                           create: (context) =>
                                  //                               CountryyBloc(RealCountryyRepo())),
                                  //                               BlocProvider(
                                  //                           create: (context) =>
                                  //                               StateeBloc(RealStateeRepo())),
                                  //                               BlocProvider(
                                  //                           create: (context) =>
                                  //                               CityyBloc(RealCityyRepo())),
                                  //                     ],
                                  //                     child: AddAddressBookScreen(
                                  //                         state.addressData[index]),
                                  //                   );
                                  //                 },
                                  //               ));
                                  //             },
                                  //             icon: const Icon(Icons.edit)),
                                  //       ],
                                  //     )
                                  //   ],
                                  // ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  state.addressData[index].defaultAddress == 1
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            width: 70,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Color.fromRGBO(
                                                        29, 29, 29, 1)
                                                    : Color.fromRGBO(
                                                        240, 240, 240, 1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child:
                                                Center(child: Text("Default",
                                                 style: GoogleFonts.gothicA1(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w600,
                                                   color: Theme.of(context).brightness ==
                                                       Brightness.dark
                                                       ? Color.fromRGBO(160, 160, 160, 1)
                                                       : Color.fromRGBO(112, 112, 112, 1),
                                                 ),
                                                )),
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          if (state.addressData[index].defaultAddress == 1) {
                                            AppConstants.showMessage(context,"Default address cannot be deleted",Colors.red);

                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //         content: Text(
                                            //             "Default address cannot be deleted")));
                                          } else {
                                            BlocProvider.of<AddressBloc>(
                                                    context)
                                                .add(DeleteAddress(state
                                                    .addressData[index].id!));
                                          }
                                        },
                                        icon: Icon(Icons.delete,
                                            size: 24,
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Color.fromRGBO(
                                                    200, 200, 200, 1)
                                                : Color.fromRGBO(0, 0, 0, 1))),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: .5,
                                endIndent: 10.0,
                                indent: 4.0,
                              ),
                            ],
                          ),
                          //     ),
                          //   ),
                          // ),
                        );
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 350,
                                  child: Image.asset(
                                      "assets/images/empty address data image.jpg"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "No address data found",
                                  textAlign: TextAlign.center,
                                  style:GoogleFonts.gothicA1(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    } else if (state is AddressError) {
                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(SnackBar(content: Text(state.error)));
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(255, 76, 59, 1),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(18, 18, 18, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  listener: (context, state) {
                    if (state is AddressError) {
                      AppConstants.showMessage(context,state.error,Colors.red);

                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                              create: (context) =>
                                  AddAddressBookBloc(RealAddressRepo())),
                          BlocProvider(
                              create: (context) =>
                                  CountryyBloc(RealCountryyRepo())),
                          BlocProvider(
                              create: (context) =>
                                  StateeBloc(RealStateeRepo())),
                          BlocProvider(
                              create: (context) => CityyBloc(RealCityyRepo())),
                        ],
                        child: AddAddressBookScreen(null),
                      );
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    // margin: const EdgeInsets.only(left: 0,right: 0,top: 12,bottom: 0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppStyles.CARD_RADIUS),
                      child: Container(
                          height: 50,
                          width: double.maxFinite,
                          // decoration: AppConfig.APP_BAR_COLOR == 2 ?
                          // BoxDecoration(
                          //   border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                          //   borderRadius: const BorderRadius.all(
                          //       Radius.circular( AppStyles.CARD_RADIUS) //                 <--- border radius here
                          //   ),
                          // ):
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 76, 59, 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppStyles
                                    .CARD_RADIUS) //                 <--- border radius here
                                ),
                          ),
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "Add New Address",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gothicA1(
                                color: Color.fromRGBO(255, 255, 255, 1,
                                ),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     AppConfig.APP_BAR_COLOR == 2 ?
                          //     Icon(Icons.add,color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,):
                          //     Icon(Icons.add,color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     Text(
                          //         AppLocalizations.of(context)!.translate("Add A New Address")!
                          //     ),
                          //   ],
                          // ),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
