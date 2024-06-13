import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/profile/update_profile_bloc.dart';
import '../constants/app_constants.dart';
import '../constants/app_styles.dart';



class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPasswordController=TextEditingController();

  bool isEnabledPassword=true;
  bool isEnabledConfirmPassword=true;

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
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Change Password",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                autofocus: false,
                cursorColor: Color.fromRGBO(255, 76, 59, 1),
                obscureText: isEnabledPassword,
                controller: _passwordController,
                style: GoogleFonts.gothicA1(),
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
                    prefixIcon: Icon(
                        Icons.person_2_outlined,
                        size: 24,
                        color: Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                        Color.fromRGBO(0, 0, 0, 1)

                    ),
                    suffixIcon: isEnabledPassword?
                    IconButton(onPressed:(){
                          setState(() {
                            isEnabledPassword=!isEnabledPassword;
                          });
                         }, icon: Icon(Icons.visibility_off, color: Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(255,255,255,1):
                    Color.fromRGBO(0, 0, 0, 1))):
                    IconButton(onPressed:(){
                         setState(() {
                           isEnabledPassword=!isEnabledPassword;
                          });
                               }, icon: Icon(Icons.visibility, color: Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(255,255,255,1):
                    Color.fromRGBO(0, 0, 0, 1)))
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                autofocus: false,
                cursorColor: Color.fromRGBO(255, 76, 59, 1),
                obscureText: isEnabledConfirmPassword,
                controller: _confirmPasswordController,

                style: GoogleFonts.gothicA1(),
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
                    prefixIcon: Icon(
                        Icons.person_2_outlined,
                        size: 24,
                        color: Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(255,255,255,1):
                        Color.fromRGBO(0, 0, 0, 1)
                    ),
                    suffixIcon: isEnabledConfirmPassword?
                    IconButton(onPressed:(){
                      setState(() {
                        isEnabledConfirmPassword=!isEnabledConfirmPassword;
                      });
                    }, icon: Icon(Icons.visibility_off, color: Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(255,255,255,1):
                    Color.fromRGBO(0, 0, 0, 1))):
                    IconButton(onPressed:(){
                      setState(() {
                        isEnabledConfirmPassword=!isEnabledConfirmPassword;
                      });
                    }, icon: Icon(Icons.visibility, color: Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(255,255,255,1):
                    Color.fromRGBO(0, 0, 0, 1)))
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<ProfileBloc,ProfileState>(
              builder: (context,state) {
                return SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 76, 59,1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child:Text("Update Changes",style: GoogleFonts.gothicA1(
                        color: Color.fromRGBO(255, 255, 255, 1,),
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                    ),),
                    onPressed: (){
                            BlocProvider.of<ProfileBloc>(context).add(UpdateProfile
                              ( AppData.user!.firstName!,
                                AppData.user!.lastName!,
                                _passwordController.text,
                                _confirmPasswordController.text
                                ));
                    },
                  ),
                );
              },
              listener: (context, state) async {
                if(state is ProfileUpdated) {
                  AppConstants.showMessage(context,"Password changed successfully",Colors.green);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Changed Successfully")));
                }
                else if (state is ProfileError) {
                  AppConstants.showMessage(context,state.error,Colors.red);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
