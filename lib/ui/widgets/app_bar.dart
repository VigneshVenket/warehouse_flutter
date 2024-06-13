import 'package:flutter/material.dart';

import '../../constants/app_config.dart';
import '../../constants/app_styles.dart';

class MyAppBar extends StatefulWidget {
  final Widget? leadingWidget;
  final Widget? centerWidget;
  final Widget? trailingWidget;

  MyAppBar({this.leadingWidget, this.centerWidget, this.trailingWidget});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {

    return AppConfig.APP_BAR_COLOR ==2 ?
    SafeArea(
        bottom: false,
        child: Container(
          color: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
    //     decoration: BoxDecoration(
    //     // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  AppStyles.APP_BACKGROUND_COLOR,
    //     // color: Theme.of(context).cardColor
    //     color:AppConfig.APP_BAR_COLOR == 2 ?
    //     Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
    // Colors.white,
    // //  color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
    // ),
    height: kToolbarHeight,
    child: Row(
    children: [
    (widget.leadingWidget != null)
    ? widget.leadingWidget!
        : SizedBox(
    width: 16.0,
    ),
    Expanded(child: (widget.centerWidget != null) ? widget.centerWidget! : SizedBox()),
    (widget.trailingWidget != null)
    ? widget.trailingWidget!
        : SizedBox(
    width: 16.0,
    )
    ],
    ),
    ),
    ):
    AppConfig.APP_BAR_COLOR == 3 ?
    SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          /*boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.4) : Colors.grey.withOpacity(0.6) ,
              blurRadius: 4,
            ),
          ],*/
        ),
        height: kToolbarHeight,
        child: Row(
          children: [
            (widget.leadingWidget != null)
                ? widget.leadingWidget!
                : SizedBox(
                    width: 16.0,
                  ),
            Expanded(child: (widget.centerWidget != null) ? widget.centerWidget! : SizedBox()),
            (widget.trailingWidget != null)
                ? widget.trailingWidget!
                : SizedBox(
                    width: 16.0,
                  )
          ],
        ),
      ),
    ):

        AppConfig.APP_BAR_COLOR == 1 ?
    SafeArea(
    bottom: false,
    child: Container(
    decoration: BoxDecoration(
    // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  AppStyles.APP_BACKGROUND_COLOR,
    // color: Theme.of(context).cardColor
      color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
      //  color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
    ),
    height: kToolbarHeight,
    child: Row(
    children: [
    (widget.leadingWidget != null)
    ? widget.leadingWidget!
        : SizedBox(
    width: 16.0,
    ),
    Expanded(child: (widget.centerWidget != null) ? widget.centerWidget! : SizedBox()),
    (widget.trailingWidget != null)
    ? widget.trailingWidget!
        : SizedBox(
    width: 16.0,
    )
    ],
    ),
    ),








    // return SafeArea(
    //   bottom: false,
    //   child: Container(
    //     decoration: BoxDecoration(
    //        // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  AppStyles.APP_BACKGROUND_COLOR,
    //      // color: Theme.of(context).cardColor
    //       color:AppConfig.APP_BAR_COLOR == 2 ?
    //       Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
    //       Colors.white,
    //     //  color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
    //     ),
    //     height: kToolbarHeight,
    //     child: Row(
    //       children: [
    //         (leadingWidget != null)
    //             ? leadingWidget!
    //             : SizedBox(
    //           width: 16.0,
    //         ),
    //         Expanded(child: (centerWidget != null) ? centerWidget! : SizedBox()),
    //         (trailingWidget != null)
    //             ? trailingWidget!
    //             : SizedBox(
    //           width: 16.0,
    //         )
    //       ],
    //     ),
    //   ),
    // );
    ):
        SafeArea(
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              /*boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.4) : Colors.grey.withOpacity(0.6) ,
              blurRadius: 4,
            ),
          ],*/
            ),
            height: kToolbarHeight,
            child: Row(
              children: [
                (widget.leadingWidget != null)
                    ? widget.leadingWidget!
                    : SizedBox(
                  width: 16.0,
                ),
                Expanded(child: (widget.centerWidget != null) ? widget.centerWidget! : SizedBox()),
                (widget.trailingWidget != null)
                    ? widget.trailingWidget!
                    : SizedBox(
                  width: 16.0,
                )
              ],
            ),
          ),
        );
  }
}
