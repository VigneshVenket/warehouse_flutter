import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/currency/currency_bloc.dart';
import 'package:flutter_kundol/blocs/get_currencies/get_currency_bloc.dart';
import 'package:flutter_kundol/blocs/get_languages/get_language_bloc.dart';
import 'package:flutter_kundol/main.dart';

import '../tweaks/app_localization.dart';

class CurrenciesScreen extends StatefulWidget {
  @override
  _CurrenciesScreenState createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  late GetCurrenciesBloc currencyBloc;

  @override
  void initState() {
    super.initState();
    currencyBloc = BlocProvider.of<GetCurrenciesBloc>(context);
    currencyBloc.add(const GetCurrencies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Theme.of(context).brightness ==
              Brightness.dark
              ? Colors.white
              : Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.translate("Currencies")!,
          style: TextStyle( color: Theme.of(context).brightness ==
              Brightness.dark
            ? Colors.white
            : Colors.black,),),
        centerTitle: true,
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0.0,
      ),
      body: BlocBuilder(
        bloc: currencyBloc,
        builder: (BuildContext context, state1) {
          if (state1 is GetCurrencyLoaded) {
            return BlocBuilder<CurrencyBloc, CurrencyState>(
            // builder: (context, state) => ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       onTap: () {
            //         BlocProvider.of<CurrencyBloc>(context).add(
            //             CurrencySelected(state1
            //                 .currenciesResponse.data[index]));
            //         RestartWidget.restartApp(context);
            //       },
            //       title:
            //       Text(state1.currenciesResponse.data[index].title),
            //       titleMedium: Text(state1.currenciesResponse.data[index].code),
            //       trailing: Icon((state1.currenciesResponse.data[index].currencyId == state.currency.currencyId)
            //           ? Icons.radio_button_on
            //           : Icons.radio_button_off),
            //     );
            //   },
            //   itemCount: state1.currenciesResponse.data.length,
            // ),
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
                        return GestureDetector(
                          onTap: (){
                            BlocProvider.of<CurrencyBloc>(context).add(
                                CurrencySelected(state1
                                    .currenciesResponse.data![index]));
                            RestartWidget.restartApp(context);
                          },
                          child: state1.currenciesResponse.data![index].currencyId == state.currency.currencyId ?
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: Theme.of(context).primaryColor,
                            child: Text("${state1.currenciesResponse.data![index].title} (${state1.currenciesResponse.data![index].code})",style: const TextStyle(color: Colors.white),),
                          ): Container(
                            padding: const EdgeInsets.all(10),
                            child: Text("${state1.currenciesResponse.data![index].title} (${state1.currenciesResponse.data![index].code})"),
                          ),
                        );
                      },
                      itemCount: state1.currenciesResponse.data?.length,
                    ),
                  ),
                ),
              ),
          );
          } else if (state1 is GetLanguageError) {
            return Text(state1.error);
          } else {
            return  Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
