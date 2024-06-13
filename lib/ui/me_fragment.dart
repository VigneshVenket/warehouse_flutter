import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/contact_us/contact_us_bloc.dart';
import 'package:flutter_kundol/blocs/orders/orders_bloc.dart';
import 'package:flutter_kundol/blocs/reward_points/reward_bloc.dart';
import 'package:flutter_kundol/blocs/rewards/rewards_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/contact_us_repo.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';
import 'package:flutter_kundol/repos/reward_repo.dart';
import 'package:flutter_kundol/repos/rewards_repo.dart';
import 'package:flutter_kundol/ui/Reward_screen.dart';
import 'package:flutter_kundol/ui/contact_screen.dart';
import 'package:flutter_kundol/ui/edit_profile_screen.dart';
import 'package:flutter_kundol/ui/login_screen.dart';
import 'package:flutter_kundol/ui/my_address_screen.dart';
import 'package:flutter_kundol/ui/orders_screen.dart';
import 'package:flutter_kundol/ui/settings.dart';
import 'package:flutter_kundol/ui/wallet_screen.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

import '../blocs/reward_des/reward_des_bloc.dart';
import '../blocs/wallet/wallet_bloc.dart';
import '../blocs/wallet_total/total_bloc.dart';
import '../constants/app_cart.dart';
import '../repos/reward_des_repo.dart';
import '../repos/total_repo.dart';
import '../repos/wallet_repo.dart';
import '../tweaks/app_localization.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

class MeFragment extends StatelessWidget {
  final Function(Widget widget) navigateToNext;

