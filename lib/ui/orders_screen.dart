import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/orders/orders_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/orders_data.dart';
import 'package:flutter_kundol/ui/order_detail_screen.dart';

import '../constants/app_config.dart';
import '../tweaks/app_localization.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppConfig.APP_BAR_COLOR == 2 ?
                AppBar(
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color:AppConfig.APP_BAR_COLOR == 2 ?
                    Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
                    Colors.white,
                  ),
                  backgroundColor:Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  title: Text(
                    AppLocalizations.of(context)!.translate("Orders")!,
                    style: TextStyle(
                      color:AppConfig.APP_BAR_COLOR == 2 ?
                      Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
                      Colors.white,
                    ),),
                  elevation: 0.0,
                  bottom: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                        indicatorHeight: 34.0,
                        indicatorRadius: 12,
                        indicatorColor:  Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColor : Theme.of(context).primaryColor,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        // Other flags
                        // indicatorRadius: 1,
                        // insets: EdgeInsets.all(1),
                        // padding: EdgeInsets.all(10)

                      ),
                      // indicator: UnderlineTabIndicator(
                      //   borderSide: BorderSide(
                      //       width: 2.0, color: Theme.of(context).primaryColor),
                      // ),
                      labelStyle: const TextStyle(),
                      unselectedLabelColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                      // labelColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(text: AppLocalizations.of(context).translate("In Progress",)!
                        ),
                        Tab(text: AppLocalizations.of(context).translate("Delivered")!
                        ),
                        Tab(
                            text: AppLocalizations.of(context).translate("Reviews")!
                        ),
                      ]),
                ):
                AppBar(
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color:AppConfig.APP_BAR_COLOR == 1 ?
                    Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
                    Colors.white,
                  ),
                  backgroundColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                  title: Text(
                    AppLocalizations.of(context).translate("Orders"),
                    style: TextStyle(
                      color:AppConfig.APP_BAR_COLOR == 1 ?
                      Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
                      Colors.white,
                    ),),
                  elevation: 0.0,
                  bottom: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                        indicatorHeight: 34.0,
                        indicatorRadius: 12,
                        indicatorColor:   Theme.of(context).primaryColor,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        // Other flags
                        // indicatorRadius: 1,
                        // insets: EdgeInsets.all(1),
                        // padding: EdgeInsets.all(10)

                      ),
                      // indicator: UnderlineTabIndicator(
                      //   borderSide: BorderSide(
                      //       width: 2.0, color: Theme.of(context).primaryColor),
                      // ),
                      labelStyle: const TextStyle(),
                      unselectedLabelColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                      // labelColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(text: AppLocalizations.of(context).translate("In Progress",)
                        ),
                        Tab(text: AppLocalizations.of(context).translate("Delivered")
                        ),
                        Tab(
                            text: AppLocalizations.of(context).translate("Reviews")
                        ),
                      ]),
                ),
                body: TabBarView(children: [
                  buildPage(getOrdersBy(state.ordersData, "Pending")),
                  buildPage(getOrdersBy(state.ordersData, "Delivered")),
                  buildPage(getOrdersBy(state.ordersData, "Canceled")),
                ]),
              ),
            );
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

  Widget buildPage(List<OrdersData> ordersData) {
    return ListView.builder(
      itemCount: ordersData.length,
      itemBuilder: (context, index1) {
        double subtotal = 0;
        double orderTotal = 0;

        for (int i = 0; i < ordersData[index1].orderDetail!.length; i++) {
          subtotal += double.parse(ordersData[index1].orderDetail![i].productPrice.toString());
          orderTotal = subtotal;
        }

        return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(AppLocalizations.of(context)!.translate("Order ID")!
                  + ordersData[index1].orderId.toString()),
                      Text("Placed on 22-12-20, 13:15",
                          style:
                              TextStyle(color: Colors.grey[350], fontSize: 10)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailScreen(ordersData[index1]),
                        )),
                    child: Text(
                        AppLocalizations.of(context)!.translate("View Details")!,
                        style: TextStyle(color: Colors.grey[350], fontSize: 10)),
                  )
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 15, right: 15),
              itemCount: ordersData[index1].orderDetail!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index2) => Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              AppStyles.CARD_RADIUS),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: CachedNetworkImage(
                              imageUrl: ApiProvider.imgMediumUrlString +
                                  ordersData[index1]
                                      .orderDetail![index2]
                                      .product
                                      !.productGallary
                                      !.gallaryName!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 218,
                                child: Text(
                                  ordersData[index1]
                                      .orderDetail![index2]
                                      .product
                                      !.detail![1].title!,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                AppData.currency!.code !+
                                    double.parse(ordersData[index1]
                                            .orderDetail![index2]
                                            .product
                                            !.productPrice
                                            .toString())
                                        .toStringAsFixed(2),
                                style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(height: 8.0,),
                              Text(
                                AppLocalizations.of(context)!.translate("1, Black, Large")!,
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                "Qty: ${ordersData[index1]
                                        .orderDetail![index2]
                                        .productQty}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 15);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate("2 Items, total")!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[350]),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppData.currency!.code !+ orderTotal.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            // Divider(
            //   thickness: 4,
            //   color: Color(0xFFE6E8E9),
            // ),
          ],
        ),
      );
      },
    );
  }

  List<OrdersData> getOrdersBy(List<OrdersData> ordersData, String filterBy) {
    List<OrdersData> tempOrders = [];

    for (int i = 0; i < ordersData.length; i++) {
      if (ordersData[i].orderStatus == filterBy) {
        tempOrders.add(ordersData[i]);
      }
    }
    return tempOrders;
  }
}
