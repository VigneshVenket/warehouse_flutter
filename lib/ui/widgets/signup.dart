import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/check_email/check_email_bloc.dart';
import 'package:flutter_kundol/blocs/check_email/check_email_event.dart';
import 'package:flutter_kundol/blocs/check_email/check_email_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/ui/account_created_screen.dart';
import 'package:flutter_kundol/ui/me_fragment.dart';
import 'package:flutter_kundol/ui/verify_number_screnn.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../constants/app_data.dart';
import '../../constants/app_styles.dart';
import '../../tweaks/shared_pref_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController signUpFirstNameController = TextEditingController();
  TextEditingController signUpLastNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isEnabledPassword = true;
  bool isEnabledConfirmPassword = true;
  double tabletWidth = 700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      // body:
      // NestedScrollView(
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
      //       [
      //     SliverAppBar(
      //       // leading: IconButton(
      //       //   icon: Icon(Icons.arrow_back_ios,),
      //       //   onPressed: () {
      //       //     Navigator.pop(context);
      //       //   },
      //       // ),
      //       expandedHeight: 180,
      //       automaticallyImplyLeading: false,
      //       backgroundColor: Color.fromRGBO(128, 122, 122, 1.0),
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text(
      //           "SignUp",
      //           style: GoogleFonts.gothicA1(
      //               color: Colors.white,
      //               fontWeight: FontWeight.w700,
      //               fontSize: 24),
      //         ),
      //         titlePadding: EdgeInsets.fromLTRB(20, 0, 50, 45),
      //       ),
      //     )
      //   // ],
        body: BlocConsumer<EmailBloc, EmailState>(
          builder: (context, state) => SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(child: Stack(
                  children:[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.3,
                      child: Image.asset("assets/images/livecart_sigin_bg.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height*0.22,
                      left: MediaQuery.of(context).size.width*0.05,
                      child: Text("Sign Up",style: GoogleFonts.gothicA1(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white
                      ),),
                    )
                  ]

                )),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            style: GoogleFonts.gothicA1(),
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            controller: signUpFirstNameController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Color.fromRGBO(29, 29, 29, 1)
                                        : Color.fromRGBO(240, 240, 240, 1),
                                filled: true,
                                hintText: "First Name",
                                hintStyle:GoogleFonts.gothicA1(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 16),
                                prefixIcon: Icon(Icons.person_2_outlined,
                                    size: 24,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            style: GoogleFonts.gothicA1(),
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            controller: signUpLastNameController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Color.fromRGBO(29, 29, 29, 1)
                                        : Color.fromRGBO(240, 240, 240, 1),
                                filled: true,
                                // border: InputBorder.none,
                                hintText: "Last Name",
                                hintStyle: GoogleFonts.gothicA1(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 16),
                                prefixIcon: Icon(Icons.person_2_outlined,
                                    size: 24,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            style: GoogleFonts.gothicA1(),
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            controller: signUpEmailController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Color.fromRGBO(29, 29, 29, 1)
                                        : Color.fromRGBO(240, 240, 240, 1),
                                filled: true,
                                // border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: GoogleFonts.gothicA1(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 16),
                                prefixIcon: Icon(Icons.email_outlined,
                                    size: 24,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // SizedBox(
                        //   height: 68,
                        //   child: IntlPhoneField(
                        //     controller: signUpMobileNumberController,
                        //     dropdownIconPosition: IconPosition.trailing,
                        //     dropdownIcon: Icon(Icons.keyboard_arrow_down_outlined
                        //       , color: Theme.of(context).brightness ==
                        //             Brightness.dark?Color.fromRGBO(255,255,255,1):
                        //         Color.fromRGBO(0, 0, 0, 1),
                        //       size: 24,
                        //     ),
                        //     decoration: InputDecoration(
                        //         contentPadding: const EdgeInsets.symmetric(
                        //             vertical: 0, horizontal: 0),
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           borderSide: const BorderSide(
                        //             width: 0,
                        //             style: BorderStyle.none,
                        //           ),
                        //         ),
                        //         fillColor: Theme.of(context).brightness ==
                        //             Brightness.dark
                        //             ?  Color.fromRGBO(29, 29, 29, 1)
                        //             : Color.fromRGBO(240, 240, 240, 1),
                        //         filled: true,
                        //         // border: InputBorder.none,
                        //         hintText:"Enter Mobile Number",
                        //         hintStyle: TextStyle(
                        //             color: Theme.of(context).brightness ==
                        //                 Brightness.dark
                        //                 ? AppStyles.COLOR_GREY_DARK
                        //                 : AppStyles.COLOR_GREY_LIGHT,
                        //             fontSize: 18),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            obscureText: isEnabledPassword,
                            style: GoogleFonts.gothicA1(),
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            autofocus: false,
                            controller: signUpPasswordController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Color.fromRGBO(29, 29, 29, 1)
                                        : Color.fromRGBO(240, 240, 240, 1),
                                filled: true,
                                // border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: GoogleFonts.gothicA1(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 16),
                                prefixIcon: Icon(Icons.lock_outline,
                                    size: 24,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1)),
                                suffixIcon: isEnabledPassword
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEnabledPassword = !isEnabledPassword;
                                          });
                                        },
                                        icon: Icon(Icons.visibility_off,color: Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                                        Color.fromRGBO(0, 0, 0, 1)))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEnabledPassword = !isEnabledPassword;
                                          });
                                        },
                                        icon: Icon(Icons.visibility,color: Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                                        Color.fromRGBO(0, 0, 0, 1)))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            obscureText: isEnabledConfirmPassword,
                            style: GoogleFonts.gothicA1(),
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            autofocus: false,
                            controller: signUpConfirmPasswordController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? Color.fromRGBO(29, 29, 29, 1)
                                        : Color.fromRGBO(240, 240, 240, 1),
                                filled: true,
                                // border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: GoogleFonts.gothicA1(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 16),
                                prefixIcon: Icon(Icons.lock_outline,
                                    size: 24,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1)),
                                suffixIcon: isEnabledConfirmPassword
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEnabledConfirmPassword =
                                                !isEnabledConfirmPassword;
                                          });
                                        },
                                        icon: Icon(Icons.visibility_off,color: Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                                        Color.fromRGBO(0, 0, 0, 1)))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEnabledConfirmPassword =
                                                !isEnabledConfirmPassword;
                                          });
                                        },
                                        icon: Icon(Icons.visibility,color: Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                                        Color.fromRGBO(0, 0, 0, 1)))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            obscureText: false,
                            style: GoogleFonts.gothicA1(),
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            autofocus: false,
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            onEditingComplete: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (c) => VerifyPhoneNumberScreen())
                              // );
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Color.fromRGBO(29, 29, 29, 1)
                                      : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              hintText: "Phone Number",
                              hintStyle: GoogleFonts.gothicA1(
                                color:
                                    Theme.of(context).brightness == Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                fontSize: 16,
                              ),
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width *
                                            0.031),
                                    child: Icon(
                                      Icons.phone_android_outlined,
                                      size: 24,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                  // Text(
                                  //   "+91",
                                  //   style: TextStyle(
                                  //     color: Theme.of(context).brightness == Brightness.dark
                                  //         ? Color.fromRGBO(255, 255, 255, 1)
                                  //         : Color.fromRGBO(0, 0, 0, 1),
                                  //     fontSize: 18,
                                  //   ),
                                  // ),
                                ],
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isEnabledConfirmPassword =
                                        !isEnabledConfirmPassword;
                                  });
                                },
                                icon: Icon(
                                  Icons.warning_amber_rounded,
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark?Color.fromRGBO(255,255,255,1):
                                    Color.fromRGBO(0, 0, 0, 1)
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 25.0,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(255, 76, 59, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child:Text(
                              "Sign Up",
                              style: GoogleFonts.gothicA1(
                                  color: Color.fromRGBO(255, 255, 255, 1,),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            onPressed: () async {
                              // BlocProvider.of<AuthBloc>(context).add(
                              //     PerformRegister(
                              //         signUpFirstNameController.text,
                              //         signUpLastNameController.text,
                              //         signUpEmailController.text,
                              //         signUpPasswordController.text,
                              //         signUpConfirmPasswordController.text),);
                              

                              if(signUpFirstNameController.text.isNotEmpty&&signUpLastNameController.text.isNotEmpty&&
                                 signUpEmailController.text.isNotEmpty&&signUpPasswordController.text.isNotEmpty&&signUpConfirmPasswordController.text.isNotEmpty
                                &&phoneController.text.isNotEmpty
                              ){
                                  if(signUpPasswordController.text==signUpConfirmPasswordController.text){
                                        if(phoneController.text.length==10){
                                          BlocProvider.of<EmailBloc>(context).add(CheckEmail(email: signUpEmailController.text));
                                        }else{
                                          AppConstants.showMessage(context, "please enter valid phone number", Colors.red);
                                        }

                                  }else{
                                    AppConstants.showMessage(context, "password and confirm password must be same", Colors.red);
                                  }

                              }else{
                                AppConstants.showMessage(context, "Please check all the fields are filled", Colors.red);
                              }


                              // Navigator.of(context).push(
                              //   MaterialPageRoute(builder: (c)=>VerifyPhoneNumberScreen(
                              //       verificationId: "12345678",
                              //       phonenumber: "82483766660",
                              //       firstname: "anu",
                              //       lastname: "mitha",
                              //       email: "anu@gmail.com",
                              //       password: "123456",
                              //       confirmPasword: "123456"))
                              // );

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (c) => VerifyPhoneNumberScreen()));
                              // Navigator.of(context).push(MaterialPageRoute(builder:(c)=>AccountCreatedScreen()));
                              // BlocProvider.of<AuthBloc>(context).add(
                              //     PerformRegister(
                              //         signUpFirstNameController.text,
                              //         signUpLastNameController.text,
                              //         signUpEmailController.text,
                              //         signUpPasswordController.text,
                              //         signUpConfirmPasswordController.text));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // Center(
                        //   child: Text(
                        //     "___________or continue with___________",
                        //     style: GoogleFonts.gothicA1(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 16,
                        //         color:
                        //             Theme.of(context).brightness == Brightness.dark
                        //                 ? Color.fromRGBO(160, 160, 160, 1)
                        //                 : Color.fromRGBO(112, 112, 112, 1)),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Theme.of(context).brightness == Brightness.dark
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           // GestureDetector(
                        //           //     onTap: (){signInFB(context);},
                        //           //     child: Image.asset("assets/icons/Button - Facebook dark.png")),
                        //           SizedBox(
                        //             width: 20,
                        //           ),
                        //           GestureDetector(
                        //               onTap: () async {
                        //                 User? resp = await doGoogleLogin(context);
                        //                 if (resp!.uid.isNotEmpty) {
                        //                   print("User Name: ${resp!.displayName}");
                        //                   print("User Email ${resp.email}");
                        //                   //BlocProvider.of<AuthBloc>(context).add(PerformGoogleLogin(resp.tok!));
                        //                   BlocProvider.of<AuthBloc>(context).add(
                        //                       PerformRegister(
                        //                           resp!.displayName!,
                        //                           resp.displayName!,
                        //                           resp!.email!,
                        //                           "123456",
                        //                           "123456"));
                        //                 }
                        //               },
                        //               child: Image.asset(
                        //                   "assets/icons/Button - Google dark.png")),
                        //           SizedBox(
                        //             width: 20,
                        //           ),
                        //           // Image.asset("assets/icons/Button - Apple dark.png"),
                        //         ],
                        //       )
                        //     : Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           // GestureDetector(
                        //           //     onTap: (){signInFB(context);},
                        //           //     child: Image.asset("assets/icons/Button - Facebook.png")),
                        //           SizedBox(
                        //             width: 20,
                        //           ),
                        //           GestureDetector(
                        //               onTap: () async {
                        //                 User? resp = await doGoogleLogin(context);
                        //                 if (resp!.uid.isNotEmpty) {
                        //                   print("User Name: ${resp!.displayName}");
                        //                   print("User Email ${resp.email}");
                        //                   //BlocProvider.of<AuthBloc>(context).add(PerformGoogleLogin(resp.tok!));
                        //                   BlocProvider.of<AuthBloc>(context).add(
                        //                       PerformRegister(
                        //                           resp!.displayName!,
                        //                           resp.displayName!,
                        //                           resp!.email!,
                        //                           "123456",
                        //                           "123456"));
                        //                 }
                        //               },
                        //               child: Image.asset(
                        //                   "assets/icons/Button - Google.png")),
                        //           SizedBox(
                        //             width: 20,
                        //           ),
                        //           // Image.asset("assets/icons/Button - Apple.png"),
                        //         ],
                        //       ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Theme.of(context).brightness == Brightness.dark
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width <
                                            tabletWidth
                                        ?  MediaQuery.of(context).size.width*0.12
                                        : 240),
                                child: Row(
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(160, 160, 160, 1)),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (c) => SignInScreen()));
                                        },
                                        child: Text(
                                          "Sign in",
                                          style: GoogleFonts.gothicA1(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  Color.fromRGBO(255, 255, 255, 1)),
                                        ))
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width <
                                            tabletWidth
                                        ? MediaQuery.of(context).size.width * 0.12
                                        : 240),
                                child: Row(children: [
                                  Text(
                                    "Already have an account?",
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(112, 112, 112, 1)),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) => SignInScreen()));
                                      },
                                      child: Text(
                                        "Sign in",
                                        style:GoogleFonts.gothicA1(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      ))
                                ]),
                              )
                      ],
                    )),
              ],
            ),
          ),
          listener: (context, state) async {
            // if (state is AuthenticatedRegisterManual) {
            //   AppData.user = state.user;
            //   AppData.accessToken = state.user?.token;
            //
            //   // AppConstants.showMessage(context, state.message!,Colors.green);
            //
            //   // ScaffoldMessenger.of(context)
            //   //     .showSnackBar(SnackBar(content: Text(state.message!,style: GoogleFonts.gothicA1(),)));
            //   final sharedPrefService = await SharedPreferencesService.instance;
            //   await sharedPrefService.setUserID(state.user!.id!);
            //   await sharedPrefService.setUserFirstName(state.user!.firstName!);
            //   await sharedPrefService.setUserLastName(state.user!.lastName!);
            //   await sharedPrefService.setUserEmail(state.user!.email!);
            //   await sharedPrefService.setUserToken(state.user!.token!);
            //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   //   content: Text(
            //   //     state.message!,
            //   //     style: TextStyle(
            //   //         color: Color.fromRGBO(255, 255, 255, 1,
            //   //         ),
            //   //         fontSize: 14,
            //   //         fontWeight: FontWeight.w600),
            //   //   ),
            //   //   backgroundColor: Colors.green,
            //   // ));
            //   // Navigator.of(context).push(
            //   //     MaterialPageRoute(builder: (c) => VerifyPhoneNumberScreen()));
            // }
            // // else if (state is UnAuthenticated) {
            // //   AppData.user = null;
            // //   AppData.accessToken = null;
            // //
            // //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not Authenticated")));
            // // }
            // else if (state is AuthRegisterFailed) {
            //
            //   AppConstants.showMessage(context, state.message!, Colors.red);
            //
            //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   //   content: Text(
            //   //     state.message!,
            //   //     style: GoogleFonts.gothicA1(
            //   //         color: Color.fromRGBO(
            //   //           255,
            //   //           255,
            //   //           255,
            //   //           1,
            //   //         ),
            //   //         fontSize: 14,
            //   //         fontWeight: FontWeight.w600),
            //   //   ),
            //   //   backgroundColor: Colors.red,
            //   // ));
            // }
            if(state is EmailLoaded){
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: '+91${phoneController.text}',
                verificationCompleted:
                    (PhoneAuthCredential credential) {
                  print("Verification Completed: $credential");
                },
                verificationFailed: (FirebaseAuthException e) {
                  print("Verification Failed: ${e.message}");
                  // Handle verification failure
                },
                codeSent:
                    (String verificationId, int? resendToken) {
                  print("Code Sent: $verificationId");
                  // If verification is completed automatically, navigate to VerifyMobileScreen
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            VerifyPhoneNumberScreen(
                                verificationId: verificationId,
                                phonenumber: phoneController.text,
                                firstname:
                                    signUpFirstNameController.text,
                                lastname:
                                    signUpLastNameController.text,
                                email: signUpEmailController.text,
                                password:
                                    signUpPasswordController.text,
                                confirmPasword:
                                    signUpConfirmPasswordController
                                        .text)),
                          (route) => false
                  );
                  // Handle the situation when the code is sent, usually when user input is required
                  // For example, you can store `verificationId` in a variable for later use
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  print(
                      "Code Auto Retrieval Timeout: $verificationId");
                  // Handle code auto-retrieval timeout
                },
              );
              // AppConstants.showMessage(context, state.response.status!, Colors.green);
            }else if(state is EmailError) {
              AppConstants.showMessage(context, state.message, Colors.red);
            }
          },
        ),
    //   ),
    );
  }

  Future<User?> doGoogleLogin(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var resp = signInWithGoogle(context, googleSignIn, auth);
      return resp;
    } on Exception catch (error) {
      print(error);
    }
  }

  Future<User?> signInWithGoogle(BuildContext context,
      GoogleSignIn googleSignIn, FirebaseAuth auth) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    String? accessToken = googleSignInAuthentication.accessToken;

    print("Google AccessToken :  $accessToken");
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult = await auth.signInWithCredential(credential);
    if (authResult.user!.uid.isNotEmpty) {
      var _user = authResult.user;
      assert(!_user!.isAnonymous);
      assert(await _user!.getIdToken() != null);
      User currentUser = auth.currentUser!;
      await googleSignIn.signOut();
      return currentUser;
    }
  }

//BlocProvider.of<AuthBloc>(context).add(PerformGoogleLogin(accessToken!));//

  // void signInFB(BuildContext context) async {
  //   final fb = FacebookLogin();
  //   final res = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]
  //   );
  //   switch (res.status) {
  //     case FacebookLoginStatus.success:
  //       final FacebookAccessToken? accessToken = res.accessToken;
  //       print('Access token: ${accessToken?.token}');
  //       final profile = await fb.getUserProfile();
  //       print('Hello, ${profile?.name}! You ID: ${profile?.userId}');
  //       final imageUrl = await fb.getProfileImageUrl(width: 100);
  //       print('Your profile image: $imageUrl');
  //       final email = await fb.getUserEmail();
  //       if (email != null) print('And your email is $email');
  //
  //       BlocProvider.of<AuthBloc>(context)
  //           .add(PerformFacebookLogin(accessToken!.token));
  //
  //       print("ACCESS TOKEN = ${accessToken.token}");
  //
  //       break;
  //     case FacebookLoginStatus.cancel:
  //       break;
  //     case FacebookLoginStatus.error:
  //       print('Error while log in: ${res.error}');
  //       break;
  //   }
  // }
}
