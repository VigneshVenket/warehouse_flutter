import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/ui/reset_password_screen.dart';
import 'package:flutter_kundol/ui/verify_number_screnn.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tweaks/app_localization.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController signInEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
        appBar:
        AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
                "Forgot Password",style:GoogleFonts.gothicA1(
            color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
            fontSize: 18,
            fontWeight: FontWeight.w800
          ),
        )),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Text("Enter the email associated with your account and "
                    "we’ll send an email with instructions to reset your password",
                  textAlign: TextAlign.center,
                  style:GoogleFonts.gothicA1(
                    color:Theme.of(context).brightness ==
                      Brightness.dark?Color.fromRGBO(160, 160, 160,1):
                    Color.fromRGBO(112, 112, 112, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ) ,),

              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  autofocus: false,
                  style: GoogleFonts.gothicA1(),
                  controller: signInEmailController,
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
                      fillColor: Theme.of(context).brightness ==
                          Brightness.dark
                          ?  Color.fromRGBO(29, 29, 29, 1)
                          : Color.fromRGBO(240, 240, 240, 1.0),
                      filled: true,
                      // border: InputBorder.none,
                      hintText:"Email",
                      hintStyle:GoogleFonts.gothicA1(
                          color: Theme.of(context).brightness ==
                              Brightness.dark
                              ? AppStyles.COLOR_GREY_DARK
                              : AppStyles.COLOR_GREY_LIGHT,
                          fontSize: 16),
                      prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 24,
                          color: Theme.of(context).brightness ==
                              Brightness.dark?Color.fromRGBO(255,255,255,1):
                          Color.fromRGBO(0, 0, 0, 1)

                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 50.0,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 76, 59, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    onPressed: () {
                      // if (signInEmailController.text.isNotEmpty) {
                      //   BlocProvider.of<AuthBloc>(context).add(
                      //       PerformForgotPassword(signInEmailController.text.trim())
                      //   );
                      // }
                      Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ResetPasswordScreen()));
                    },
                    child:Text("Send Instructions",
                      style: GoogleFonts.gothicA1(
                      color: Color.fromRGBO(255, 255, 255, 1,),
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                ))
                    ),
              ),
            ),
          ],
        ));
  }
}
