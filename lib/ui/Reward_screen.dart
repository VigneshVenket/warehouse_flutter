import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/reward_des/reward_des_bloc.dart';
import 'package:flutter_kundol/blocs/rewards/rewards_bloc.dart';
import 'package:flutter_kundol/blocs/rewards/rewards_event.dart';
import 'package:flutter_kundol/blocs/rewards/rewards_state.dart';
import 'package:intl/intl.dart';
import '../blocs/reward_des/reward_des_event.dart';
import '../blocs/reward_des/reward_des_state.dart';
class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RewardnBloc>(context).add(GetRewardn());
    BlocProvider.of<RewarddesBloc>(context).add(GetRewarddes());
  }
 // DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white30,
        centerTitle: true,
        elevation: 0,
        title: Text("Reward Screen",style: TextStyle(color: Colors.black),),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              BlocBuilder<RewardnBloc, RewardnState>(
                builder: (context, state){
                  if(state is RewardnLoaded){
                    return (
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (BuildContext,index){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.rewardnData.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 2,),
                                  Text("points")
                                ],
                              );
                            }
                        )
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                },
              ),
              SizedBox(height: 15,),

            BlocBuilder<RewarddesBloc, RewarddesState>(
            builder: (context, state1){
             if(state1 is RewarddesLoaded){
             return (
             ListView.builder(
               physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:state1.rewarddesData.length,
            itemBuilder: (BuildContext,index){
            return Column(
            children: [
            Row(
              children: [
                Icon(Icons.wallet_giftcard_outlined),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 80,
                  child: Card(
                    color: Colors.white70,
                    elevation: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 8,top: 8),
                          child: Row(
                            children: [
                              Text(state1.rewarddesData[index].description.toString()
                              ),
                              Spacer(),
                              Text(state1.rewarddesData[index].points.toString(),style: TextStyle(color: Colors.red),),
                            ],
                            
                          ),
                        ),
                        SizedBox(height: 20,),
                       Text(formattedDate),
                       // Text(dateTime.toString()),
                      ],
                    ),
                  ),
                  ),
                ),
              ],
            )
  ]);
}
)
);
}
return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
},
),
            ],
          ),
        ),
      )
    );
  }
}















