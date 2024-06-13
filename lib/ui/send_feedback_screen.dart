import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/contact_us/contact_us_bloc.dart';
import '../constants/app_config.dart';
import '../constants/app_styles.dart';
import '../tweaks/app_localization.dart';


class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({Key? key}) : super(key: key);

  @override
  _SendFeedbackScreenState createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
            elevation: 0,
            backgroundColor: Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
            title: Text(
              "Feedback",style: GoogleFonts.gothicA1(
                color:Theme.of(context).brightness ==
                    Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
                fontSize: 18,
                fontWeight: FontWeight.w800
            ),
            )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
        child: BlocConsumer<ContactUsBloc, ContactUsState>
          (builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 45,
                child: TextField(
                  autofocus: false,
                  style: GoogleFonts.gothicA1(),
                  controller: _firstNameController,
                  cursorColor: Color.fromRGBO(255, 76, 55, 1),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_LITE_GREY_DARK
                          : AppStyles.COLOR_LITE_GREY_LIGHT,
                      filled: true,
                      // border: InputBorder.none,
                      hintText:
                      AppLocalizations.of(context)!.translate("First Name"),
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

                      )),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 45,
                child: TextField(
                  autofocus: false,
                  style:  GoogleFonts.gothicA1(),
                  controller: _lastNameController,
                  cursorColor: Color.fromRGBO(255, 76, 55, 1),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_LITE_GREY_DARK
                          : AppStyles.COLOR_LITE_GREY_LIGHT,
                      filled: true,
                      // border: InputBorder.none,
                      hintText:
                      AppLocalizations.of(context)!.translate("Last Name"),
                      hintStyle:  GoogleFonts.gothicA1(
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

                      )),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 45,
                child: TextField(
                  autofocus: false,
                  style:  GoogleFonts.gothicA1(),
                  cursorColor: Color.fromRGBO(255, 76, 55, 1),
                  controller: _emailController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_LITE_GREY_DARK
                          : AppStyles.COLOR_LITE_GREY_LIGHT,
                      filled: true,
                      // border: InputBorder.none,
                      hintText:
                      AppLocalizations.of(context)!.translate("Enter your email"),
                      hintStyle: GoogleFonts.gothicA1(
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
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                minLines: 5,
                maxLines: null,
                style:  GoogleFonts.gothicA1(),
                cursorColor: Color.fromRGBO(255, 76, 55, 1),
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                autofocus: false,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText:
                    AppLocalizations.of(context)!.translate("Your comment"),
                  hintStyle:  GoogleFonts.gothicA1(
                      color: Theme.of(context).brightness ==
                          Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                      fontSize: 16),),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 40.0,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 76, 59,1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    onPressed: () {
                      BlocProvider.of<ContactUsBloc>(context).add(
                          SubmitContactUs(
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailController.text,
                              _messageController.text));
                    },
                    child: Text(
                        AppLocalizations.of(context)!.translate("Submit")!,style:  GoogleFonts.gothicA1(
                        color: Color.fromRGBO(255, 255, 255, 1,),
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                    ),
                    )),
              ),
            ],
          );
        }, listener: (BuildContext context, state) {
          if (state is ContactUsLoaded) {

            AppConstants.showMessage(context, state.message, Colors.green);

            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ContactUsError) {
            AppConstants.showMessage(context, state.error, Colors.red);
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        ),
      )
    );
  }
}
