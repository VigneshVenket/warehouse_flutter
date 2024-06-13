import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/language/language_bloc.dart';
import 'package:flutter_kundol/blocs/page/page_bloc.dart';
import 'package:flutter_kundol/blocs/theme/theme_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../tweaks/app_localization.dart';

class ContentScreen extends StatefulWidget {
  final int pageNo;

  ContentScreen(this.pageNo);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  String title = "";

  @override
  void initState() {
    super.initState();
    switch (widget.pageNo) {
      case 1:
        title ="About US";
        break;
      case 2:
        title ="Refund Policy";
        break;
      case 3:
        title ="Privacy Policy";
        break;
      case 4:
        title ="Terms & Conditions";
        break;
    }
    BlocProvider.of<GetPageBloc>(context).add(GetPage(widget.pageNo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0,0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).brightness == Brightness.dark
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromRGBO(18, 18, 18, 1),),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(title,style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),
      body: SingleChildScrollView(
        child: BlocBuilder<GetPageBloc, PageState>(
          builder: (context, state) {

            if (state is GetPageLoaded) {
              return Html(data: state.pageResponse.data!.detail!.first.description,

              );

            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 76, 59, 1),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