// import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
// import 'package:flutter_kundol/blocs/reward_points/reward_bloc.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/reward/reward_point.dart';
//
// import '../constants/app_config.dart';
// import '../tweaks/app_localization.dart';
//
// class RewardScreen extends StatefulWidget {
//   @override
//   _RewardScreenState createState() => _RewardScreenState();
// }
//
// class _RewardScreenState extends State<RewardScreen> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<RewardBloc>(context).add(const GetRewardPoints());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//      Widget? mainWidget;
//     return Scaffold(
//       body: BlocConsumer<RewardBloc, RewardState>(
//         builder: (context, state) {
//           if (state is RewardLoaded) {
//             double points = 0.0;
//             for (int i=0; i<state.rewardPointsResponse.data!.length; i++){
//               points += double.parse(state.rewardPointsResponse.data![i].points.toString());
//             }
//             mainWidget = DefaultTabController(
//                 length: 3,
//               child: Scaffold(
//                 backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
//                 appBar: AppConfig.APP_BAR_COLOR == 2 ?
//                 AppBar(
//                   centerTitle: true,
//                   iconTheme: IconThemeData(
//                     color:AppConfig.APP_BAR_COLOR == 2 ?
//                     Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
//                     Colors.white,
//                   ),
//                   backgroundColor:Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
//                   title: Text(
//                     // "Reward Points",
//                     AppLocalizations.of(context)!.translate("Reward Points")!,
//                     style: TextStyle(
//                       color:AppConfig.APP_BAR_COLOR == 2 ?
//                       Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
//                       Colors.white,
//                     ),),
//                   elevation: 0.0,
//                   bottom: TabBar(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicator: BubbleTabIndicator(
//                         indicatorHeight: 34.0,
//                         indicatorRadius: 12,
//                         indicatorColor:   Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
//                         tabBarIndicatorSize: TabBarIndicatorSize.tab,
//                         // Other flags
//                         // indicatorRadius: 1,
//                         // insets: EdgeInsets.all(1),
//                         // padding: EdgeInsets.all(10)
//
//                       ),
//                       // indicator: UnderlineTabIndicator(
//                       //   borderSide: BorderSide(
//                       //       width: 2.0, color: Theme.of(context).primaryColor),
//                       // ),
//                       labelStyle: const TextStyle(),
//                       unselectedLabelColor:
//                       Theme.of(context).brightness == Brightness.dark
//                           ? AppStyles.COLOR_GREY_DARK
//                           : AppStyles.COLOR_GREY_LIGHT,
//                       // labelColor: Theme.of(context).primaryColor,
//                       labelColor: Colors.white,
//                       tabs: [
//                         Tab(text:
//                         AppLocalizations.of(context)!.translate("Available")!
//                         ),
//                         Tab(text:
//                         AppLocalizations.of(context)!.translate("Applied")!
//                         ),
//                         Tab(text:
//                         AppLocalizations.of(context)!.translate("Expired")!
//                         ),
//
//                       ]),
//                 ):
//                 AppBar(
//                   centerTitle: true,
//                   iconTheme: IconThemeData(
//                     color:AppConfig.APP_BAR_COLOR == 1 ?
//                     Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
//                     Colors.white,
//                   ),
//                   backgroundColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
//                   title: Text(
//                     // "Reward Points",
//                     AppLocalizations.of(context)!.translate("Reward Points")!,
//                     style: TextStyle(
//                       color:AppConfig.APP_BAR_COLOR == 1 ?
//                       Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
//                       Colors.white,
//                     ),),
//                   elevation: 0.0,
//                   bottom: TabBar(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicator: BubbleTabIndicator(
//                         indicatorHeight: 34.0,
//                         indicatorRadius: 12,
//                         indicatorColor:   Theme.of(context).primaryColor,
//                         tabBarIndicatorSize: TabBarIndicatorSize.tab,
//                         // Other flags
//                         // indicatorRadius: 1,
//                         // insets: EdgeInsets.all(1),
//                         // padding: EdgeInsets.all(10)
//
//                       ),
//                       // indicator: UnderlineTabIndicator(
//                       //   borderSide: BorderSide(
//                       //       width: 2.0, color: Theme.of(context).primaryColor),
//                       // ),
//                       labelStyle: const TextStyle(),
//                       unselectedLabelColor:
//                       Theme.of(context).brightness == Brightness.dark
//                           ? AppStyles.COLOR_GREY_DARK
//                           : AppStyles.COLOR_GREY_LIGHT,
//                       // labelColor: Theme.of(context).primaryColor,
//                       labelColor: Colors.white,
//                       tabs: [
//                         Tab(text:
//                         AppLocalizations.of(context)!.translate("Available")!
//                         ),
//                         Tab(text:
//                         AppLocalizations.of(context)!.translate("Applied")!
//                         ),
//                         Tab(text:
//                         AppLocalizations.of(context)!.translate("Expired")!
//                         ),
//
//                       ]),
//                 ),
//                 body: TabBarView(children: [
//                   buildPage(state.rewardPointsResponse.data!),
//                   buildPage(state.rewardPointsResponse.data!),
//                   buildPage(state.rewardPointsResponse.data!),
//                 ]),
//                 bottomSheet: Container(
//                   margin: const EdgeInsets.all(9.0),
//                   width: double.maxFinite,
//                   child: ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(40.0),
//                               )
//                           )
//                       ),
//                       onPressed: () {
//                         BlocProvider.of<RewardBloc>(context).add(const RedeemPoints());
//                       }, child: Text(
//                       AppLocalizations.of(context)!.translate("Redeem",)!
//                      // "Redeem"
//                   )),
//                 ),
//               ),
//             );
//             return mainWidget!;
//           }else if (state is RedeemLoaded){
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.redeemResponse.message!)));
//             return  mainWidget!;
//           } else if (state is CartLoading) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//                 backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
//               ),
//             );
//           } else {
//             return Container();
//           }
//         },
//         listener: (context, state) {
//           if (state is RewardError) {
//             Navigator.pop(context);
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
//           } else if (state is RedeemLoaded) {
//             Navigator.pop(context);
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.redeemResponse.message!)));
//           }
//         },
//       ),
//     );
//   }
//   Widget buildPage(List<RewardPoint> rewardPoints) {
//     double points = 0.0;
//     for (int i=0; i<rewardPoints.length; i++){
//       points += double.parse(rewardPoints[i].points.toString());
//     }
//     return Column(
//       children: [
//         SizedBox(
//            height: 120,
//           width: double.maxFinite,
//           child: Center(child: Text(points.toStringAsFixed(2), style: const TextStyle(fontSize: 26),),),
//         ),
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: rewardPoints.length,
//             itemBuilder: (context, index1) {
//               return  Container(
//                 margin: const EdgeInsets.all(8.0),
//                 // decoration: BoxDecoration(
//                 //  color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor : Colors.white, // set border width
//                 //   borderRadius: BorderRadius.all(
//                 //       Radius.circular(
//                 //           10.0)), // set rounded corner radius
//                 // ),
//                 decoration: BoxDecoration(
//                   color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor : Colors.white,
//                   border: Border.all(color: Colors.black),
//                   borderRadius: const BorderRadius.all(
//                       Radius.circular( AppStyles.CARD_RADIUS) //                 <--- border radius here
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 14,left: 8),
//                       child: Text(double.parse(rewardPoints[index1].points.toString()).toStringAsFixed(2),style: TextStyle(fontSize: 16,color: Theme.of(context).primaryColor),),
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.only(top: 0,left: 8,bottom: 12),
//                         child: Text(rewardPoints[index1].description!, style: const TextStyle(fontSize: 14),)
//                     ),
//                     Divider(color: Colors.black,),
//                     Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
//                         child: Text(
//                           AppLocalizations.of(context)!.translate("Validity: Jan 11, 2021 - Feb 11, 2021")!,
//                           style: const TextStyle(color: Colors.grey,fontSize: 12),)
//                     ),
//                     const SizedBox(height: 5,),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(0.0),
//                             topRight:  Radius.circular(10.0),
//                             bottomLeft: Radius.circular(8.0),
//                             bottomRight: Radius.zero,
//                           ),
//                           color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,// set rounded corner radius
//                       ),
//                       padding: const EdgeInsets.all(6.0),
//                       child: Text(
//                         AppLocalizations.of(context)!.translate("NEW MEMBER DISCOUNT")!,
//                         style: const TextStyle(color: Colors.white, fontSize: 14),),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 60),
//       ],
//     );
//   }
// }
