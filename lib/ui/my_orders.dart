import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/order_shipment_cancel/order_shipment_cancel_bloc.dart';
import 'package:flutter_kundol/blocs/order_shipment_cancel/order_shipment_cancel_state.dart';
import 'package:flutter_kundol/blocs/order_shipment_return/order_shipment_return_bloc.dart';
import 'package:flutter_kundol/blocs/orders/orders_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/main_screen.dart';
import 'package:flutter_kundol/ui/my_account.dart';
import 'package:flutter_kundol/ui/return_order_screen.dart';
import 'package:flutter_kundol/ui/review_new_screen%20.dart';
import 'package:flutter_kundol/ui/review_screen.dart';
import 'package:flutter_kundol/ui/track_order_screen.dart';
import 'package:flutter_kundol/ui/widgets/order_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';

import '../api/api_provider.dart';
import '../blocs/order_shipment_cancel/order_shipment_cancel_event.dart';
import '../blocs/reviews/reviews_bloc.dart';
import '../blocs/shipment_track/shipment_track_bloc.dart';
import '../blocs/shipment_track/shipment_track_event.dart';
import '../blocs/shipment_track/shipment_track_state.dart';
import '../constants/app_data.dart';
import '../constants/app_styles.dart';
import '../models/orders_data.dart';
import '../repos/order_shipment_cancel_repo.dart';
import '../repos/order_shipment_retutrn_repo.dart';
import '../repos/orders_repo.dart';
import '../repos/reviews_repo.dart';
import '../repos/shipment_track_repo.dart';
import '../tweaks/app_localization.dart';

