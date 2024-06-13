import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/ui/account_created_screen.dart';
import 'package:flutter_kundol/ui/reset_password_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../constants/app_constants.dart';
import '../constants/app_data.dart';
import '../constants/app_styles.dart';
import '../tweaks/shared_pref_service.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {

  String verificationId;
  String phonenumber;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String confirmPasword;

  VerifyPhoneNumberScreen(
      {Key? key,
      required this.verificationId,
      required this.phonenumber,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.confirmPasword})
      : super(key: key);

  @override
  _VerifyPhoneNumberScreenState createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  TextEditingController pinController = TextEditingController();
  int verificationSeconds = 60;
  late Timer timer;
  bool isClicked = false;

  void initState() {
    super.initState();
    startTimer();
    setState(() {
      isClicked = true;
      verificationSeconds = 60;
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (verificationSeconds > 0) {
          verificationSeconds--;
        } else {
          timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(0, 0, 0, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color.fromRGBO(18, 18, 18, 1)
                : Color.fromRGBO(255, 255, 255, 1),
            title: Text(
              "Verify Phone Number",
              style: GoogleFonts.gothicA1(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(18, 18, 18, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            )),
        body: BlocListener<AuthBloc,AuthState>(
          listener:(context,state) async{
            if (state is AuthenticatedRegisterManual) {
              AppData.user = state.user;
              AppData.accessToken = state.user?.token;

              final sharedPrefService = await SharedPreferencesService.instance;
              await sharedPrefService.setUserID(state.user!.id!);
              await sharedPrefService.setUserFirstName(state.user!.firstName!);
              await sharedPrefService.setUserLastName(state.user!.lastName!);
              await sharedPrefService.setUserEmail(state.user!.email!);
              await sharedPrefService.setUserToken(state.user!.token!);

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => AccountCreatedScreen()), (route) => false);

            }  else if (state is AuthRegisterFailed) {
              AppConstants.showMessage(context, state.message!, Colors.red);

            }
          } ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      "Please enter the verification code we sent to your mobile",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gothicA1(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  controller: pinController,
                  defaultPinTheme: PinTheme(
                      width: 48,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(43, 43, 43, 1.0)
                                  : Color.fromRGBO(211, 211, 211, 1.0)))),
                  focusedPinTheme: PinTheme(
                      width: 48,
                      height: 60,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Color.fromRGBO(255, 76, 59, 1)))),
                  submittedPinTheme: PinTheme(
                      width: 48,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(29, 29, 29, 1)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Not yet get?",
                      style: GoogleFonts.gothicA1(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91${widget.phonenumber}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              print("Verification Completed: $credential");
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              print("Verification Failed: ${e.message}");
                              // Handle verification failure
                            },
                            codeSent: (String verificationId, int? resendToken) {
                              print("Code Sent: $verificationId");
                              // If verification is completed automatically, navigate to VerifyMobileScreen
                              widget.verificationId = verificationId;
                              // Handle the situation when the code is sent, usually when user input is required
                              // For example, you can store `verificationId` in a variable for later use
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              print(
                                  "Code Auto Retrieval Timeout: $verificationId");
                              // Handle code auto-retrieval timeout
                            },
                          );
                        },
                        child: Text(
                          "Resend OTP",
                          style: GoogleFonts.gothicA1(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(0, 0, 0, 1)),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: 45,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 76, 59, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Verify",
                        style: GoogleFonts.gothicA1(
                            color: const Color.fromRGBO(255, 255, 255, 1,),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),

                      onPressed: ()  async{

                      try{
                        FirebaseAuth auth = FirebaseAuth.instance;
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: pinController.text);
                        UserCredential authresult = await auth.signInWithCredential(credential);
                        User user = authresult.user!;
                        if (authresult.user!.uid.isNotEmpty) {
                          BlocProvider.of<AuthBloc>(context).add(PerformRegister(
                              widget.firstname,
                              widget.lastname,
                              widget.email,
                              widget.password,
                              widget.confirmPasword,
                              widget.phonenumber
                          ));

                        }else{
                          AppConstants.showMessage(context,"Please enter valid otp",Colors.red);
                        }
                      }catch(e){
                        print(e.toString());
                        int startIndex = e.toString().indexOf("The");
                        String extractedText = e.toString().substring(startIndex);
                        AppConstants.showMessage(context,extractedText,Colors.red);
                      }




                        // Navigator.of(context).push(MaterialPageRoute(builder: (c) => AccountCreatedScreen()));
                        // Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ResetPasswordScreen()));
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        )

    );
  }
}
