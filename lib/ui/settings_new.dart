import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/contact_us/contact_us_bloc.dart';
import 'package:flutter_kundol/repos/contact_us_repo.dart';
import 'package:flutter_kundol/ui/about_us_new.dart';
import 'package:flutter_kundol/ui/contact_screen.dart';
import 'package:flutter_kundol/ui/currency_new.dart';
import 'package:flutter_kundol/ui/faqs.dart';
import 'package:flutter_kundol/ui/notification_options.dart';
import 'package:flutter_kundol/ui/privacy_policy.dart';
import 'package:flutter_kundol/ui/send_feedback_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/page/page_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../repos/pages_repo.dart';
import 'content_screen.dart';



class SettingsNew extends StatefulWidget {
  const SettingsNew({Key? key}) : super(key: key);

  @override
  _SettingsNewState createState() => _SettingsNewState();
}

class _SettingsNewState extends State<SettingsNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0,0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Settings",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),
      
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            // ListTile(
            //   leading: Container(
            //       width: 48,
            //       height: 48,
            //       decoration: BoxDecoration(
            //           color: Color.fromRGBO(255, 76, 59,0.1),
            //           borderRadius: BorderRadius.circular(10)
            //       ),
            //       child: Image.asset("assets/images/Icon notifiy settings.png",width: 24,height: 24,)),
            //   title: Text("Notification Options",style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w700,
            //     color:Theme.of(context).brightness==Brightness.dark?
            //     Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
            //   ),),
            //   trailing: Icon(Icons.arrow_forward_ios_outlined,
            //     size: 16,
            //     color:Theme.of(context).brightness==Brightness.dark?
            //     Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
            //   onTap: (){
            //     Navigator.of(context).push(MaterialPageRoute(builder: (c)=>NotificationOptions()));
            //   },
            // ),
            // Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            // ListTile(
            //   leading: Container(
            //       width: 48,
            //       height: 48,
            //       decoration: BoxDecoration(
            //           color: Color.fromRGBO(255, 76, 59,0.1),
            //           borderRadius: BorderRadius.circular(10)
            //       ),
            //       child: Image.asset("assets/images/Icon currency settings.png",width: 24,height: 24,)),
            //   title: Text("Currency",style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w700,
            //     color:Theme.of(context).brightness==Brightness.dark?
            //     Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
            //   ),),
            //   trailing: Icon(Icons.arrow_forward_ios_outlined,
            //     size: 16,
            //     color:Theme.of(context).brightness==Brightness.dark?
            //     Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
            //   onTap: (){
            //     Navigator.of(context).push(MaterialPageRoute(builder: (c)=>CurrencyNew()));
            //   },
            // ),
            // Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            ListTile(
              leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 76, 59,0.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset("assets/images/Icon aboutus settings.png",width: 24,height: 24,)),
              title: Text("About Us",style: GoogleFonts.gothicA1(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
              ),),
              trailing: Icon(Icons.arrow_forward_ios_outlined,
                size: 16,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
              onTap: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (c)=>AboutUsNew()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (BuildContext context) {
                            return GetPageBloc(RealPageRepo());
                          },
                          child:  ContentScreen(1)),
                    ));
              },
            ),
            SizedBox(
              height: 15,
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 76, 59,0.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset("assets/images/Icon privacy settings.png",width: 24,height: 24,)),
              title: Text("Privacy Policy",style: GoogleFonts.gothicA1(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
              ),),
              trailing: Icon(Icons.arrow_forward_ios_outlined,
                size: 16,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
              onTap: (){
                // Navigator.of(context).push(MaterialPageRoute(builder:(c)=>PrivacyPolicy()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (BuildContext context) {
                            return GetPageBloc(RealPageRepo());
                          },
                          child: ContentScreen(3)),
                    ));
              },
            ),
            SizedBox(
              height: 15,
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 76, 59,0.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Icon(Icons.receipt_outlined,size: 24,color: Color.fromRGBO(255, 76, 59, 1),)
              ),
              title: Text("Refund Policy",style: GoogleFonts.gothicA1(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
              ),),
              trailing: Icon(Icons.arrow_forward_ios_outlined,
                size: 16,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (BuildContext context) {
                            return GetPageBloc(RealPageRepo());
                          },
                          child:  ContentScreen(2)),
                    ));
                // Navigator.of(context).push(MaterialPageRoute(builder: (c)=>FaqsScreen()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 76, 59,0.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset("assets/images/Icon faq settings.png",width: 24,height: 24,)),
              title: Text("Terms and Conditions",style: GoogleFonts.gothicA1(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
              ),),
              trailing: Icon(Icons.arrow_forward_ios_outlined,
                size: 16,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (BuildContext context) {
                            return GetPageBloc(RealPageRepo());
                          },
                          child:  ContentScreen(4)),
                    ));
                // Navigator.of(context).push(MaterialPageRoute(builder: (c)=>FaqsScreen()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 76, 59,0.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:
                  Image.asset("assets/images/Icon feedback settings.png",width: 24,height: 24,)),
              title: Text("Send Feedback",style:GoogleFonts.gothicA1(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
              ),),
              trailing: Icon(Icons.arrow_forward_ios_outlined,
                size: 16,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=> BlocProvider(
                    create: (BuildContext context) {
                      return ContactUsBloc(RealContactUsRepo());
                    },
                    child: SendFeedbackScreen()),
                ));
              },
            ),
            SizedBox(
              height: 15,
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 76, 59,0.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset("assets/images/Icon contact settings.png",width: 24,height: 24,)),
              title: Text("Contact Us",style: GoogleFonts.gothicA1(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
              ),),
              trailing: Icon(Icons.arrow_forward_ios_outlined,
                size: 16,
                color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(c)=>ContactUsScreen()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            // BlocBuilder<ThemeBloc, ThemeState>(
            //   builder: (context,state) =>SwitchListTile(
            //       value: state.themeData.brightness == Brightness.dark
            //           ? true
            //           : false,
            //       inactiveTrackColor: state.themeData.brightness==Brightness.dark?
            //       Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),
            //        trackOutlineColor: state.themeData.brightness == Brightness.dark?
            //        MaterialStatePropertyAll(Color.fromRGBO(160, 160, 160, 1)):
            //        MaterialStatePropertyAll(Color.fromRGBO(112, 112, 112, 1)),
            //        thumbColor: MaterialStatePropertyAll(Color.fromRGBO(240, 240, 240, 1)),
            //       activeColor: Color.fromRGBO(74, 222, 128, 1.0),
            //       secondary:Container(
            //           width: 48,
            //           height: 48,
            //           decoration: BoxDecoration(
            //               color: Color.fromRGBO(255, 76, 59,0.1),
            //               borderRadius: BorderRadius.circular(10)
            //           ),
            //           child: Image.asset("assets/images/Icon mode settings.png",width: 24,height: 24,)) ,
            //       title: Text("Dark Mode",style: GoogleFonts.gothicA1(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w700,
            //         color:Theme.of(context).brightness==Brightness.dark?
            //         Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
            //       ),),
            //       onChanged: (value){
            //         BlocProvider.of<ThemeBloc>(context)
            //             .add(ThemeModeChanged(value));
            //       }),
            //
            // ),
            // Divider(thickness: .8,endIndent: 20.0,indent: 15,),
          ],
        ),
      ),
    );
  }
}
