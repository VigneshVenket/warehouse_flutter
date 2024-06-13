import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/order_shipment_cancel/order_shipment_cancel_bloc.dart';
import 'package:flutter_kundol/blocs/payment_methods/payment_methods_bloc.dart';
import 'package:flutter_kundol/repos/payment_methods_repo.dart';
import 'package:flutter_kundol/ui/DemoSettingsScreen.dart';
import 'package:flutter_kundol/ui/add_address_screen.dart';
import 'package:flutter_kundol/ui/edit_profile_screen.dart';
import 'package:flutter_kundol/ui/logout_screen.dart';
import 'package:flutter_kundol/ui/my_address_screen.dart';
import 'package:flutter_kundol/ui/my_orders.dart';
import 'package:flutter_kundol/ui/orders_screen.dart';
import 'package:flutter_kundol/ui/payment_screen.dart';
import 'package:flutter_kundol/ui/profile_screen.dart';
import 'package:flutter_kundol/ui/settings.dart';
import 'package:flutter_kundol/ui/settings_new.dart';
import 'package:flutter_kundol/ui/shipping_screen.dart';
import 'package:flutter_kundol/ui/temp.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/add_address/add_address_bloc.dart';
import '../blocs/address/address_bloc.dart';
import '../blocs/cityy/city_bloc.dart';
import '../blocs/countryy/country_bloc.dart';
import '../blocs/get_currencies/get_currency_bloc.dart';
import '../blocs/get_languages/get_language_bloc.dart';
import '../blocs/orders/orders_bloc.dart';
import '../blocs/profile/update_profile_bloc.dart';
import '../blocs/statee/statee_bloc.dart';
import '../blocs/update_profile_address/update_profile_address_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../constants/app_data.dart';
import '../repos/address_repo.dart';
import '../repos/cityy_repo.dart';
import '../repos/countryy_repo.dart';
import '../repos/get_currency_repo.dart';
import '../repos/get_language_repo.dart';
import '../repos/order_shipment_cancel_repo.dart';
import '../repos/orders_repo.dart';
import '../repos/profile_repo.dart';
import '../repos/statee_repo.dart';
import '../repos/update_profile_address_repo.dart';
import '../repos/user_repo.dart';
import 'change_password_screen .dart';

