import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kundol/ui/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class AccountCreatedScreen extends StatefulWidget {
  const AccountCreatedScreen({Key? key}) : super(key: key);

  @override
  _AccountCreatedScreenState createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):
          Color.fromRGBO(255, 255,255,1),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset("assets/images/account_created_bg-removebg-preview.png",
             height: 350,
              width: 450,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 70,
            ),
            Text("Account Created",style: GoogleFonts.gothicA1(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):
              Color.fromRGBO(0, 0, 0, 1)
            ),),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text("Your account had been created successfully",
                textAlign: TextAlign.center,
                style:GoogleFonts.gothicA1(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness==Brightness.dark?
                      Color.fromRGBO(160, 160, 160,1):
                      Color.fromRGBO(112, 112, 112, 1)
                ) ,),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height*0.07,
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
                child:  Text("Shop Now",
                  style: GoogleFonts.gothicA1(
                      color: Color.fromRGBO(255, 255, 255, 1,),
                      fontSize: 18,
                      fontWeight:FontWeight.w600
                  ),),
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>MainScreen()), (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
