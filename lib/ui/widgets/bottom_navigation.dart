import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../tweaks/app_localization.dart';

class MyBottomNavigation extends StatelessWidget {

  final Function(int position) selectCurrentItem;
  final int selectedIndex;

  const MyBottomNavigation(this.selectCurrentItem, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width:MediaQuery.of(context).size.width,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: GNav(
            padding: const EdgeInsets.all(12),
            tabBackgroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(255, 76, 59, 1),
            activeColor: const Color.fromRGBO(255, 76, 59, 1),
            gap: MediaQuery.of(context).size.width*0.015,
            selectedIndex: selectedIndex,
            onTabChange: (value){
              selectCurrentItem(value);
            },
            tabs:[
              GButton(
                  icon: Icons.home,
                  iconColor: Color.fromRGBO(255, 255, 255, 1),
                  text: 'Home',
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.015)
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.015),
                iconColor: Color.fromRGBO(255, 255, 255, 1),
              ),

              GButton(
                icon: Icons.favorite_border_outlined,
                text: 'WishList',
                margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.015),
                iconColor: Color.fromRGBO(255, 255, 255, 1),
              ),
              GButton(
                icon: Icons.person_outline_rounded,
                text: 'Profile',
                margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.015),
                iconColor: Color.fromRGBO(255, 255, 255, 1),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
