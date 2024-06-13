import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../tweaks/app_localization.dart';

class HomeTags extends StatelessWidget {
  const HomeTags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Column(children: [
              SvgPicture.asset("assets/icons/ic_offer.svg", fit: BoxFit.none),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(AppLocalizations.of(context)!.translate('10% Off First Order')!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontFamily: "MontserratLight",
                    )),
              )
            ]),
          ),
          Flexible(
            child: Column(children: [
              SvgPicture.asset("assets/icons/ic_delivery.svg", fit: BoxFit.none),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(AppLocalizations.of(context)!.translate('free shipping on')!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontFamily: "MontserratLight",
                    )),
              )
            ]),
          ),
          Flexible(
            child: Column(children: [
              SvgPicture.asset("assets/icons/ic_calender.svg", fit: BoxFit.none),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(AppLocalizations.of(context)!.translate('days to return 30')!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontFamily: "MontserratLight",
                    )),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