  MeFragment(this.navigateToNext);
 final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  var s1 = AppBadge();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          AppConfig.APP_BAR_COLOR == 1 ?
          SliverAppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
            leading: GestureDetector(
              onTap: () => navigateToNext(Settings()),
              child: SvgPicture.asset("assets/icons/ic_setting.svg",
                  fit: BoxFit.none),
            ),
            actions: [
              GestureDetector(
                onTap: () => navigateToNext(
                  (AppData.user != null)
                      ? BlocProvider(
                      create: (context) => CartBloc(RealCartRepo()),
                      child: CartScreen(navigateToNext))
                      :SignInScreen(),
                ),
                child: Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: SvgPicture.asset("assets/icons/ic_cart.svg",
                        fit: BoxFit.none, color: Colors.white)),
              ),
            ],
            expandedHeight: 140.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, state) {
                        return InkWell(
                          onTap: () {
                            if (state is Authenticated) {
                              navigateToNext(EditProfileScreen());
                            } else
                              navigateToNext(SignInScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration:
                                  new BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                                      fit: BoxFit.fill,
                                      progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      // "Welcome"+
                                      (AppLocalizations.of(context)!.translate("Welcome")) !+" "+
                                          ((AppData.user != null)
                                              ? AppData.user!.firstName
                                              : "")!,
                                      style: Theme.of(context)
                                          .textTheme
                                          . bodyLarge
                                          !.copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      ( (AppData.user != null)
                                          ? AppData.user!.email
                                          : AppLocalizations.of(context)!.translate("Please Login"))!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconTheme(
                                    data: IconThemeData(color: Colors.white),
                                    child: Icon(Icons.navigate_next)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    /*Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Rewards",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("Rs0.00",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Points",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                          ]),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Theme.of(context).primaryColor,
                              height: 55,
                            ),
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: 55,
                            )
                          ],
                        ),
                        Card(
                          color: Color(0xFF444444),
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  AppStyles.SCREEN_MARGIN_HORIZONTAL * 2),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Membership Benefits",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .copyWith(
                                              color: Color(0xFFFFC854),
                                            )),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 16.0,
                                      color: Color(0xFFFFC854),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Membership Benefits \n5% OFF",
                                          style: TextStyle(
                                            color: Color(0xFFFFC854),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Birthday Gift \n5% OFF",
                                          style: TextStyle(
                                            color: Color(0xFFFFC854),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
          ):AppConfig.APP_BAR_COLOR == 2 ?
          SliverAppBar(
            backgroundColor:Theme.of(context).primaryColor,
            leading: GestureDetector(
              onTap: () => navigateToNext(Settings()),
              child: SvgPicture.asset("assets/icons/ic_setting.svg",
                  fit: BoxFit.none,color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.white,),
            ),
            actions: [
              Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () => navigateToNext(
                      (AppData.user != null)?
                    MultiBlocProvider(
                    providers: [
                    BlocProvider(
                    create: (context) =>
                    CartBloc(RealCartRepo()),
                    ),
                    //  BlocProvider(
                    // create: (context) =>
                    // ShipmentBloc(RealShipmentRepo()),
                    // ),
                    ],
                    child: CartScreen(navigateToNext),
                    )


                          // ? BlocProvider(
                          // create: (context) =>
                          //     CartBloc(RealCartRepo()),
                          // child: CartScreen())
                          : SignInScreen(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right:5),
                      child: Container(
                        height: 35,
                        width: 40,  
                        child: Stack(
                          children: [
                            Center(child: Padding(
                              padding: const EdgeInsets.only(right: 15,top: 0),
                              child: Icon(Icons.shopping_cart,size: 21,color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.white,),
                            )),
                            Positioned(
                              top: 0,
                                left: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red,
                                    ),
                                    height: 12,
                                      width: 12,
                                      child: Center(child: Text(BadgeItems().toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),))),
                                )),
                            ValueListenableBuilder<int>(
                              builder: (BuildContext context, int value, Widget? child) { 
                                return
                                Container();
                                   // Text(BadgeCounter.toString());
                              },
                              valueListenable: _counter,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
            ],
            expandedHeight: 140.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, state) {
                        return InkWell(
                          onTap: () {
                            if (state is Authenticated) {
                              navigateToNext(EditProfileScreen());
                            } else
                              navigateToNext(SignInScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration:
                                  new BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                                      fit: BoxFit.fill,
                                      progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        // "Welcome"+
                                        (AppLocalizations.of(context)!.translate("Welcome")) !+" "+
                                            ((AppData.user != null)
                                                ? AppData.user!.firstName
                                                : "")!,
                                        style: Theme.of(context)
                                            .textTheme
                                            . bodyLarge
                                        !.copyWith(color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.white,),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        ( (AppData.user != null)
                                            ? AppData.user!.email
                                            : AppLocalizations.of(context)!.translate("Please Login"))!,
                                        style: TextStyle(
                                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.white,),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                IconTheme(
                                    data: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.white,),
                                    child: Icon(Icons.navigate_next)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ):
          AppConfig.APP_BAR_COLOR == 3 ?   SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: GestureDetector(
              onTap: () => navigateToNext(Settings()),
              child: SvgPicture.asset("assets/icons/ic_setting.svg",
                  fit: BoxFit.none),
            ),
            actions: [
              GestureDetector(
                onTap: () => navigateToNext(
                  (AppData.user != null)
                      ? BlocProvider(
                          create: (context) => CartBloc(RealCartRepo()),
                          child: CartScreen(navigateToNext))
                      : SignInScreen(),
                ),
                child: Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: SvgPicture.asset("assets/icons/ic_cart_new.svg",
                        fit: BoxFit.none, color: Colors.white),
                ),
              ),
            ],
            expandedHeight: 140.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, state) {
                        return InkWell(
                          onTap: () {
                            if (state is Authenticated) {
                              navigateToNext(EditProfileScreen());
                            } else
                              navigateToNext(SignInScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration:
                                      new BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                                      fit: BoxFit.fill,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Welcome " +
                                          ((AppData.user != null)
                                              ? AppData.user!.firstName
                                              : "")!,
                                      style: Theme.of(context)
                                          .textTheme
                                          . bodyLarge
                                          !.copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      (AppData.user != null)
                                          ? AppData.user!.email!
                                          : "Please Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconTheme(
                                    data: IconThemeData(color: Colors.white),
                                    child: Icon(Icons.navigate_next)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    /*Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Rewards",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("Rs0.00",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Points",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                          ]),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Theme.of(context).primaryColor,
                              height: 55,
                            ),
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: 55,
                            )
                          ],
                        ),
                        Card(
                          color: Color(0xFF444444),
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  AppStyles.SCREEN_MARGIN_HORIZONTAL * 2),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Membership Benefits",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .copyWith(
                                              color: Color(0xFFFFC854),
                                            )),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 16.0,
                                      color: Color(0xFFFFC854),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Membership Benefits \n5% OFF",
                                          style: TextStyle(
                                            color: Color(0xFFFFC854),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Birthday Gift \n5% OFF",
                                          style: TextStyle(
                                            color: Color(0xFFFFC854),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
          )
:Container(),
        ],
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: ScrollConfiguration(
            behavior:
            ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: [
/*
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Color(0xFFFFC854)),
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xFFF7ECD5)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Check In',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Claim your 20 points',
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xFF0478ED)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: ClipOval(
                                  child: Image.asset(
                                      'assets/images/logo_checkin.png',
                                      fit: BoxFit.fill,
                                      height: 50,
                                      width: 50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Color(0xFF97CBFF)),
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xFFC4DCF4)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Up to \$1000 wallet',
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xFF0478ED)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: ClipOval(
                                  child: Image.asset(
                                      'assets/images/logo_share.png',
                                      fit: BoxFit.fill,
                                      height: 50,
                                      width: 50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
*/
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.4) : Colors.grey.withOpacity(0.6) ,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate("My Orders")!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (AppData.user != null)
                                    navigateToNext(BlocProvider(
                                        create: (BuildContext context) {
                                          return OrdersBloc(RealOrdersRepo())
                                            ..add(GetOrders());
                                        },
                                        child: OrdersScreen()));
                                  else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppLocalizations.of(context)!.translate("Login first")!)));
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.translate("View All")!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      !.copyWith(
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ]
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1.3),
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (AppData.user != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return OrdersBloc(RealOrdersRepo())
                                          ..add(GetOrders());
                                      },
                                      child: OrdersScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                        AppLocalizations.of(context)!.translate("Login first")!,
                                      )));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_in_progress.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("In Progress")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (AppData.user != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return OrdersBloc(RealOrdersRepo())
                                          ..add(GetOrders());
                                      },
                                      child: OrdersScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                        AppLocalizations.of(context)!.translate("Login first")!,
                                      )));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_delivered.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                      height: 4
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Delivered")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (AppData.user != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return OrdersBloc(RealOrdersRepo())
                                          ..add(GetOrders());
                                      },
                                      child: OrdersScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                        AppLocalizations.of(context)!.translate("Login first")!,
                                      )));;
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_reviews.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                      height: 4
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Reviews")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                AppConfig.APP_BAR_COLOR == 1 ?
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.4) : Colors.grey.withOpacity(0.6) ,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate("Help & info")!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1),
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (AppData.user != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return AddressBloc(RealAddressRepo())
                                          ..add(GetAddress());
                                      },
                                      child: MyAddressScreen())
                                  );
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(AppLocalizations.of(context)!.translate("Login first")!)));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_address.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Address")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            /*Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/ic_payment.svg",
                                    fit: BoxFit.none),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Payment",
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),*/
                            GestureDetector(
                              onTap: () {
                                if (AppData.user != null)
                                  navigateToNext(EditProfileScreen());
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                        AppLocalizations.of(context)!.translate("Login first")!,
                                      )));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_profile.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                      height: 4
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Profile")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigateToNext(BlocProvider(
                                  create: (BuildContext context) =>
                                      RewardBloc(RealRewardPoints()),
                                  child: RewardScreen())),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/ic_help.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Rewards")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigateToNext(BlocProvider(
                                  create: (BuildContext context) =>
                                      ContactUsBloc(RealContactUsRepo()),
                                  child: ContactUsScreen())),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_feedback.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Feedback")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              //com.themescoder.flutter_kundol
                              onTap: ()async {
                                final urlPreview="https://play.google.com/store/apps/details?id=com.themescoder.flutter_kundol";
                                await Share.share("Check out this app\n\n$urlPreview");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Share")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => LaunchReview.launch(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_border_outlined,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                      height: 4
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Rate us")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ):
                AppConfig.APP_BAR_COLOR == 2 ?
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.4) : Colors.grey.withOpacity(0.6) ,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate("Help & info")!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1),
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (AppData.user != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return AddressBloc(RealAddressRepo())
                                          ..add(GetAddress());
                                      },
                                      child: MyAddressScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(AppLocalizations.of(context)!.translate("Login first")!)));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_address.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Address").toString(),
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            /*Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/ic_payment.svg",
                                    fit: BoxFit.none),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Payment",
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),*/
                            GestureDetector(
                              onTap: () {
                                if (AppData.user != null)
                                  navigateToNext(EditProfileScreen());
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                        AppLocalizations.of(context)!.translate("Login first")!,
                                      )));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_profile.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                      height: 4
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Profile")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigateToNext
                                (
                                  // BlocProvider(
                                  // create: (BuildContext context) =>
                                  //     RewardnBloc(RealRewardnRepo()),
                                  // child: RewardScreen()
                                  // ),
                                MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (BuildContext context) {
                                          return  RewardnBloc(RealRewardnRepo()
                                          );
                                        },
                                      ),
                                      BlocProvider(
                                        create: (BuildContext context) {
                                          return  RewarddesBloc(RealRewarddesRepo()
                                          );
                                        },
                                      ),
                                    ],
                                    child: RewardScreen(),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/ic_help.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Rewards")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigateToNext(BlocProvider(
                                  create: (BuildContext context) =>
                                      ContactUsBloc(RealContactUsRepo()),
                                  child: ContactUsScreen())),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_feedback.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Feedback")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigateToNext

                                // (BlocProvider(
                                //   create: (BuildContext context) =>
                                //       WalletBloc(RealWalletRepo()),
                                //   child: WalletScreen())),
                                (MultiBlocProvider(
                            providers: [
                            BlocProvider(
                            create: (BuildContext context) {
                            return  WalletBloc(RealWalletRepo()
                             );
                              },
                               ),
                            BlocProvider(
                            create: (BuildContext context) {
                            return  TotalBloc(RealTotalRepo()
                             );
                              },
                               ),
                             ],
                             child: WalletScreen()
                              ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wallet_outlined),
                                  // SvgPicture.asset(
                                  //     "assets/icons/ic_feedback.svg",
                                  //     fit: BoxFit.none,
                                  //     color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Wallet")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              //com.themescoder.flutter_kundol
                              onTap: ()async {
                                final urlPreview="https://play.google.com/store/apps/details?id=com.themescoder.flutter_kundol";
                                await Share.share("Check out this app\n\n$urlPreview");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Share")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => LaunchReview.launch(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_border_outlined,
                                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                      height: 4
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Rate us")!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ):
                Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Container(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 8,),
                          GestureDetector(
                            onTap: (){
                              if (AppData.user != null)
                                navigateToNext(BlocProvider(
                                    create: (BuildContext context) {
                                      return AddressBloc(RealAddressRepo())
                                        ..add(GetAddress());
                                    },
                                    child: MyAddressScreen()));
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Login first")));
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  child: SvgPicture.asset(
                                      "assets/icons/ic_location_new.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  width: 50,
                                ),
                                Expanded(child: Text("Address",style: TextStyle(fontSize: 12),)),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 12, color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? AppStyles.COLOR_ICONS_DARK
                                      : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          // ListTile(
                          //   onTap: () {
                          //     if (AppData.user != null)
                          //       navigateToNext(BlocProvider(
                          //           create: (BuildContext context) {
                          //             return AddressBloc(RealAddressRepo())
                          //               ..add(GetAddress());
                          //           },
                          //           child: MyAddressScreen()));
                          //     else {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(content: Text("Login first")));
                          //     }
                          //   },
                          //   leading: SvgPicture.asset(
                          //       "assets/icons/ic_address.svg",
                          //       height: 18,
                          //       width: 18,
                          //       fit: BoxFit.contain,
                          //       color: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //           ? AppStyles.COLOR_ICONS_DARK
                          //           : AppStyles.COLOR_ICONS_LIGHT),
                          //   title: Text(
                          //     "Address",
                          //     style: TextStyle(fontSize: 12),
                          //     maxLines: 1,
                          //   ),
                          //   trailing: IconTheme(
                          //       data: IconThemeData(
                          //           color: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //               ? AppStyles.COLOR_ICONS_DARK
                          //               : AppStyles.COLOR_ICONS_LIGHT),
                          //       child: Icon(Icons.chevron_right)),
                          // ),
                          GestureDetector(
                            onTap: (){
                              if (AppData.user != null)
                                navigateToNext(EditProfileScreen());
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Login first")));
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 30,
                                  child: SvgPicture.asset(
                                      "assets/icons/ic_profile_new.svg",
                                      height: 12,
                                      width: 12,
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                                Expanded(child: Text("Profile",style: TextStyle(fontSize: 12),)),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 12, color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? AppStyles.COLOR_ICONS_DARK
                                      : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          // ListTile(
                          //   onTap: () {
                          //     if (AppData.user != null)
                          //       navigateToNext(EditProfileScreen());
                          //     else {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(content: Text("Login first")));
                          //     }
                          //   },
                          //   leading: SvgPicture.asset("assets/icons/ic_profile.svg",
                          //       height: 18,
                          //       width: 18,
                          //       fit: BoxFit.contain,
                          //       color: Theme.of(context).brightness ==
                          //           Brightness.dark
                          //           ? AppStyles.COLOR_ICONS_DARK
                          //           : AppStyles.COLOR_ICONS_LIGHT),
                          //   title: Text(
                          //     "Profile",
                          //     style: TextStyle(fontSize: 12),
                          //     maxLines: 1,
                          //   ),
                          //   trailing: IconTheme(
                          //       data: IconThemeData(
                          //           color: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //               ? AppStyles.COLOR_ICONS_DARK
                          //               : AppStyles.COLOR_ICONS_LIGHT),
                          //       child: Icon(Icons.chevron_right)),
                          // ),
                          GestureDetector(
                            onTap: (){
                              navigateToNext(BlocProvider(
                                  create: (BuildContext context) =>
                                      RewardBloc(RealRewardPoints()),
                                  child: RewardScreen()));
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 30,
                                  child: SvgPicture.asset(
                                      "assets/icons/ic_voucher.svg",

                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                                Expanded(child: Text("Rewards",style: TextStyle(fontSize: 12),)),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 12, color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? AppStyles.COLOR_ICONS_DARK
                                      : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          // ListTile(
                          //   onTap: () {
                          //     navigateToNext(BlocProvider(
                          //         create: (BuildContext context) =>
                          //             RewardBloc(RealRewardPoints()),
                          //         child: RewardScreen()));
                          //   },
                          //   leading: SvgPicture.asset("assets/icons/ic_help.svg",
                          //       fit: BoxFit.contain,
                          //       height: 18,
                          //       width: 18,
                          //       color: Theme.of(context).brightness ==
                          //           Brightness.dark
                          //           ? AppStyles.COLOR_ICONS_DARK
                          //           : AppStyles.COLOR_ICONS_LIGHT),
                          //   title: Text(
                          //     "Rewards",
                          //     style: TextStyle(fontSize: 12),
                          //     maxLines: 1,
                          //   ),
                          //   trailing: IconTheme(
                          //       data: IconThemeData(
                          //           color: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //               ? AppStyles.COLOR_ICONS_DARK
                          //               : AppStyles.COLOR_ICONS_LIGHT),
                          //       child: Icon(Icons.chevron_right)),
                          // ),
                          GestureDetector(
                            onTap: (){
                              navigateToNext(BlocProvider(
                                  create: (BuildContext context) =>
                                      ContactUsBloc(RealContactUsRepo()),
                                  child: ContactUsScreen()));
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 30,
                                  child: SvgPicture.asset(
                                      "assets/icons/ic_feedback_new.svg",

                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                                Expanded(child: Text("Give Us Your Feedback",style: TextStyle(fontSize: 12),)),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 12, color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? AppStyles.COLOR_ICONS_DARK
                                      : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          // ListTile(
                          //   onTap: () {
                          //     navigateToNext(BlocProvider(
                          //         create: (BuildContext context) =>
                          //             ContactUsBloc(RealContactUsRepo()),
                          //         child: ContactUsScreen()));
                          //   },
                          //   leading: SvgPicture.asset("assets/icons/ic_feedback.svg",
                          //       fit: BoxFit.contain,
                          //       height: 18,
                          //       width: 18,
                          //       color: Theme.of(context).brightness ==
                          //           Brightness.dark
                          //           ? AppStyles.COLOR_ICONS_DARK
                          //           : AppStyles.COLOR_ICONS_LIGHT),
                          //   title: Text(
                          //     "Feedback",
                          //     style: TextStyle(fontSize: 12),
                          //     maxLines: 1,
                          //   ),
                          //   trailing: IconTheme(
                          //       data: IconThemeData(
                          //           color: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //               ? AppStyles.COLOR_ICONS_DARK
                          //               : AppStyles.COLOR_ICONS_LIGHT),
                          //       child: Icon(Icons.chevron_right)),
                          // ),
                          GestureDetector(
                            onTap: (){
                              Share.share('check out this app Flutter Warehouse');
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 30,
                                  child: Icon(Icons.share,
                                      size: 12,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                                Expanded(child: Text("Share",style: TextStyle(fontSize: 12),)),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 12, color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? AppStyles.COLOR_ICONS_DARK
                                      : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          // ListTile(
                          //   onTap: () {
                          //     Share.share('check out this app Flutter Warehouse');
                          //   },
                          //   leading:
                          //   Icon(Icons.share,
                          //       size: 18,
                          //       color: Theme.of(context).brightness ==
                          //           Brightness.dark
                          //           ? AppStyles.COLOR_ICONS_DARK
                          //           : AppStyles.COLOR_ICONS_LIGHT),
                          //   title: Text(
                          //     "Share",
                          //     style: TextStyle(fontSize: 12),
                          //     maxLines: 1,
                          //   ),
                          //   trailing: IconTheme(
                          //       data: IconThemeData(
                          //           color: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //               ? AppStyles.COLOR_ICONS_DARK
                          //               : AppStyles.COLOR_ICONS_LIGHT),
                          //       child: Icon(Icons.chevron_right)),
                          // ),
                          GestureDetector(
                            onTap: (){
                              LaunchReview.launch();
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 30,
                                  child: Icon(Icons.star_border_outlined,
                                      size: 18,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                                Expanded(child: Text("Rate",style: TextStyle(fontSize: 12),)),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 12, color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? AppStyles.COLOR_ICONS_DARK
                                      : AppStyles.COLOR_ICONS_LIGHT),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          // ListTile(
                          //   onTap: () {
                          //     LaunchReview.launch();
                          //   },
                          //   leading:
                          //   Icon(Icons.star_border_outlined,
                          //       size: 18,
                          //       color: Theme.of(context).brightness ==
                          //           Brightness.dark
                          //           ? AppStyles.COLOR_ICONS_DARK
                          //           : AppStyles.COLOR_ICONS_LIGHT),
                          //   title: Text(
                          //     "Rate us",
                          //     style: TextStyle(fontSize: 12),
                          //     maxLines: 1,
                          //   ),
                          //   trailing: IconTheme(
                          //       data: IconThemeData(
                          //           color: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //               ? AppStyles.COLOR_ICONS_DARK
                          //               : AppStyles.COLOR_ICONS_LIGHT),
                          //       child: Icon(Icons.chevron_right)),
                          // ),

/*
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/ic_address.svg",
                                    fit: BoxFit.none,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_ICONS_DARK
                                        : AppStyles.COLOR_ICONS_LIGHT),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Address",
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/ic_payment.svg",
                                      fit: BoxFit.none),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Payment",
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),*/
                        ],
                      ),
                    )),
/*
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(BlocProvider(
                      create: (context) => RewardBloc(RealRewardPoints()),
                      child: RewardScreen(),
                    ));
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.receipt_long_outlined)),
                  title: Text(
                    "Rewards",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(WalletScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.account_balance_wallet_outlined)),
                  title: Text(
                    "Wallet",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.account_balance_wallet_outlined)),
                  title: Text(
                    "Points",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(
                      BlocProvider(
                          create: (BuildContext context) {
                            return AddressBloc(RealAddressRepo())
                              ..add(GetAddress());
                          },
                          child: MyAddressScreen()),
                    );
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.location_on_outlined)),
                  title: Text(
                    "Address Book",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.credit_card_outlined)),
                  title: Text(
                    "Payment",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ));
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.person_outline)),
                  title: Text(
                    "Profile",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.attach_money_outlined)),
                  title: Text(
                    "Invite & Earn",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.help_outline)),
                  title: Text(
                    "Help Cneter",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(BlocProvider(
                        create: (BuildContext context) {
                          return ContactUsBloc(RealContactUsRepo());
                        },
                        child: ContactUsScreen()));
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.feedback_outlined)),
                  title: Text(
                    "Give us your feedback",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