class MyOrders extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  MyOrders({required this.navigateToNext,Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<OrderShipmentCancelBloc,OrderShipmentCancelState>(
          listener: (context,state){
            if(state is OrderShipmentCancelSuccess){
              Navigator.of(context).pop();
              widget.navigateToNext(
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (BuildContext context) {
                        return OrdersBloc(RealOrdersRepo())
                          ..add(const GetOrders());
                      }),
                      BlocProvider(create: (BuildContext context) {
                        return OrderShipmentCancelBloc(orderShipmentCancelRepo: RealOrderShipmentCancelRepo());
                      })
                    ],
                    child:  MyOrders(navigateToNext: widget.navigateToNext),
                  ));
            }else{

            }
          },
          child:  BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
            if (state is OrdersLoaded) {
              if (state.ordersData.isNotEmpty) {
                return
                  DefaultTabController(
                      length: 5,
                      child: Scaffold(
                        backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Color.fromRGBO(0, 0, 0, 1)
                            : Color.fromRGBO(255, 255, 255, 1),
                        appBar: AppBar(
                          leading: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigator.of(context).push(MaterialPageRoute(builder: (c)=>MainScreen()));
                            },
                            icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
                                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,),
                          ),
                          centerTitle: true,
                          elevation: 0.0,
                          backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(18, 18, 18, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          title: Text(
                            "My Orders",
                            style: GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(18, 18, 18, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          bottom: TabBar(
                            isScrollable: true,
                            unselectedLabelColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1)
                                : Color.fromRGBO(112, 112, 112, 1),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            labelColor: Color.fromRGBO(255, 76, 59, 1),
                            labelStyle: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            indicatorColor: Color.fromRGBO(255, 76, 59, 1),
                            // indicatorPadding: EdgeInsets.only(left: 8, right: 8),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(text: 'Pending'),
                              Tab(text:'In Process'),
                              Tab(text: 'Completed'),
                              Tab(text: 'Cancelled'),
                              Tab(text:'Return')
                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            buildPage(getOrdersBy(state.ordersData, "Pending")),
                            buildPage(getOrdersBy(state.ordersData, "Inprocess")),
                            buildPage(getOrdersBy(state.ordersData, "Complete")),
                            buildPage(getOrdersBy(state.ordersData, "Cancel")),
                            buildPage(getOrdersBy(state.ordersData, "Return")),
                          ],
                        ),
                      ));
              } else {
                return DefaultTabController(
                    length: 5,
                    child: Scaffold(
                      backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color.fromRGBO(0, 0, 0, 1)
                          : Color.fromRGBO(255, 255, 255, 1),
                      appBar: AppBar(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
                              Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,),
                        ),
                        centerTitle: true,
                        elevation: 1,
                        backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Color.fromRGBO(18, 18, 18, 1)
                            : Color.fromRGBO(255, 255, 255, 1),
                        title: Text(
                          "My Orders",
                          style:GoogleFonts.gothicA1(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(18, 18, 18, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        bottom: TabBar(
                          isScrollable:true,
                          unselectedLabelColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(160, 160, 160, 1)
                              : Color.fromRGBO(112, 112, 112, 1),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          labelColor: Color.fromRGBO(255, 76, 59, 1),
                          labelStyle:GoogleFonts.gothicA1(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          indicatorColor: Color.fromRGBO(255, 76, 59, 1),
                          // indicatorPadding: EdgeInsets.only(left: 8, right: 8),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(text: 'Ongoing'),
                            Tab(text: 'In Process'),
                            Tab(text: 'Completed'),
                            Tab(text:'Cancelled'),
                            Tab(text:'Return'),
                          ],
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.all(6),
                        child: TabBarView(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 350,
                                      child: Image.asset(
                                          "assets/images/order_not_found.png"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "You don’t have an order yet",
                                      textAlign: TextAlign.center,
                                      style:GoogleFonts.gothicA1(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Text(
                                    //   "You don’t have an ongoing orders at this time.",
                                    //   style: GoogleFonts.gothicA1(
                                    //       color: Theme.of(context).brightness ==
                                    //               Brightness.dark
                                    //           ? Color.fromRGBO(160, 160, 160, 1)
                                    //           : Color.fromRGBO(112, 112, 112, 1),
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 350,
                                      child: Image.asset(
                                          "assets/images/order_not_found.png"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "You don’t have an order yet",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Text(
                                    //   "You don’t have an ongoing orders at this time.",
                                    //   textAlign: TextAlign.center,
                                    //   style:GoogleFonts.gothicA1(
                                    //       color: Theme.of(context).brightness ==
                                    //               Brightness.dark
                                    //           ? Color.fromRGBO(160, 160, 160, 1)
                                    //           : Color.fromRGBO(112, 112, 112, 1),
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 350,
                                      child: Image.asset(
                                          "assets/images/order_not_found.png"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "You don’t have an order yet",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Text(
                                    //   "You don’t have an ongoing orders at this time.",
                                    //   textAlign: TextAlign.center,
                                    //   style:GoogleFonts.gothicA1(
                                    //       color: Theme.of(context).brightness ==
                                    //               Brightness.dark
                                    //           ? Color.fromRGBO(160, 160, 160, 1)
                                    //           : Color.fromRGBO(112, 112, 112, 1),
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 350,
                                      child: Image.asset(
                                          "assets/images/order_not_found.png"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "You don’t have an order yet",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Text(
                                    //   "You don’t have an ongoing orders at this time.",
                                    //   textAlign: TextAlign.center,
                                    //   style:GoogleFonts.gothicA1(
                                    //       color: Theme.of(context).brightness ==
                                    //               Brightness.dark
                                    //           ? Color.fromRGBO(160, 160, 160, 1)
                                    //           : Color.fromRGBO(112, 112, 112, 1),
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 350,
                                      child: Image.asset(
                                          "assets/images/order_not_found.png"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "You don’t have an order yet",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Text(
                                    //   "You don’t have an ongoing orders at this time.",
                                    //   textAlign: TextAlign.center,
                                    //   style:GoogleFonts.gothicA1(
                                    //       color: Theme.of(context).brightness ==
                                    //               Brightness.dark
                                    //           ? Color.fromRGBO(160, 160, 160, 1)
                                    //           : Color.fromRGBO(112, 112, 112, 1),
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              }
            }
            return Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 76, 59, 1),
                ));
          }),
        )


    );
  }

  Widget buildPage(List<OrdersData> ordersData) {
    return ListView.builder(
      itemCount: ordersData.length,
      itemBuilder: (context, index1) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder:(context){
                    return  BlocProvider(
                        create: (context) =>
                            ShipmentTrackBloc(RealShipmentTrackRepo()),
                        child: ViewOrderPage(
                          ordersData: ordersData[index1],
                          navigateToNext: widget.navigateToNext,
                        )
                    );
                  }));

            },
            child:Column(
              children: [
                SizedBox( height: MediaQuery.of(context).size.height*0.015,),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderImages(ordersData[index1].orderDetail!),
                      SizedBox( width: MediaQuery.of(context).size.width*0.03,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        height: MediaQuery.of(context).size.height*0.22,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Id : "+"${ordersData[index1].orderId}" ,
                              style: GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                              ),),
                            SizedBox( height: MediaQuery.of(context).size.height*0.015,),
                            Text( "Order Date : "+ formateDate(ordersData[index1].orderDate),
                              style:GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                              ),),
                            SizedBox( height: MediaQuery.of(context).size.height*0.015,),
                            Text( "Items : "+ "${ordersData[index1].orderDetail!.length}",
                              style: GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                              ),),

                            SizedBox( height: MediaQuery.of(context).size.height*0.015,),
                            Text(AppData.currency!.code !+
                                double.parse(ordersData[index1].orderPrice
                                    .toString())
                                    .toStringAsFixed(2),style: GoogleFonts.gothicA1(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(255, 76, 59,1)
                            ),),
                            SizedBox( height: MediaQuery.of(context).size.height*0.015,),
                            Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 76, 59,1),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child: Text(ordersData[index1].orderStatus!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(255, 255, 255, 1,),
                                      ),),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                ordersData[index1].orderStatus=="Pending"?
                                GestureDetector(
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Text(ordersData[index1].orderStatus=="Pending"?"Cancel Order":"Cancelled",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(255, 255, 255, 1,),
                                        ),),
                                    ),
                                  ),
                                  onTap: (){
                                    BlocProvider.of<OrderShipmentCancelBloc>(context).add(OrderShipmentCancelRequested(orderId: ordersData[index1].orderId!,waybill: ordersData[index1].waybill!));


                                  },
                                ):Container()
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Divider(thickness: 0.8,color: Theme.of(context).brightness ==
                //     Brightness.dark?Color.fromRGBO(70, 70,70, 1):Color.fromRGBO(190, 190, 190,1))
              ],
            )
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


  String formateDate(String? orderDate) {
    print(orderDate);
    DateTime parseDate = new DateFormat("dd/MM/dd").parse(orderDate!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-mm-yyyy');
    var outputDate = outputFormat.format(inputDate);
    return orderDate.substring(0, 8);
  }

  Widget _buildOrderImages(List<OrderDetail> orderDetail) {
    if (orderDetail.length == 1) {
      return Container(
        height:MediaQuery.of(context).size.height*0.19,
        width: MediaQuery.of(context).size.width*0.4,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              height: MediaQuery.sizeOf(context).height * 0.19,
              imageUrl: ApiProvider.imgMediumUrlString + orderDetail![0].product!
                  .productGallary!.gallaryName!,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url,
                  downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          color: Color.fromRGBO(
                              255, 76, 59, 1),
                          value:
                          downloadProgress.progress)),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            )),
      );// Show single image if itemCount is 1
    } else if (orderDetail.length == 2) {
      return Container(
        height:MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.4,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  height: MediaQuery.sizeOf(context).height * 0.095,
                  imageUrl: ApiProvider.imgMediumUrlString + orderDetail[0].product!
                      .productGallary!.gallaryName!,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url,
                      downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(
                                  255, 76, 59, 1),
                              value:
                              downloadProgress.progress)),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                )),
            SizedBox(height: 5),
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  height: MediaQuery.sizeOf(context).height * 0.095,
                  imageUrl: ApiProvider.imgMediumUrlString + orderDetail![1].product!
                      .productGallary!.gallaryName!,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url,
                      downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(
                                  255, 76, 59, 1),
                              value:
                              downloadProgress.progress)),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                )),// Show second image
          ],
        ),
      );
    } else {
      return Container(
        height:MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      imageUrl: ApiProvider.imgMediumUrlString + orderDetail![0].product!
                          .productGallary!.gallaryName!,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url,
                          downloadProgress) =>
                          Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromRGBO(
                                      255, 76, 59, 1),
                                  value:
                                  downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    )),
                SizedBox(height: 5,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      imageUrl: ApiProvider.imgMediumUrlString + orderDetail![1].product!
                          .productGallary!.gallaryName!,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url,
                          downloadProgress) =>
                          Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromRGBO(
                                      255, 76, 59, 1),
                                  value:
                                  downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    )),
              ],
            ),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width*0.09,
              height: MediaQuery.of(context).size.width*0.09,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).brightness ==
                          Brightness.dark?Color.fromRGBO(70, 70,70, 1):Color.fromRGBO(190, 190, 190,1)
                  )
              ),
              child: Center(
                child: Text(
                  '+${orderDetail.length-2}',
                  style: GoogleFonts.gothicA1(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness ==
                          Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}


class ViewOrderPage extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final OrdersData? ordersData;

  ViewOrderPage({Key? key,this.ordersData,this.navigateToNext}) : super(key: key);

  @override
  _ViewOrderPageState createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {



  @override
  void initState() {
    BlocProvider.of<ShipmentTrackBloc>(context).add(FetchShipmentTrack(waybill: widget.ordersData!.waybill!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ordersData!.couponAmount);
    var cAmount=widget.ordersData!.couponCode==null?0.0:widget.ordersData!.couponAmount;

    double subtotal=widget.ordersData!.orderPrice-widget.ordersData!.totalTax+cAmount;
    print(subtotal);
    return Scaffold(
      backgroundColor:
      Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Order Details",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.015,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Info",style: GoogleFonts.gothicA1(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness==Brightness.dark?
                      Color.fromRGBO(255, 255, 255, 1):
                      Color.fromRGBO(0, 0, 0, 1)
                  ),),
                  widget.ordersData!.orderStatus=="Complete"?InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (c){
                        return  BlocProvider(
                          create: (context) {
                            return OrderShipmentReturnBloc(orderShipmentReturnRepo: RealOrderShipmentReturnRepo());
                          },
                          child: ReturnOrderScreen(ordersData: widget.ordersData,navigateToNext: widget.navigateToNext),
                        );
                      }));

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.28,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(255, 76, 59,1),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color.fromRGBO(255, 76, 59,1), )
                      ),
                      child: Center(
                        child: Text("Return",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:Color.fromRGBO(255, 76, 59,1),
                          ),),
                      ),
                    ),
                  ):Container()

                  // InkWell(
                  //   onTap: (){
                  //     Navigator.of(context).push(MaterialPageRoute(builder: (c){
                  //       return  BlocProvider(
                  //         create: (context) {
                  //           return OrderShipmentReturnBloc(orderShipmentReturnRepo: RealOrderShipmentReturnRepo());
                  //         },
                  //         child: ReturnOrderScreen(ordersData: widget.ordersData,navigateToNext: widget.navigateToNext),
                  //       );
                  //     }));
                  //
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width*0.28,
                  //     height: MediaQuery.of(context).size.height*0.05,
                  //     decoration: BoxDecoration(
                  //       // color: Color.fromRGBO(255, 76, 59,1),
                  //         borderRadius: BorderRadius.circular(5),
                  //         border: Border.all(color: Color.fromRGBO(255, 76, 59,1), )
                  //     ),
                  //     child: Center(
                  //       child: Text("Return",
                  //         textAlign: TextAlign.center,
                  //         style: GoogleFonts.gothicA1(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w700,
                  //           color:Color.fromRGBO(255, 76, 59,1),
                  //         ),),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.24,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order Id',style:GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),),
                          Text("${widget.ordersData!.orderId}",style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order Date',style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),),
                          Text(formateDate(widget.ordersData!.orderDate),style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('Order Amount',style: GoogleFonts.gothicA1(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w600,
                      //       color: Theme.of(context)
                      //           .brightness ==
                      //           Brightness.dark
                      //           ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                      //     ),),
                      //     Text(AppData.currency!.code !+"${widget.ordersData!.orderPrice}",style: GoogleFonts.gothicA1(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w600,
                      //         color: Theme.of(context).brightness==Brightness.dark?
                      //         Color.fromRGBO(255, 255, 255, 1):
                      //         Color.fromRGBO(0, 0, 0, 1)
                      //     ),)
                      //   ],
                      // ),
                      // SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Status',style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),),
                          Text(widget.ordersData!.orderStatus!,style:GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Method',style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),),
                          Text(widget.ordersData!.paymentMethod=="cod"?"Cash On Delivery":"Razorpay",style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipment Method',style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),),
                          Text("DELHIVERY",style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(255, 76, 59, 1)
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      widget.ordersData!.gstNumber!=null?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('GST Number',style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                          ),),
                          Text(widget.ordersData!.gstNumber!,style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(112, 112, 112, 1)
                          ),)
                        ],
                      ):Container()
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.015,),
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.ordersData!.orderDetail!.length,
                  itemBuilder: (context,index){
                    return  Column(
                      children: [
                        Container(
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
                                      height: 150,
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child:
                                      CachedNetworkImage(
                                        imageUrl: ApiProvider.imgMediumUrlString +
                                            widget.ordersData!.orderDetail![index].product
                                            !.productGallary
                                            !.gallaryName!,
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) => Center(
                                            child: CircularProgressIndicator(
                                                color: Color.fromRGBO(255, 76, 59, 1),
                                                value: downloadProgress.progress)),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.48,
                                    height: MediaQuery.of(context).size.width*0.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text( widget.ordersData!.orderDetail![index]
                                            .product!.detail![0].title!,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.gothicA1(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context).brightness ==
                                                  Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                          ),),
                                        SizedBox(height: 10),

                                        Text("Qty : "+"${widget.ordersData!.orderDetail![index].productQty}",style:GoogleFonts.gothicA1(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                        ),),

                                        SizedBox(height: 10),

                                        widget.ordersData!.orderStatus=="Pending"?
                                        Row(
                                          children: [
                                            Text(AppData.currency!.code !+"${widget.ordersData!.orderDetail![index].productDiscount}",style: GoogleFonts.gothicA1(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromRGBO(255, 76, 59,1)
                                            ),),
                                            SizedBox(width: 6,),
                                            Text(AppData.currency!.code !+"${widget.ordersData!.orderDetail![index].productPrice}",style:GoogleFonts.gothicA1(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context).brightness ==
                                                    Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                                                decoration: TextDecoration.lineThrough
                                            ),),
                                          ],
                                        ) :
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(AppData.currency!.code !+"${widget.ordersData!.orderDetail![index].productDiscount}",style: GoogleFonts.gothicA1(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromRGBO(255, 76, 59,1)
                                                ),),
                                                SizedBox(width: 6,),
                                                Text(AppData.currency!.code !+"${widget.ordersData!.orderDetail![index].productPrice}",style: GoogleFonts.gothicA1(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context).brightness ==
                                                        Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                                                    decoration: TextDecoration.lineThrough
                                                ),),
                                                SizedBox(width: 6,),

                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            widget.ordersData!.orderStatus=="Complete"?InkWell(
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => MultiBlocProvider(
                                                        providers: [
                                                          BlocProvider(
                                                            create: (BuildContext context) {
                                                              return ReviewsBloc(RealReviewsRepo());
                                                            },),
                                                          BlocProvider(
                                                            create: (BuildContext context) {
                                                              return DetailScreenBloc(RealCartRepo(),RealProductsRepo());
                                                            },)
                                                        ],
                                                        child: ReviewNewScreen(
                                                            widget.ordersData!.orderDetail![index]
                                                                .product!.productId!,
                                                            widget.ordersData!.orderDetail![index]
                                                                .product!,
                                                            widget.ordersData!.orderStatus!,
                                                            widget.ordersData!.orderDate.toString(),
                                                            widget.ordersData!.orderDetail![index].productQty.toString()
                                                        )
                                                    )
                                                ));
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context).size.width*0.28,
                                                height: MediaQuery.of(context).size.height*0.03,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(255, 76, 59,1),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text("Leave Review",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.gothicA1(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700,
                                                      color: Color.fromRGBO(255, 255, 255, 1,),
                                                    ),),
                                                ),
                                              ),
                                            ):Container()
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    );
                  }),
              SizedBox(height: MediaQuery.of(context).size.height*0.015,),
              Text("Shipping Address",style:GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Image.asset("assets/images/Icon loaction checkout.png",width: 24,height: 24,),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Text(widget.ordersData!.deliveryStreetAadress!,
                        style: GoogleFonts.gothicA1(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).brightness==Brightness.dark?
                            Color.fromRGBO(255, 255, 255, 1):
                            Color.fromRGBO(0, 0, 0, 1)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.015,),
              widget.ordersData!.orderStatus=="Pending"||
                  widget.ordersData!.orderStatus=="Inprocess"
                  ?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Track Order",style: GoogleFonts.gothicA1(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness==Brightness.dark?
                      Color.fromRGBO(255, 255, 255, 1):
                      Color.fromRGBO(0, 0, 0, 1)
                  ),),
                  Divider(),
                  BlocBuilder<ShipmentTrackBloc,ShipmentTrackState>(
                      builder: (context,state) {
                        if(state is ShipmentTrackLoaded){

                          int _currentStep=0;
                          if(state.shipmentTrack[0].shipment.status.status=="Manifested"){_currentStep=0;}
                          else if(state.shipmentTrack[0].shipment.status.status=="Not Picked"){_currentStep=1;}
                          else if(state.shipmentTrack[0].shipment.status.status=="In Transit"||state.shipmentTrack[0].shipment.status.status=="Pending"){_currentStep=2;}
                          else if(state.shipmentTrack[0].shipment.status.status=="Dispatched"){_currentStep=3;}
                          else{_currentStep=4;}

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Theme.of(context).brightness==Brightness.dark?
                              Row(
                                children: [
                                  SizedBox(width:MediaQuery.of(context).size.width*0.032),
                                  Image.asset("assets/images/track_order1_l.png"),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.12),
                                  Icon(Icons.start,size: 32,color: Colors.white,),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.12),
                                  Image.asset("assets/images/track_order2_l.png"),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.110),
                                  Image.asset("assets/images/track_order3_l.png"),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.12),
                                  Image.asset("assets/images/track_order4_l.png"),
                                ],
                              ):
                              Row(
                                children: [
                                  SizedBox(width:MediaQuery.of(context).size.width*0.032),
                                  Image.asset("assets/images/track_order1_d.png"),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.12),
                                  Icon(Icons.start,size: 32,),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.12),
                                  Image.asset("assets/images/track_order2_d.png"),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.110),
                                  Image.asset("assets/images/track_order3_d.png"),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.12),
                                  Image.asset("assets/images/track_order4_d.png"),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.9,
                                height: MediaQuery.of(context).size.height*0.06,
                                child: IconStepper(
                                  direction: Axis.horizontal,
                                  scrollingDisabled: true,
                                  alignment: Alignment.center,
                                  enableNextPreviousButtons: false,
                                  enableStepTapping: false,
                                  activeStep: _currentStep,
                                  activeStepColor: Color.fromRGBO(255, 76, 59, 1),
                                  stepPadding: 0.0,
                                  stepColor: Theme.of(context).brightness==Brightness.dark?
                                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                  activeStepBorderWidth: 0.0,
                                  activeStepBorderPadding: 0.0,
                                  lineColor: Theme.of(context).brightness==Brightness.dark?
                                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                  lineLength: MediaQuery.of(context).size.width*0.14,
                                  lineDotRadius:MediaQuery.of(context).size.width*0.004,
                                  stepRadius: MediaQuery.of(context).size.width*0.03,
                                  icons: [
                                    Icon(Icons.radio_button_checked_outlined, color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                                    Icon(Icons.radio_button_checked_outlined,color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                                    Icon(Icons.radio_button_checked_outlined,color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),),
                                    Icon(Icons.radio_button_checked_outlined,color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                                    Icon(Icons.radio_button_checked_outlined,color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.95,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Confirmed",
                                      textAlign:TextAlign.center,
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):
                                          Color.fromRGBO(0, 0, 0, 1)
                                      ),),
                                    // SizedBox(width:MediaQuery.of(context).size.width*0.05),
                                    Text("Ready for \n   pickup",style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):
                                        Color.fromRGBO(0, 0, 0, 1)
                                    ),),
                                    Text("Intransit",style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):
                                        Color.fromRGBO(0, 0, 0, 1)
                                    ),),
                                    // SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                    Text("Dispatched",
                                      textAlign:TextAlign.center,
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):
                                          Color.fromRGBO(0, 0, 0, 1)
                                      ),),
                                    // SizedBox(width:MediaQuery.of(context).size.width*0.05),
                                    Text("Delivered",style:GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):
                                        Color.fromRGBO(0, 0, 0, 1)
                                    ),),
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                        else if(state is ShipmentTrackError){
                          print(state.errorMessage);
                          return Text(state.errorMessage);
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(255, 76, 59, 1),
                          ),
                        );

                      }
                  )
                ],
              ):Container(),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Text("Order Summary",style:GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.27,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SubTotal',style:GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1)
                          ),),
                          Text(AppData.currency!.code!+"${subtotal.toStringAsFixed(2)}",style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1)
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount[Coupan]',style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1)
                          ),),
                          Text("-"+AppData.currency!.code!+"${widget.ordersData!.couponCode==null?0.0:widget.ordersData!.couponAmount.toStringAsFixed(2)}",style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount[GST]',style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1)
                          ),),
                          widget.ordersData!.gstDiscount!=null?
                          Text("-${AppData.currency!.code!}${widget.ordersData!.gstDiscount!.toStringAsFixed(2)}",style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green
                          ),):
                          Text("-${AppData.currency!.code!}${0.toStringAsFixed(2)}",style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax',style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1)
                          ),),
                          Text(AppData.currency!.code !+"${widget.ordersData!.totalTax.toStringAsFixed(2)}",style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.red
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping',style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1)
                          ),),
                          Text(AppData.currency!.code!+"${widget.ordersData!.shippingCost==null?0.0:widget.ordersData!.shippingCost.toStringAsFixed(2)}",style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.red
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.04,
                        decoration: BoxDecoration(
                            color:  Color.fromRGBO(
                                255, 76, 59, 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Total',style: GoogleFonts.gothicA1(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                              Text(AppData.currency!.code!+"${widget.ordersData!.orderPrice.toStringAsFixed(2)}",style:GoogleFonts.gothicA1(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01),

            ],
          ),
        ),
      ),
    );
  }

  String formateDate(String? orderDate) {
    DateTime parseDate = new DateFormat("dd/MM/dd").parse(orderDate!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-mm-yyyy');
    var outputDate = outputFormat.format(inputDate);
    return orderDate.substring(0, 8);
  }
}

