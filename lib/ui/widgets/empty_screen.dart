import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../tweaks/app_localization.dart';



class Empty_Screen extends StatelessWidget {
  const Empty_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  const Color(0xffF6F6F6),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          child: AspectRatio(
              aspectRatio: 1/1,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/empty_img.svg"),
                  const SizedBox(height: 30,),
                  Text(
                      AppLocalizations.of(context)!.translate("Currently there are no rewards available")!
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
