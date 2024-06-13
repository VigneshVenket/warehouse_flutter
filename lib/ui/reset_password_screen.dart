import 'package:flutter/material.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_styles.dart';



class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController resetPasswordController=TextEditingController();
  TextEditingController resetConfirmPasswordController=TextEditingController();
  bool isPasswordEnabled=true;
  bool isConfirmPasswordEnabled=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
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
            "Reset Password",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Text("Enter new password and confirm.",
                textAlign: TextAlign.center,
                style:GoogleFonts.gothicA1(
                    color:Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(160, 160, 160,1):
                    Color.fromRGBO(112, 112, 112, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ) ,),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                obscureText: isPasswordEnabled,
                style: GoogleFonts.gothicA1(),
                autofocus: false,
                controller: resetPasswordController,
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
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText:"Password",
                    hintStyle: GoogleFonts.gothicA1(
                        color: Theme.of(context).brightness ==
                            Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 16),
                    prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 24,
                        color: Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                        Color.fromRGBO(0, 0, 0, 1)

                    ),
                    suffixIcon:isPasswordEnabled?
                    IconButton(onPressed:(){
                      setState(() {
                        isPasswordEnabled=!isPasswordEnabled;
                      });
                    }, icon: Icon(Icons.visibility_off)):
                    IconButton(onPressed:(){
                      setState(() {
                        isPasswordEnabled=!isPasswordEnabled;
                      });
                    }, icon: Icon(Icons.visibility))
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                obscureText: isConfirmPasswordEnabled,
                autofocus: false,
                style: GoogleFonts.gothicA1(),
                controller:resetConfirmPasswordController,
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
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText:"Confirm Password",
                    hintStyle: GoogleFonts.gothicA1(
                        color: Theme.of(context).brightness ==
                            Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 16),
                    prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 24,
                        color: Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                        Color.fromRGBO(0, 0, 0, 1)

                    ),
                    suffixIcon: isConfirmPasswordEnabled?
                    IconButton(onPressed:(){
                      setState(() {
                        isConfirmPasswordEnabled=!isConfirmPasswordEnabled;
                      });
                    }, icon: Icon(Icons.visibility_off)):
                    IconButton(onPressed:(){
                      setState(() {
                        isConfirmPasswordEnabled=!isConfirmPasswordEnabled;
                      });
                    }, icon: Icon(Icons.visibility))
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 45,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 76, 59,1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                child:Text("Change Password",
                  style: GoogleFonts.gothicA1(
                      color: Color.fromRGBO(255, 255, 255, 1,),
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),),
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>SignInScreen()), (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
