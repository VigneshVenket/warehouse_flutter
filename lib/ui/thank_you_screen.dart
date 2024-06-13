import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/orders/orders_bloc.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';
import 'package:flutter_kundol/ui/orders_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../tweaks/app_localization.dart';
import 'main_screen.dart';
import 'my_orders.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen();

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>MainScreen()));
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Confirmation",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          ),
        automaticallyImplyLeading: false,

        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // const SizedBox(height: 50,),
              // SvgPicture.asset("assets/icons/ic_check_finish.svg",color: Theme.of(context).primaryColor,),
              // const SizedBox(height: 10,),
              // Text(
              //   AppLocalizations.of(context)!.translate("Congratulations!")!,
              //   style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor),),
              // Center(child: Text(
              //     AppLocalizations.of(context)!.translate("Your Order Has been Placed")!
              // )),
              // const SizedBox(height: 30,),
              // SizedBox(
              //   width: 280,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //               RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(40.0),
              //
              //               )
              //           )
              //       ),
              //       onPressed: () {
              //         Navigator.pushAndRemoveUntil(
              //           context,
              //           MaterialPageRoute(
              //             builder: (BuildContext context) => BlocProvider(
              //                 create: (BuildContext context) {
              //                   return OrdersBloc(RealOrdersRepo())
              //                     ..add(const GetOrders());
              //                 },
              //                 child: OrdersScreen()),
              //           ),
              //           (route) => route.isFirst,
              //         );
              //       },
              //       child: Text(
              //           AppLocalizations.of(context)!.translate("Order Status")!
              //       )),
              // ),
              // SizedBox(
              //   width: 280,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(40.0),
              //             side: BorderSide(width:1, color:Theme.of(context).primaryColor),
              //
              //           ),
              //
              //
              //         ),
              //         backgroundColor: MaterialStateProperty.all( Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).popUntil((route) => route.isFirst);
              //       },
              //       child: Text(
              //         AppLocalizations.of(context)!.translate("Continue Shopping")!,
              //         style: TextStyle(color:Theme.of(context).primaryColor),)),
              // ),

              const SizedBox(
                height: 50,
              ),
              Image.asset("assets/images/Thankyou_screen_image-removebg-preview.png",
                height: 350,
                width: 450,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text("Thank You For Your Order!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gothicA1(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(255, 255, 255, 1):
                    Color.fromRGBO(0, 0, 0, 1)
                ),),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text("Your order will be delivered on time.",
                  textAlign: TextAlign.center,
                  style:GoogleFonts.gothicA1(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness==Brightness.dark?
                      Color.fromRGBO(160, 160, 160,1):
                      Color.fromRGBO(112, 112, 112, 1)
                  ) ,),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.04,
              ),
              SizedBox(
                height: 45,
                width: double.maxFinite,
                child: ElevatedButton(
                  style:
                  ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).brightness ==
                          Brightness.dark
                          ? Color.fromRGBO(0, 0, 0, 1)
                          : Color.fromRGBO(255, 255, 255, 1),
                    ),
                    side: const MaterialStatePropertyAll(
                        BorderSide(
                            color:
                            Color.fromRGBO(255, 76, 59, 1))),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child:Text("Go to Home",
                    style: GoogleFonts.gothicA1(
                      color: Color.fromRGBO(255, 76, 59, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),),
                  onPressed: (){
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).push(MaterialPageRoute(builder: (c)=>MainScreen()));
                  },
                ),
              ),
              // SizedBox(
              //   height:MediaQuery.of(context).size.height*0.01,
              // ),
              // SizedBox(
              //   height: 45,
              //   width: double.maxFinite,
              //   child: ElevatedButton(
              //     style:
              //     ButtonStyle(
              //       backgroundColor: MaterialStatePropertyAll(
              //         Theme.of(context).brightness ==
              //             Brightness.dark
              //             ? Color.fromRGBO(0, 0, 0, 1)
              //             : Color.fromRGBO(255, 255, 255, 1),
              //       ),
              //       side: const MaterialStatePropertyAll(
              //           BorderSide(
              //               color:
              //               Color.fromRGBO(255, 76, 59, 1))),
              //       shape: MaterialStateProperty.all<
              //           RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //       ),
              //     ),
              //     child:Text("Check my Orders",
              //       style: GoogleFonts.gothicA1(
              //         color: Color.fromRGBO(255, 76, 59, 1),
              //         fontSize: 18,
              //         fontWeight: FontWeight.w700,
              //       ),),
              //     onPressed: (){
              //      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(c)=> BlocProvider(
              //        create: (BuildContext context) {
              //          return OrdersBloc(RealOrdersRepo())
              //            ..add(const GetOrders());
              //        },
              //        child: MyOrders(navigateToNext: _navigateToNext),
              //      ), ));
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        )).then((val)=>setState(() {
    }));
  }
}


// WillPopScope(
// onWillPop: () async {
// Navigator.of(context).popUntil((route) => route.isFirst);
// return false;)
