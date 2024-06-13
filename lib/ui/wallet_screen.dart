import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_bloc.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_event.dart';
import 'package:flutter_kundol/blocs/wallet_total/total_bloc.dart';
import 'package:flutter_kundol/blocs/wallet_total/total_event.dart';
import 'package:flutter_kundol/models/wallet_data.dart';

import '../blocs/wallet/wallet_state.dart';
import '../blocs/wallet_total/total_state.dart';
import '../tweaks/app_localization.dart';

class WalletScreen extends StatefulWidget {

  const WalletScreen();

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<WalletScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WalletBloc>(context).add(GetWallet());
    BlocProvider.of<TotalBloc>(context).add(GetTotal());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
              AppLocalizations.of(context)!.translate("Wallet")!,
              style: Theme.of(context).textTheme.titleLarge),
          elevation: 0.0,
        ),

        body:
        SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<TotalBloc, TotalState>(
                builder: (context, state){
                  if(state is TotalLoaded){
                    return (
                      Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.totalData.length.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 2,),
                                  Text("total",style: TextStyle(fontSize: 16,),),
                                ],
                      )
                        // ListView.builder(
                        //     itemCount: 1,
                        //     itemBuilder: (BuildContext,index){
                        //       return Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text(state.totalData.length.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        //           SizedBox(width: 2,),
                        //           Text("total",style: TextStyle(fontSize: 16,),),
                        //         ],
                        //       );
                        //     }
                        // )
                      );
                  }
                  return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                },
              ),
              Column(
                children: [
                   SizedBox(height: 10,),
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state){
                  if(state is WalletLoaded){
                    return (
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: state.walletData.length,
                            itemBuilder: (BuildContext,index){
                              return
        DataTable( 
       //  headingTextStyle: TextStyle(fontSize:14,),
  // for Heading Text Style
  //dataTextStyle: TextStyle(fontSize: 0,),
          columnSpacing: 83,
                            headingRowHeight: 5, 
                            checkboxHorizontalMargin: 5,
                            horizontalMargin: 10,
                            dataRowHeight: double.parse('20'),
              columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                '',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                '',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                '',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
              ],
              rows:  <DataRow>[
          DataRow(
            
            cells: <DataCell>[
              DataCell(Text(state.walletData[index].date!,textAlign: TextAlign.left,),),
              DataCell(Text(state.walletData[index].description.toString(),textAlign: TextAlign.justify,),),
              DataCell(state.walletData[index].debitAmount == "0.00" ?
                                     Text("+"+state.walletData[index].creditAmount.toString()+"lei",style: TextStyle(color: Colors.blue),textAlign: TextAlign.left,) :
                                    Text("-"+state.walletData[index].debitAmount.toString()+"lei",style: TextStyle(color: Colors.red,),textAlign: TextAlign.left,),),
            ],
          ),
              ],
            );
                            //    Padding(
                            //     padding: const EdgeInsets.only(left: 10,right: 10),
                            //     child: Row(
                            //       children: [
                            //         Text(state.walletData[index].date!,textAlign: TextAlign.center,),
                            //         Spacer(),
                            //         Text(state.walletData[index].description.toString(),textAlign: TextAlign.center,),
                            //         Spacer(),
                            //         //Text(state.walletData[index].debitAmount.toString(),textAlign: TextAlign.center,),
                            //        // Spacer(),
                            //         //Text(state.walletData[index].creditAmount.toString(),textAlign: TextAlign.center,),
                            //         state.walletData[index].debitAmount == "0.00" ?
                            //         Text("+"+state.walletData[index].creditAmount.toString()+"lei",style: TextStyle(color: Colors.blue),) :
                            //         Text("-"+state.walletData[index].debitAmount.toString()+"lei",style: TextStyle(color: Colors.red),),
        
                            //       ],
                            //     ),
                            //  );
        
                            }
                        )
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                },
              ),
                ],
              ),  
            ],
            
          ),
        )

    );
  }
}
