import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/ui/settings_new.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/products_search/products_search_bloc.dart';

import '../../constants/app_cart.dart';
import '../../constants/app_styles.dart';
import '../../models/cart_data.dart';
import '../../repos/products_repo.dart';

import '../../tweaks/app_localization.dart';
import '../cart_screen.dart';
import '../login_screen.dart';
import '../search_screen.dart';
import 'app_bar.dart';
import 'badgeCount.dart';

class HomeAppBar extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;
  HomeAppBar(
    this.navigateToNext,
    this.openDrawer, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  var BadgeCounter = 0;
  var s1 = AppBadge();
  @override
  Widget build(BuildContext context) {
    if (AppConfig.APP_BAR_COLOR == 2) {
      return
        MyAppBar(
        centerWidget: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  width: MediaQuery.of(context).size.width*0.12,
                  height: MediaQuery.of(context).size.height*0.04,
                  child: Image.asset("assets/images/livekart_logo.png",
                  fit: BoxFit.fill,
                  )),
            ),
            SizedBox(width: 5),
            Text(
              "LIVEKART",
              style: GoogleFonts.gothicA1(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(18, 18, 18, 1),
              fontSize: 18,
              fontWeight: FontWeight.w800),
            ),
          ],
        ),
        trailingWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => widget.navigateToNext(
                  (AppData.user != null)
                      ? BlocProvider(
                          create: (context) => CartBloc(RealCartRepo()),
                          child: CartScreen(widget.navigateToNext))
                      : SignInScreen(),
                ),
                child: Container(
                  height: 35,
                  width: 40,
                  child: Stack(
                    children: [
                      // Center(
                      //     child: Padding(
                      //     padding: const EdgeInsets.only(right: 12, top: 5),
                      //     child: Icon(
                      //     Icons.shopping_cart,
                      //     size: 26,
                      //     color: Theme.of(context).brightness == Brightness.dark
                      //         ? Color.fromRGBO(255, 255, 255, 1)
                      //         : Color.fromRGBO(18, 18, 18, 1),
                      //   ),
                      // )),

                      // Positioned(
                      //     top: 0,
                      //     left: MediaQuery.of(context).size.width*0.02,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 8),
                      //       child: Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             color: Color.fromRGBO(255, 76, 59, 1),
                      //           ),
                      //           height: 15,
                      //           width: 15,
                      //           child: Center(
                      //               child: Text(
                      //             BadgeItems().toString(),
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 10),
                      //           ))),
                      //     )),
                      ValueListenableBuilder<int>(
                        builder: (BuildContext context, int value, Widget? child) {
                          return Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12, top: 5),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 26,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(18, 18, 18, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: MediaQuery.of(context).size.width * 0.02,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(255, 76, 59, 1),
                                    ),
                                    height: 15,
                                    width: 15,
                                    child: Center(
                                      child: Text(
                                        value.toString(), // Display the badge count
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        valueListenable: s1.cartTotalitemsListener, // Listen to cartTotalitemsListener
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (AppConfig.APP_BAR_COLOR == 1) {
      return MyAppBar(
        leadingWidget: Padding(
          padding: EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () => widget.navigateToNext(SettingsNew()),
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: SvgPicture.asset("assets/icons/ic_drawer_menu.svg",
                    color: AppConfig.APP_BAR_COLOR == 1
                        ? Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black
                        : Colors.white,
                    fit: BoxFit.none)),
          ),
        ),
        centerWidget: Center(
            child: Text(
          "WAREHOUSE",
          //  AppLocalizations.of(context).translate('app_name'),
          style: TextStyle(
              color: AppConfig.APP_BAR_COLOR == 1
                  ? Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black
                  : Colors.white,
              fontSize: 16.0,
              fontFamily: "MontserratSemiBold"),
        )),
        trailingWidget: Padding(
          padding: EdgeInsets.all(3.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => widget.navigateToNext(BlocProvider(
                  create: (context) => ProductsSearchBloc(RealProductsRepo()),
                  child: SearchScreen(widget.navigateToNext),
                )),
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/icons/ic_search.svg",
                      fit: BoxFit.none,
                      color: AppConfig.APP_BAR_COLOR == 1
                          ? Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black
                          : Colors.white,
                    )),
              ),
              // GestureDetector(
              //   onTap: () => widget.navigateToNext(
              //     (AppData.user != null)
              //         ? BlocProvider(
              //         create: (context) =>
              //             CartBloc(RealCartRepo()),
              //         child: CartScreen())
              //         : SignIn(),
              //   ),
              //   child: Padding(
              //       padding: EdgeInsets.all(12.0),
              //       child: SvgPicture.asset("assets/icons/ic_cart.svg",
              //         fit: BoxFit.none,
              //         color:AppConfig.APP_BAR_COLOR == 1 ?
              //         Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
              //         Colors.white,
              //       )),
              // ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () => widget.navigateToNext(
                          (AppData.user != null)
                              ? BlocProvider(
                                  create: (context) => CartBloc(RealCartRepo()),
                                  child: CartScreen(widget.navigateToNext))
                              : SignInScreen(),
                        ),
                        child: Container(
                          height: 30,
                          width: 40,
                          //  color: Colors.black12,
                          child: Stack(
                            children: [
                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, top: 12),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 23,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )),
                              Positioned(
                                  top: 2,
                                  left: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.red,
                                        ),
                                        height: 15,
                                        width: 15,
                                        child: Center(
                                            child: Text(
                                          BadgeItems().toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ))),
                                  )),
                              ValueListenableBuilder<int>(
                                builder: (BuildContext context, int value,
                                    Widget? child) {
                                  // This builder will only get called when the _counter
                                  // is updated.
                                  return Container();
                                  //   Row(
                                  // //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   // children: <Widget>[
                                  //   // ],
                                  // );
                                },
                                valueListenable: _counter,
                                // The child parameter is most helpful if the child is
                                // expensive to build and does not depend on the value from
                                // the notifier.
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return MyAppBar(
        leadingWidget: Padding(
          padding: EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () => widget.navigateToNext(SettingsNew()),
            child: Container(
              width: 30,
              height: 30,
              child: SvgPicture.asset("assets/icons/ic_menu_new.svg",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fit: BoxFit.none),
            ),
          ),
        ),
        centerWidget: GestureDetector(
          onTap: () {
            widget.navigateToNext(BlocProvider(
                create: (context) => ProductsSearchBloc(RealProductsRepo()),
                child: SearchScreen(widget.navigateToNext)));
          },
          child: Container(
            height: 30.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppStyles.COLOR_SEARCH_BAR,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  size: 16.0,
                  color: Color(0xff9BA5A7),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "What are you looking for?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 10),
                    ))
              ],
            ),
          ),
        ),
        trailingWidget: Padding(
          padding: EdgeInsets.all(3.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => widget.navigateToNext(
                  (AppData.user != null)
                      ? BlocProvider(
                          create: (context) => CartBloc(RealCartRepo()),
                          child: CartScreen(widget.navigateToNext))
                      : SignInScreen(),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/icons/ic_cart_new.svg",
                    fit: BoxFit.none,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  int count = 0;
  int BadgeItems() {
    var s1 = AppBadge();
    if (count == 0) s1.assignListner(_counter);

    int result = s1.getBadgeUpdate();
    //   count++;
    print(
        "-------------------------------------------- updated home cart    ----------------------- ${result}");
    print(count);
    BadgeCounter = result;
    return result;
  }
}
