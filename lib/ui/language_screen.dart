import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/get_languages/get_language_bloc.dart';
import 'package:flutter_kundol/blocs/language/language_bloc.dart';

import '../main.dart';
import '../tweaks/app_localization.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  late GetLanguageBloc languageBloc;

  @override
  void initState() {
    super.initState();
    languageBloc = BlocProvider.of<GetLanguageBloc>(context);
    languageBloc.add(const GetLanguages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Theme.of(context).brightness ==
              Brightness.dark
              ? Colors.white
              : Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.translate("Languages")!,
          style: TextStyle( color: Theme.of(context).brightness ==
              Brightness.dark
            ? Colors.white
            : Colors.black,),),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0.0,
      ),
      body: BlocBuilder(
        bloc: languageBloc,
        builder: (BuildContext context, state1) {
          if (state1 is GetLanguageLoaded) {
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) => Container(
                margin: const EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: double.maxFinite,
                    color:  Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor :  Colors.white,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // return ListTile(
                        //   onTap: () {
                        //     BlocProvider.of<LanguageBloc>(context).add(
                        //         LanguageSelected(state1
                        //             .languageResponse.data[index]));
                        //     RestartWidget.restartApp(context);
                        //   },
                        //   title:
                        //       Text(state1.languageResponse.data[index].languageName),
                        //   titleMedium: Text(state1.languageResponse.data[index].code),
                        //   trailing: Icon((state1.languageResponse.data[index].code.toLowerCase().trim() == state.languageData.code)
                        //       ? Icons.radio_button_on
                        //       : Icons.radio_button_off),
                        // );
                        return GestureDetector(
                          onTap: (){
                            BlocProvider.of<LanguageBloc>(context).add(
                                LanguageSelected(state1
                                    .languageResponse.data![index]));
                            RestartWidget.restartApp(context);
                          },
                          child: state1.languageResponse.data![index].code?.toLowerCase().trim() == state.languageData.code?.toLowerCase().trim()  ?
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: Theme.of(context).primaryColor,
                            child: Text("${state1.languageResponse.data![index].languageName} (${state1.languageResponse.data![index].code})",style: const TextStyle(color: Colors.white),),
                          ): Container(
                            padding: const EdgeInsets.all(10),
                            child: Text("${state1.languageResponse.data![index].languageName} (${state1.languageResponse.data![index].code})"),
                          ),
                        );
                      },
                      itemCount: state1.languageResponse.data?.length,
                    ),
                  ),
                ),
              ),
            );
          } else if (state1 is GetLanguageError) {
            return Text(state1.error);
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
