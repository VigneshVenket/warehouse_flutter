import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:google_fonts/google_fonts.dart';

import '../tweaks/shared_pref_service.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
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
            icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Log Out",style: GoogleFonts.gothicA1(
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
              child: Image.asset("assets/images/logout_warehouse_bg-removebg-preview.png",fit: BoxFit.fill,),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Are you sure you want to log out?",
              textAlign: TextAlign.center,
              style: GoogleFonts.gothicA1(color:Theme.of(context).brightness==Brightness.dark?
              Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                fontSize: 28,
                fontWeight: FontWeight.w700
              ),),
            SizedBox(
              height: 50,
            ),
            BlocConsumer<AuthBloc,AuthState>(
              builder: (cotext,state) {
                return SizedBox(
                  height: 40,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
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
                    child: Text("Sure",
                      style: GoogleFonts.gothicA1(
                        color: Color.fromRGBO(255, 76, 59, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),),
                    onPressed: (){
                      BlocProvider.of<AuthBloc>(context).add(PerformLogout());
                    },
                  ),
                );
              },
              listener: (context, state) async{
              if (state is UnAuthenticated) {
                final sharedPrefService = await SharedPreferencesService.instance;
                await sharedPrefService.logoutUser();

                // AppConstants.showMessage(context,"Logout successfully", Colors.green);

                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text("Logout Successfully",style: GoogleFonts.gothicA1(
                //         color: Color.fromRGBO(255, 255, 255, 1,),
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700
                //     ),),backgroundColor: Colors.green,),);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>SignInScreen()),(route)=>false);
              }
            },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
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
                child:Text("Cancel",
                  style:GoogleFonts.gothicA1(
                    color: Color.fromRGBO(255, 76, 59, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
