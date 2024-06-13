import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/orders_data.dart';

import '../tweaks/app_localization.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrdersData ordersData;

  const OrderDetailScreen(this.ordersData);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {

    double subtotal = 0;
    double shipping = 0;
    double tax = 0;
    double orderTotal = 0;

    for (int i = 0; i < widget.ordersData.orderDetail!.length; i++) {
      subtotal += double.parse(widget.ordersData.orderDetail![i].productPrice.toString());
      shipping = 0;
      tax = 0;
      orderTotal = subtotal;
    }


    return Scaffold(
      backgroundColor:
      Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor:
        Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(18, 18, 18, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        title: Text(
            AppLocalizations.of(context)!.translate("Order Detail")!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 15, right: 15),
                itemCount: widget.ordersData.orderDetail!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => Container(
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
                                imageUrl:
                                ApiProvider.imgMediumUrlString +
                                    widget.ordersData.orderDetail![index].product
                                        !.productGallary
                                        !.gallaryName!,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(

                                        // child: CircularProgressIndicator(
                                        //   color: Colors.white,
                                        //   backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                                        // ),

                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                            backgroundColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
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
                                    widget.ordersData.orderDetail![index].product!.productSlug!,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: false,
                                    style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  AppData.currency!.code !+
                                      double.tryParse(widget.ordersData.orderDetail![index].productPrice
                                              .toString())!
                                          .toStringAsFixed(2),
                                  style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(height: 8.0,),
                                Text(
                                  AppLocalizations.of(context)!.translate("1, Black, Large")!,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Qty: ${widget.ordersData.orderDetail![index].productQty}",
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
              const SizedBox(height: 12,),
              // Divider(
              //   thickness: 4,
              //   color: Color(0xFFE6E8E9),
              // ),
              ClipRRect(
                borderRadius:
                BorderRadius.circular(AppStyles.CARD_RADIUS),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0), // set border width
                    borderRadius: const BorderRadius.all(
                        Radius.circular(
                            10.0)), // set rounded corner radius
                  ),
                     child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          const Icon(Icons.location_pin,color: Colors.grey,),
                          const SizedBox(width: 25,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.ordersData.deliveryFirstName} ${widget.ordersData.billingLastName}"),
                              const SizedBox(height: 5,),
                              Text(widget.ordersData.deliveryStreetAadress!,style: const TextStyle(color: Colors.grey,),),
                              Text(widget.ordersData.deliveryPhone!,style: const TextStyle(color: Colors.grey,),),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   onLongPress: () {},
              //   enabled: true,
              //   isThreeLine: true,
              //   tileColor: Colors.white,
              //   leading: Icon(Icons.location_pin),
              //   title: Text(),
              //   titleMedium: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(),
              //       Text(),
              //     ],
              //   ),
              // ),
              // Divider(
              //   thickness: 4,
              //   color: Color(0xFFE6E8E9),
              // ),
              const SizedBox(height: 12,),
              ClipRRect(
                borderRadius:
                BorderRadius.circular(AppStyles.CARD_RADIUS),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0), // set border width
                    borderRadius: const BorderRadius.all(
                        Radius.circular(
                            10.0)), // set rounded corner radius
                  ), child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          const Icon(Icons.account_balance_wallet,color: Colors.grey,),
                          const SizedBox(width: 25,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.ordersData.deliveryFirstName} ${widget.ordersData.billingLastName}"),
                              const SizedBox(height: 5,),
                              Text(widget.ordersData.deliveryStreetAadress!,style: const TextStyle(color: Colors.grey,),),
                              Text(widget.ordersData.deliveryPhone!,style: const TextStyle(color: Colors.grey,),),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   onLongPress: () {},
              //   enabled: true,
              //   isThreeLine: true,
              //   tileColor: Colors.white,
              //   leading: Icon(Icons.account_balance_wallet),
              //   title: Text(),
              //   titleMedium: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(),
              //       Text(),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 12,),
              ClipRRect(
                borderRadius:
                BorderRadius.circular(AppStyles.CARD_RADIUS),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0), // set border width
                    borderRadius: const BorderRadius.all(
                        Radius.circular(
                            10.0)), // set rounded corner radius
                  ),  padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.translate( "Subtotal:")!
                          ),
                          Text(AppData.currency!.code !+ subtotal.toStringAsFixed(2)),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.translate("Discount:")!
                          ),
                          Text("${AppData.currency!.code}0.00"),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.translate("Estimated Shipping:")!
                          ),
                          Text("${AppData.currency!.code}0.00"),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.translate("Tax:")!
                          ),
                          Text("${AppData.currency!.code}0.00"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.translate("Order Total:")!
                          ),
                          Text(
                            AppData.currency!.code !+ orderTotal.toStringAsFixed(2),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
