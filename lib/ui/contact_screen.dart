import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/contact_us/contact_us_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_styles.dart';

import '../tweaks/app_localization.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // final TextEditingController _messageController = TextEditingController();
  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
        // appBar: AppConfig.APP_BAR_COLOR == 2 ?
        // AppBar(
        //   centerTitle: true,
        //   iconTheme: Theme.of(context).iconTheme,
        //   backgroundColor: Theme.of(context).cardColor,
        //   title:
        //   Text(
        //       AppLocalizations.of(context)!.translate("Contact Us")!,
        //       style: Theme.of(context).textTheme.titleLarge),
        //   elevation: 0.0,
        // ):
        //     AppConfig.APP_BAR_COLOR == 1 ?
        // AppBar(
        //   centerTitle: true,
        //   iconTheme: IconThemeData(color: Colors.white),
        //   backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
        //   title:
        //   Text(
        //       AppLocalizations.of(context)!.translate("Contact Us")!,
        //       style: TextStyle(color:Colors.white)
        //   ),
        //   elevation: 0.0,
        // ):
        // AppConfig.APP_BAR_COLOR == 3 ?
        // AppBar(
        //   centerTitle: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).brightness ==
        //         Brightness.dark
        //         ? Colors.white
        //         : Colors.black,),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   iconTheme: Theme.of(context).iconTheme,
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   title:
        //   Text("Contact Us", style: Theme.of(context).textTheme.titleLarge),
        //   elevation: 0.0,
        // ):null,
        // body: Padding(
        //   padding: const EdgeInsets.symmetric(
        //       vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
        //       horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
        //   child: BlocConsumer<ContactUsBloc, ContactUsState>
        //     (builder: (context, state) {
        //     return Column(
        //       children: [
        //         SizedBox(
        //           height: 45,
        //           child: TextField(
        //             autofocus: false,
        //             controller: _firstNameController,
        //             decoration: InputDecoration(
        //                 contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        //                 border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(20),
        //                   borderSide: const BorderSide(
        //                     width: 0,
        //                     style: BorderStyle.none,
        //                   ),
        //                 ),
        //                 fillColor: Theme.of(context).brightness == Brightness.dark
        //                     ? AppStyles.COLOR_LITE_GREY_DARK
        //                     : AppStyles.COLOR_LITE_GREY_LIGHT,
        //                 filled: true,
        //                 // border: InputBorder.none,
        //                 hintText:
        //                 AppLocalizations.of(context)!.translate("First Name"),
        //                 hintStyle: TextStyle(
        //                     color: Theme.of(context).brightness == Brightness.dark
        //                         ? AppStyles.COLOR_GREY_DARK
        //                         : AppStyles.COLOR_GREY_LIGHT,
        //                     fontSize: 14),
        //                 prefixIcon: const Icon(
        //                   Icons.person_outline,
        //                 )),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 6.0,
        //         ),
        //         SizedBox(
        //           height: 45,
        //           child: TextField(
        //             autofocus: false,
        //             controller: _lastNameController,
        //             decoration: InputDecoration(
        //                 contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        //                 border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(40),
        //                   borderSide: const BorderSide(
        //                     width: 0,
        //                     style: BorderStyle.none,
        //                   ),
        //                 ),
        //                 fillColor: Theme.of(context).brightness == Brightness.dark
        //                     ? AppStyles.COLOR_LITE_GREY_DARK
        //                     : AppStyles.COLOR_LITE_GREY_LIGHT,
        //                 filled: true,
        //                 // border: InputBorder.none,
        //                 hintText:
        //                 AppLocalizations.of(context)!.translate("Last Name"),
        //                 hintStyle: TextStyle(
        //                     color: Theme.of(context).brightness == Brightness.dark
        //                         ? AppStyles.COLOR_GREY_DARK
        //                         : AppStyles.COLOR_GREY_LIGHT,
        //                     fontSize: 14),
        //                 prefixIcon: const Icon(
        //                   Icons.person_outline,
        //                 )),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 6.0,
        //         ),
        //         SizedBox(
        //           height: 45,
        //           child: TextField(
        //             autofocus: false,
        //             controller: _emailController,
        //             decoration: InputDecoration(
        //                 contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        //                 border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(40),
        //                   borderSide: const BorderSide(
        //                     width: 0,
        //                     style: BorderStyle.none,
        //                   ),
        //                 ),
        //                 fillColor: Theme.of(context).brightness == Brightness.dark
        //                     ? AppStyles.COLOR_LITE_GREY_DARK
        //                     : AppStyles.COLOR_LITE_GREY_LIGHT,
        //                 filled: true,
        //                 // border: InputBorder.none,
        //                 hintText:
        //                 AppLocalizations.of(context)!.translate("Enter your email"),
        //                 hintStyle: TextStyle(
        //                     color: Theme.of(context).brightness == Brightness.dark
        //                         ? AppStyles.COLOR_GREY_DARK
        //                         : AppStyles.COLOR_GREY_LIGHT,
        //                     fontSize: 14),
        //                 prefixIcon: const Icon(
        //                   Icons.email_outlined,
        //                 )),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 6.0,
        //         ),
        //         TextField(
        //           minLines: 5,
        //           maxLines: null,
        //           controller: _messageController,
        //           keyboardType: TextInputType.multiline,
        //           autofocus: false,
        //           decoration: InputDecoration(
        //               contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(20),
        //                 borderSide: const BorderSide(
        //                   width: 0,
        //                   style: BorderStyle.none,
        //                 ),
        //               ),
        //               fillColor: Theme.of(context).brightness == Brightness.dark
        //                   ? AppStyles.COLOR_LITE_GREY_DARK
        //                   : AppStyles.COLOR_LITE_GREY_LIGHT,
        //               filled: true,
        //               // border: InputBorder.none,
        //               hintText:
        //               AppLocalizations.of(context)!.translate("Your comment"),
        //               hintStyle: TextStyle(
        //                   color: Theme.of(context).brightness == Brightness.dark
        //                       ? AppStyles.COLOR_GREY_DARK
        //                       : AppStyles.COLOR_GREY_LIGHT,
        //                   fontSize: 14)),
        //         ),
        //         const SizedBox(
        //           height: 6.0,
        //         ),
        //         SizedBox(
        //           height: 40.0,
        //           width: double.maxFinite,
        //           child: ElevatedButton(
        //               style: ButtonStyle(
        //                 //  backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),
        //                 //color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
        //                 backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
        //                 elevation: MaterialStateProperty.all(0),
        //                 shape: MaterialStateProperty.all<
        //                     RoundedRectangleBorder>(
        //                   RoundedRectangleBorder(
        //                     borderRadius:
        //                     BorderRadius.circular(
        //                         18.0),
        //                   ),
        //                 ),
        //               ),
        //               onPressed: () {
        //                 BlocProvider.of<ContactUsBloc>(context).add(
        //                     SubmitContactUs(
        //                         _firstNameController.text,
        //                         _lastNameController.text,
        //                         _emailController.text,
        //                         _messageController.text));
        //               },
        //               child: Text(
        //                   AppLocalizations.of(context)!.translate("Submit")!
        //               )),
        //         ),
        //       ],
        //     );
        //   }, listener: (BuildContext context, state) {
        //     if (state is ContactUsLoaded) {
        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        //     } else if (state is ContactUsError) {
        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        //     }
        //   },
        //   ),
        // )


      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Contact Us",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 320,
              child: Image.asset("assets/images/contact_bg-removebg-preview.png",fit: BoxFit.fill,),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Contact Us",style: GoogleFonts.gothicA1(
                color: Theme.of(context).brightness==Brightness.dark?
                      Color.fromRGBO(255, 255, 255, 1):
                     Color.fromRGBO(0, 0, 0, 1),
              fontSize: 28,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(
              height: 10,
            ),
            Text("If you face any trouble for item ordering feel free to contact us.",
              textAlign: TextAlign.center,
              style: GoogleFonts.gothicA1(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
              ),
            ),
            SizedBox(
              height: 20,
            ),
           GestureDetector(
             onTap: (){_launchPhoneCall("888 - 963 - 600");},
             child: Container(
               width: double.maxFinite,
               height: 45,
               decoration: BoxDecoration(
                 color: Color.fromRGBO(255, 76, 59, 0.1),
                 borderRadius: BorderRadius.circular(10)
               ),
               child: ListTile(
                 leading: Image.asset("assets/images/Icon contact mobile.png",width: 24,height: 24,),
                 title: Text("888 - 963 - 600",style: GoogleFonts.gothicA1(
                   color: Theme.of(context).brightness==Brightness.dark?
                       Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                   fontSize: 16,
                   fontWeight: FontWeight.w600
                 ),),
               )
             ),
           ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){_launchEmail("bussiness@email.com");},
              child: Container(
                  width: double.maxFinite,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 76, 59, 0.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    leading: Image.asset("assets/images/Icon contact email.png",width: 24,height: 24,),
                    title: Text("bussiness@email.com",style: GoogleFonts.gothicA1(
                        color: Theme.of(context).brightness==Brightness.dark?
                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                  )
              ),
            ),
          ],
        ),
      ),
        );
  }

  void _launchPhoneCall(String phoneNumber) async {
    final Uri phoneCallUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneCallUri)) {
      await launchUrl(phoneCallUri);
    } else {
      throw 'Could not launch $phoneCallUri';
    }
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      // Handle the case where the URL can't be launched
      print('Error: Could not launch $emailLaunchUri');
    }
  }
}
