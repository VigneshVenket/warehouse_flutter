import 'package:flutter/material.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_1.dart';
import 'package:flutter_kundol/ui/login_screen.dart';
import 'package:flutter_kundol/ui/main_screen.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../tweaks/app_localization.dart';


class Intro_Screen extends StatefulWidget {
  const Intro_Screen({Key? key}) : super(key: key);

  @override
  _Intro_ScreenState createState() => _Intro_ScreenState();
}

class _Intro_ScreenState extends State<Intro_Screen> {
  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;
  double tabletWidth=700.0;
  bool isNewUser =false;
  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        )).then((val)=>setState(() {
    }));
  }

  // _openHomeDrawer() {
  //   _scaffoldKey.currentState?.openDrawer();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1) ,
        // body:Column(
        //   children: [
        //     Expanded(
        //       child:PageView(
        //         controller: pageController,
        //         onPageChanged: (index){
        //           setState(() {
        //             pageChanged = index;
        //           });
        //           // print(pageChanged);
        //         },
        //         children: [
        //           Container(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Align(
        //                   alignment: Alignment.topLeft,
        //                   child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 20),
        //                       child: Text(
        //                         AppLocalizations.of(context)!.translate("Online Shopping")!,
        //                         style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28),)),
        //                 ),
        //                 Align(
        //                   alignment: Alignment.topRight,
        //                   child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 20),
        //                       child: Text(
        //                         AppLocalizations.of(context)!.translate("Online Shopping")!,
        //                         style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Color(0xff0478ED)),)),
        //                 ),
        //                 const SizedBox(height: 30,),
        //                 Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: SvgPicture.asset("assets/images/intro_1.svg",height: 250,width: double.maxFinite,)),
        //                 Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: SvgPicture.asset("assets/images/intro_bar_1.svg",height: 55,width: double.maxFinite)),
        //               ],
        //             ),
        //           ),
        //           Container(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Align(
        //                   alignment: Alignment.topLeft,
        //                   child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 20),
        //                       child: Text(
        //                         AppLocalizations.of(context)!.translate("Cook Instantly")!,
        //                         style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28),)),
        //                 ),
        //                 Align(
        //                   alignment: Alignment.topRight,
        //                   child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 20),
        //                       child: Text(
        //                         AppLocalizations.of(context)!.translate("Without Any Worries")!,
        //                         style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Color(0xff0478ED)),)),
        //                 ),
        //                 const SizedBox(height: 30,),
        //                 Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: SvgPicture.asset("assets/images/intro_2.svg",height: 250,width: double.maxFinite,)),
        //                 Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: SvgPicture.asset("assets/images/intro_bar_2.svg",height: 55,width: double.maxFinite)),
        //               ],
        //             ),
        //           ),
        //           Container(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Align(
        //                   alignment: Alignment.topLeft,
        //                   child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 20),
        //                       child: Text(
        //                         AppLocalizations.of(context)!.translate("Ship at your home")!,
        //                         style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28),)),
        //                 ),
        //                 Align(
        //                   alignment: Alignment.topRight,
        //                   child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 20),
        //                       child: Text(
        //                         AppLocalizations.of(context)!.translate("In no time")!,
        //                         style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Color(0xff0478ED)),)),
        //                 ),
        //                 const SizedBox(height: 30,),
        //                 Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: SvgPicture.asset("assets/images/intro_3.svg",height: 250,width: double.maxFinite,)),
        //                 Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: SvgPicture.asset("assets/images/intro_bar_3.svg",height: 55,width: double.maxFinite)),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SizedBox(
        //         width: double.maxFinite,
        //         height: 100,
        //         child: Column(
        //           children: [
        //             SizedBox(
        //               width: 220,
        //               child: ElevatedButton(
        //                   style: ButtonStyle(
        //                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                           RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(40.0),
        //
        //                           )
        //                       )
        //                   ),
        //                   onPressed: () {
        //                     if(pageChanged <= 2){
        //                       pageController.animateToPage(++pageChanged, duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
        //                     }
        //                     print(pageChanged);
        //                   },
        //                   child: pageChanged == 2 ? Text(
        //                       AppLocalizations.of(context)!.translate("Sign In")!
        //                   ) : Text(
        //                       AppLocalizations.of(context)!.translate("Next")!
        //                   )
        //
        //               ),
        //             ),
        //             pageChanged == 2 ? Text(
        //                 AppLocalizations.of(context)!.translate("Home")!
        //             ) : Text(
        //                 AppLocalizations.of(context)!.translate( "Skip")!
        //             )
        //           ],
        //         )
        //     ),
        //   ],
        // )
      body:

      Stack(
        children: [
          // Image.asset("assets/images/Onboardingbackground.png",fit: BoxFit.fill,
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          // ),
          PageView(
            controller: pageController,
            onPageChanged: (index){
              setState(() {
                pageChanged=index;
              });
            },
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/onboarding_image2-removebg-preview.png",fit: BoxFit.fill,),
                  ),
                  Center(
                    child: Text("We provide high \nquality products just\nfor you.",
                      textAlign: TextAlign.center,
                      style:GoogleFonts.gothicA1(
                        fontSize: 28,
                        color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w700
                      ),),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/onboarding_image1-removebg-preview.png",fit: BoxFit.fill,),
                  ),
                  Center(
                    child: Text("Your satisfaction is\nour number one\npriority.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gothicA1(
                          fontSize: 28,
                          color:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w700
                      ),),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/onbaording_image_3-removebg-preview.png",
                       ),
                  ),
                   Center(
                    child: Text("Let’s fulfill your daily\nneed with Livekart\nright now!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gothicA1(
                          fontSize:28,
                          color:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w700
                      ),),
                  ),
                ],
              )
            ],
          ),
          Positioned(
              top: 35,
              left: MediaQuery.of(context).size.width*0.8,
              child: pageChanged==2?
               SizedBox():
               TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:(c)=>SignInScreen()));
                },
                child:Text("Skip",style: GoogleFonts.gothicA1(
                    fontSize: 18,
                    color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255,1):Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w500
                ),),
              )),
          Positioned(
            bottom: 130,
              left: MediaQuery.of(context).size.width<tabletWidth?MediaQuery.of(context).size.width*0.43:MediaQuery.of(context).size.width*0.47,
              child: SmoothPageIndicator(
                count: 3,
                controller: pageController,
                effect: ExpandingDotsEffect(
                  dotHeight:10,
                  dotWidth: 10,
                  dotColor: Color.fromRGBO(154, 147, 147, 1.0),
                  activeDotColor: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                ),
              )),
          Positioned(
            left: MediaQuery.of(context).size.width*0.07,
              bottom: 60,
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width*0.86,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 76, 59, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: pageChanged==2? Text("Get Started",style: GoogleFonts.gothicA1(
                      color: Color.fromRGBO(255, 255, 255, 1,),
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),
                  ):Text("Next",style:GoogleFonts.gothicA1(
                      color: Color.fromRGBO(255, 255, 255, 1,),
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),
                  ),
                  onPressed: (){
                    if(pageChanged<2){
                      pageController.animateToPage(++pageChanged,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeIn);
                    }else{
                      // Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(builder: (c) => isNewUser ? SignInScreen() :_openHomeDrawer()),
                      //       (route) => false,
                      // );
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>SignInScreen()), (route) => false);
                    }
                  },
                ),
              ),)
        ],
      )

    );
  }
}
