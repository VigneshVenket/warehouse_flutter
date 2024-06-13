import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/shipment_track/shipment_track_bloc.dart';
import 'package:flutter_kundol/blocs/shipment_track/shipment_track_event.dart';
import 'package:flutter_kundol/blocs/shipment_track/shipment_track_state.dart';
import 'package:flutter_kundol/ui/my_orders.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';

import '../api/api_provider.dart';
import '../constants/app_data.dart';
import '../models/orders_data.dart';


class TrackOrderScreen extends StatefulWidget {
  final int productId;
  Product product;
  String orderstatus;
  String orderdate;
  String waybill;
  String productQty;

  TrackOrderScreen(this.productId,this.product,this.orderstatus,this.orderdate,this.waybill,this.productQty);

  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {

  @override
  void initState() {
    BlocProvider.of<ShipmentTrackBloc>(context).add(FetchShipmentTrack(waybill: widget.waybill));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Theme.of(context).brightness ==
        Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
        appBar:   AppBar(
          leading: IconButton(
          onPressed: (){
          Navigator.pop(context);
           },
         icon: Icon(Icons.arrow_back_ios),
          ),
        centerTitle: true,
          elevation: 1,
        backgroundColor: Theme.of(context).brightness ==
         Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
        title: Text(
        "Track Order",style: TextStyle(
       color:Theme.of(context).brightness ==
       Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
       fontSize: 18,
       fontWeight: FontWeight.w900
          ),
          ),
         ),
        body: Column(
          children: [

            // BlocListener<ShipmentTrackBloc,ShipmentTrackState>(
            //     listener: (c,state){
            //   if(state is ShipmentTrackLoaded){
            //     ScaffoldMessenger.of(context)
            //         .showSnackBar(SnackBar(content: Text("Success")));
            //   }
            //   else if(state is ShipmentTrackError){
            //     ScaffoldMessenger.of(context)
            //         .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            //   }
            //   else {
            //     ScaffoldMessenger.of(context)
            //         .showSnackBar(SnackBar(content: Text("Not loaded")));
            //   }
            // },
            // child: Container(
            //   width: 100,
            //   height: 50,
            //   child: ElevatedButton(onPressed: (){
            //     BlocProvider.of<ShipmentTrackBloc>(context).add(FetchShipmentTrack(waybill: widget.waybill));
            //   }, child: Text("press")),
            // ),
            // )
            BlocBuilder<ShipmentTrackBloc,ShipmentTrackState>(
              builder: (context,state) {
                if(state is ShipmentTrackLoaded){
                  int _currentStep=0;
                  if(state.shipmentTrack[0].shipment.status.status=="Manifested"){_currentStep=0;}
                  else if(state.shipmentTrack[0].shipment.status.status=="Ready for Pickup"){_currentStep=1;}
                  else if(state.shipmentTrack[0].shipment.status.status=="In Transit"){_currentStep=2;}
                  else{_currentStep=3;}
                  String originalDateString=widget.orderdate.substring(0,8);
                  DateTime originalDate = DateFormat("dd/MM/yy").parse(originalDateString);
                  String formattedDate = DateFormat("dd-MM-yy").format(originalDate);

                  double subtotal = 0;
                  double orderTotal = 0;


                    // print(ordersData[index1].orderDetail![i].productQty.toString());
                    // print(ordersData[index1].orderDetail![i].product!.productDiscountPrice.toString());
                    subtotal += (double.parse(widget.product!.productDiscountPrice.toString()) *
                        int.parse(widget.productQty));
                    print(subtotal);
                    orderTotal = subtotal;


                  return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child:
                                    CachedNetworkImage(
                                      imageUrl: ApiProvider.imgMediumUrlString + widget.product.productGallary!.gallaryName!,
                                      // ordersData[index1].orderDetail![index2].product
                                      // !.productGallary
                                      // !.gallaryName!,
                                      fit: BoxFit.fill,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(
                                              color: Color.fromRGBO(255, 76, 59, 1),
                                              value: downloadProgress.progress)),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    )
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.48,
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.product.detail![0].title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                        ),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text( "Order Date : "+formattedDate,
                                        // maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                        ),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // SizedBox(height: 10,),
                                      // Row(
                                      //   children: [
                                      //     Text("Color : ${widget.reviewProduct!.color!}",style: TextStyle(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: Theme.of(context).brightness==Brightness.dark?
                                      //         Color.fromRGBO(160, 160, 160, 1):
                                      //         Color.fromRGBO(112, 112, 112, 1)
                                      //     ),),
                                      //     Text(" | ",style: TextStyle(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: Theme.of(context).brightness==Brightness.dark?
                                      //         Color.fromRGBO(160, 160, 160, 1):
                                      //         Color.fromRGBO(112, 112, 112, 1)
                                      //     ),),
                                      //     Text("Size : ${widget.reviewProduct!.size}",style: TextStyle(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: Theme.of(context).brightness==Brightness.dark?
                                      //         Color.fromRGBO(160, 160, 160, 1):
                                      //         Color.fromRGBO(112, 112, 112, 1)
                                      //     ),)
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Container(
                                      //   width: 90,
                                      //   height: 24,
                                      //   decoration: BoxDecoration(
                                      //       color: Theme.of(context).brightness==Brightness.dark?
                                      //       Color.fromRGBO(29, 29, 29, 1):
                                      //       Color.fromRGBO(240, 240, 240, 1)
                                      //   ),
                                      //   child: Text(widget.reviewProduct!.status!,
                                      //     textAlign: TextAlign.center,
                                      //     style: TextStyle(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: Theme.of(context).brightness==Brightness.dark?
                                      //         Color.fromRGBO(255, 255, 255, 1):
                                      //         Color.fromRGBO(0, 0, 0, 1)
                                      //     ),),
                                      // ),
                                      Container(
                                        width: 90,
                                        height: 24,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).brightness==Brightness.dark?
                                            Color.fromRGBO(29, 29, 29, 1):
                                            Color.fromRGBO(240, 240, 240, 1)
                                        ),
                                        child: Text(widget.orderstatus,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).brightness==Brightness.dark?
                                              Color.fromRGBO(255, 255, 255, 1):
                                              Color.fromRGBO(0, 0, 0, 1)
                                          ),),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text( "Qty : "+widget.productQty,
                                        // maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                        ),),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(AppData.currency!.code !+
                                          double.parse(orderTotal.toString()).toStringAsFixed(2),style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):
                                          Color.fromRGBO(0, 0, 0, 1)
                                      ),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(thickness: 0.5,),
                          SizedBox(
                            height: 15,
                          ),
                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     // SizedBox(width: 24,),
                          //     Icon(Icons.done,size: 35,),
                          //     // SizedBox(width: 66,),
                          //     Icon(Icons.person,size: 35),
                          //     // SizedBox(width: 66,),
                          //     Icon(Icons.local_shipping_outlined,size: 35),
                          //     // SizedBox(width: 66,),
                          //     Icon(Icons.check_box_outline_blank_rounded,size: 35,)
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // IconStepper(
                          //   direction: Axis.horizontal,
                          //   enableNextPreviousButtons: false,
                          //   enableStepTapping:false,
                          //   activeStepColor:  Theme.of(context).brightness==Brightness.dark?
                          //   Color.fromRGBO(255, 76, 59,1):Color.fromRGBO(0, 0, 0, 1),
                          //   stepPadding: 0.0,
                          //   stepColor: Color.fromRGBO(50, 50, 50, 1),
                          //   activeStepBorderWidth: 0.0,
                          //   activeStepBorderPadding: 0.0,
                          //   lineColor: Theme.of(context).brightness==Brightness.dark?
                          //       Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                          //   lineLength: 66.0,
                          //   lineDotRadius: 2.0,
                          //   stepRadius: 15.0,
                          //   icons: [
                          //     Icon(Icons.check,color:Theme.of(context).brightness==Brightness.dark?
                          //     Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                          //     Icon(Icons.check,color:Theme.of(context).brightness==Brightness.dark?
                          //     Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                          //     Icon(Icons.check,color:Theme.of(context).brightness==Brightness.dark?
                          //     Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),),
                          //     Icon(Icons.check,color:Theme.of(context).brightness==Brightness.dark?
                          //     Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1))
                          //   ],
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text("Order Status Details",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).brightness==Brightness.dark?
                                  Color.fromRGBO(255, 255, 255, 1):
                                  Color.fromRGBO(0, 0, 0, 1)
                              ),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                            // decoration: BoxDecoration(
                            //   color: Colors.red
                            // ),
                            child: Row(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top:28.0),
                                      child: Icon(Icons.done,size: 35,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:69.0),
                                      child: Icon(Icons.person,size: 35),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 67.0),
                                      child: Icon(Icons.local_shipping_outlined,size: 35),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:64.0),
                                      child: Icon(Icons.check_box_outline_blank_rounded,size: 35,),
                                    ),
                                  ],
                                ),
                                IconStepper(
                                  direction: Axis.vertical,
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
                                  lineLength: 70.0,
                                  lineDotRadius: 1.3,
                                  stepRadius: 15.0,
                                  icons: [
                                    Icon(Icons.radio_button_checked_outlined, color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                                    Icon(Icons.radio_button_checked_outlined,color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                                    Icon(Icons.radio_button_checked_outlined,color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),),
                                    Icon(Icons.radio_button_checked_outlined,color:Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:36.0),
                                      child: Text("Order confirmed",style: TextStyle(
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(29, 29, 29,1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:78.0),
                                      child: Text("Ready for pickup",style: TextStyle(
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(29, 29, 29,1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 78.0),
                                      child: Text("On the way",style: TextStyle(
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(29, 29, 29,1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:78.0),
                                      child: Text("Delivered",style: TextStyle(
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(29, 29, 29,1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  );
                  // return Text(state.shipmentTrack[0].shipment!.status.status);
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
            ),
          ],
        ),
        );
  }
}