class MyAccount extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  MyAccount(this.navigateToNext);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  double tabletWidth = 700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(0, 0, 0, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(18, 18, 18, 1)
              : Color.fromRGBO(255, 255, 255, 1),
          title: AppData.user != null
              ?
          Row(
            children: [

            Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 76, 59, 0.1),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Icon(Icons.person,color:Color.fromRGBO(255, 76, 59, 1) ,),
                ),

              SizedBox(width: 10,),

              Text(
                "Hey ! ${AppData.user!.firstName!}",
                style: GoogleFonts.gothicA1(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(18, 18, 18, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ):Row(
            children: [

              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 76, 59, 0.1),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Icon(Icons.person,color:Color.fromRGBO(255, 76, 59, 1) ,),
              ),

              SizedBox(width: 10,),
              Text(
                "Hey ! Guest",
                style: GoogleFonts.gothicA1(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(18, 18, 18, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          // leading: Theme.of(context).brightness == Brightness.dark
          //     ? InkWell(
          //         child: Image.asset("assets/images/Button - Setting (1).png"),
          //         onTap: () {
          //           widget.navigateToNext(SettingsNew());
          //         },
          //       )
          //     : InkWell(
          //         child: Image.asset("assets/images/Button - Setting.png"),
          //         onTap: () {
          //           widget.navigateToNext(SettingsNew());
          //         },
          //       ),
          actions: [
            // IconButton(onPressed: (){}, icon:Icon(Icons.notifications_none_outlined,
            //   size: 26,
            //   color: Theme.of(context).brightness ==
            //       Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0,1),
            // ))
          ],
        ),
        body: AppData.user != null
            ? SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // Padding(
                      //   padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 50,
                      //         height: 50,
                      //         decoration: BoxDecoration(
                      //           color: Color.fromRGBO(255, 76, 59, 0.1),
                      //           borderRadius: BorderRadius.circular(25)
                      //         ),
                      //         child: Icon(Icons.person,color:Color.fromRGBO(255, 76, 59, 1) ,),
                      //       ),
                      //       SizedBox(width: 10,),
                      //       Text("Hey! ${AppData.user!.firstName!}",
                      //           style: GoogleFonts.gothicA1(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w700,
                      //             color: Theme.of(context).brightness == Brightness.dark
                      //                 ? Color.fromRGBO(255, 255, 255, 1)
                      //                 : Color.fromRGBO(0, 0, 0, 1),
                      //           ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Row(
                      //   children: [
                      //     // InkWell(
                      //     //   onTap: () {},
                      //     //   child:
                      //     //   // Container(
                      //     //   //   width: 80,
                      //     //   //   height: 80,
                      //     //   //   decoration: const BoxDecoration(
                      //     //   //     shape: BoxShape.circle,
                      //     //   //     color: Colors.grey,
                      //     //   //   ),
                      //     //   // ),
                      //     // ),
                      //     const SizedBox(
                      //       width: 20,
                      //     ),
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width < 700
                      //           ? 200
                      //           : 580,
                      //       height: 100,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(top: 25.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               "${AppData.user!.firstName!} ${AppData.user!.lastName!}",
                      //               style: TextStyle(
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Theme.of(context).brightness ==
                      //                           Brightness.dark
                      //                       ? Color.fromRGBO(255, 255, 255, 1)
                      //                       : Color.fromRGBO(0, 0, 0, 1)),
                      //             ),
                      //             Text(
                      //               AppData.user!.email!,
                      //               style: TextStyle(
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Theme.of(context).brightness ==
                      //                           Brightness.dark
                      //                       ? Color.fromRGBO(160, 160, 160, 1)
                      //                       : Color.fromRGBO(112, 112, 112, 1)),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //         width: MediaQuery.of(context).size.width * 0.001),
                      //     InkWell(
                      //       onTap: () {
                      //         widget.navigateToNext(MultiBlocProvider(providers: [
                      //           BlocProvider(
                      //             create: (BuildContext context) {
                      //               return AddressBloc(RealAddressRepo())
                      //                 ..add(GetAddress());
                      //             },
                      //           ),
                      //           BlocProvider(
                      //             create: (BuildContext context) {
                      //               return UserBloc(RealUserRepo());
                      //             },
                      //           ),
                      //           BlocProvider(create: (BuildContext context) {
                      //             return UpdateProfileAddressBloc(
                      //                 RealUpdateProfileAddressRepo());
                      //           })
                      //         ], child: const MyProfile()));
                      //       },
                      //       child: Theme.of(context).brightness == Brightness.dark
                      //           ? Image.asset(
                      //               "assets/images/Button - Image Change.png")
                      //           : Image.asset(
                      //               "assets/images/Button - Image Change (1).png"),
                      //     )
                      //   ],
                      // ),

                      // Divider(
                      //   thickness: .8,
                      //   endIndent: 20.0,
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 76, 59, 0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset("assets/images/Icon profile1.png",
                              width: 24, height: 24),
                        ),
                        title: Text(
                          "My Orders",
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,
                            size: 16,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1)),
                        onTap: () {
                          widget.navigateToNext(

                              MultiBlocProvider(
                                  providers: [
                                  BlocProvider(create: (BuildContext context) {
                                  return OrdersBloc(RealOrdersRepo())
                                    ..add(const GetOrders());
                                    }),
                                    BlocProvider(create: (BuildContext context) {
                                      return OrderShipmentCancelBloc(orderShipmentCancelRepo: RealOrderShipmentCancelRepo());
                                    })
                                  ],
                                  child:  MyOrders(navigateToNext: widget.navigateToNext),
                              ));

                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: .8,
                        endIndent: 20.0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 76, 59, 0.1),
                            ),
                            child: Image.asset(
                              "assets/images/Icon profile 3.png",
                              width: 24,
                              height: 24,
                            )),
                        title: Text(
                          "Delivery Address",
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                        ),
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => MultiBlocProvider(
                          //   providers: [
                          //     BlocProvider(create: (BuildContext context) {
                          //       return AddAddressBloc(RealAddressRepo());
                          //     }),
                          //     BlocProvider(
                          //         create: (context) =>
                          //             CountryyBloc(RealCountryyRepo())),
                          //     BlocProvider(
                          //         create: (context) =>
                          //             StateeBloc(RealStateeRepo())),
                          //     BlocProvider(
                          //         create: (context) =>
                          //             CityyBloc(RealCityyRepo())),
                          //   ],

                          widget.navigateToNext(BlocProvider(
                              create: (BuildContext context) {
                                return AddressBloc(RealAddressRepo())
                                  ..add(GetAddress());
                              },
                              child: MyAddressScreen()));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: .8,
                        endIndent: 20.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(255, 76, 59, 0.1),
                          ),
                          child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 76, 59, 0.03),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.lock_open,
                                size: 24,
                                color: Color.fromRGBO(255, 76, 59, 1),
                              )),
                        ),
                        title: Text(
                          "Change Password",
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                        ),
                        onTap: () {
                          widget.navigateToNext(
                            BlocProvider(
                              create: (context) {
                                return ProfileBloc(RealProfileRepo());
                              },
                              child: ChangePasswordScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: .8,
                        endIndent: 20.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(255, 76, 59, 0.1),
                          ),
                          child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 76, 59, 0.03),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.edit_note_outlined,
                                size: 24,
                                color: Color.fromRGBO(255, 76, 59, 1),
                              )),
                        ),
                        title: Text(
                          "Edit Profile",
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                        ),
                       onTap: () {
                        widget.navigateToNext(MultiBlocProvider(providers: [
                          BlocProvider(
                            create: (BuildContext context) {
                              return AddressBloc(RealAddressRepo())
                                ..add(GetAddress());
                            },
                          ),
                          BlocProvider(
                            create: (BuildContext context) {
                              return UserBloc(RealUserRepo());
                            },
                          ),
                          BlocProvider(create: (BuildContext context) {
                            return UpdateProfileAddressBloc(
                                RealUpdateProfileAddressRepo());
                          })
                        ], child: const MyProfile()));
                          },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: .8,
                        endIndent: 20.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(255, 76, 59, 0.1),
                          ),
                          child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 76, 59, 0.03),
                                  borderRadius: BorderRadius.circular(10)),
                              child:Image.asset("assets/images/Button - Setting account_screen.png")
                          ),
                        ),
                        title: Text(
                          "Settings",
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                        ),
                        onTap: () {
                          widget.navigateToNext(
                           SettingsNew()
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: .8,
                        endIndent: 20.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 76, 59, 0.1),
                            ),
                            child: Image.asset(
                              "assets/images/Icon profile2.png",
                              width: 24,
                              height: 24,
                            )),
                        title: Text(
                          "Logout",
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                        ),
                        onTap: () {
                          widget.navigateToNext(LogoutScreen());
                        },
                      )
                    ],
                  ),
                ),
            )
            : Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.asset(
                          "assets/images/guest_login_bg_image.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "You're missing out",
                      style: GoogleFonts.gothicA1(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Sign in to view your account and to get exciting offers",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(160, 160, 160, 1)
                                    : Color.fromRGBO(112, 112, 112, 1)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                            ),
                            side: const MaterialStatePropertyAll(BorderSide(
                                color: Color.fromRGBO(255, 76, 59, 1))),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.gothicA1(
                              color: Color.fromRGBO(255, 76, 59, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          widget.navigateToNext(SignInScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
