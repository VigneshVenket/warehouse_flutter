import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/shipment_city.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_kundol/blocs/cityy/city_event.dart';
import 'package:flutter_kundol/blocs/shipmentwithcity/shipment_event.dart';
import 'package:flutter_kundol/blocs/shipmentwithcity/shipment_state.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/models/cityy.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/models/payment_method.dart';
import 'package:flutter_kundol/ui/thank_you_screen.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../blocs/countryy/country_event.dart';
import '../blocs/shipmentwithcity/shipment_bloc.dart';
import '../tweaks/app_localization.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartData> cartItems;
 // List<ShipmentCitysResponse> cityItems;
  final AddressData addressData;
  final PaymentMethod paymentMethod;
  final CouponData? couponData;

      CheckoutScreen(
      this.cartItems, this.couponData, this.addressData, this.paymentMethod);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutScreen> {
  final TextEditingController _expMonthTextController = TextEditingController();
  final TextEditingController _expYearTextController = TextEditingController();
  final TextEditingController _cvcTextController = TextEditingController();
  final TextEditingController _cardNumberTextController = TextEditingController();

 @override
  void initState() {
    super.initState();
    BlocProvider.of<ShipmentBloc>(context).add(Shipments(widget.addressData.city!));
   
  }
  double shipping = 0;
  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double discount = 0;
    double tax = 0;
    double orderTotal = 0;

    sum(){
       subtotal = 0;
      for (int i = 0; i < widget.cartItems.length; i++) {
      subtotal += (double.parse(widget.cartItems[i].price.toString()) *
         int.parse( widget.cartItems[i].qty.toString()));
    //  shipping = 0;
    //  tax = 0;
      orderTotal = subtotal;
      print(orderTotal);
      print(subtotal);
    }
      return orderTotal;
    }
    sum();

    if (widget.couponData != null) if (widget.couponData?.type ==
        AppConstants.COUPON_TYPE_FIXED) {
      discount = double.parse(widget.couponData!.amount.toString());
    } else {
      if (widget.couponData?.type == AppConstants.COUPON_TYPE_PERCENTAGE) {
      discount =
          (double.parse(widget.couponData!.amount.toString()) / 100) * subtotal;
    }
    }
    orderTotal = orderTotal - discount;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
            AppLocalizations.of(context)!.translate("Checkout")!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body:
      BlocListener<CheckoutBloc, CheckoutState>(
        listener: (BuildContext context, state) {
          if (state is CheckoutLoaded) {
            //Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThankYouScreen()),
            );
          }
          else if (state is CheckoutError) {
            AppConstants.showMessage(context,state.error,Colors.red);

            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 15, right: 15,bottom: 5),
                        itemCount: widget.cartItems.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          AppStyles.CARD_RADIUS),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        ApiProvider.imgMediumUrlString +
                                            widget.cartItems[index]
                                                .productGallary!.gallaryName!,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                            Center(
                                                child:
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,)),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        height: 80,
                                        width: double.maxFinite,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.cartItems[index]
                                                  .productDetail!.first.title!,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: const TextStyle(fontSize: 12,  fontFamily: "MontserratSemiBold"),
                                            ),
                                            Text(
                                              AppData.currency!.code !+
                                                  double.tryParse(widget
                                                      .cartItems[index].price
                                                      .toString())
                                                      !.toStringAsFixed(2),
                                              style: TextStyle(fontSize: 12,
                                                  color:
                                                  Theme.of(context).primaryColor
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              AppLocalizations.of(context)!.translate("1, Black, Large")!,
                                              style: const TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              "Qty: ${widget.cartItems[index].qty}",
                                              style: const TextStyle(fontSize: 12),
                                            ),

                                          ],
                                        ),
                                      )
                                  ),

                                ],
                              ),
                            ),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 15);
                        },
                      ),
                      const SizedBox(height: 10.0),
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
                          ),
                          child: ListTile(
                            onLongPress: () {},
                            enabled: true,
                            isThreeLine: true,
                            leading: SvgPicture.asset(
                                "assets/icons/ic_location.svg",
                                fit: BoxFit.none),
                            title: Text(
                                "${widget.addressData.customer?.customerFirstName} ${widget.addressData.customer?.customerLastName}"),
                            // titleMedium: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: <Widget>[
                            //     Text(widget.addressData.streetAddress!),
                            //     Text(widget.addressData.phone!),
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
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
                          ),
                          child: ListTile(
                            onLongPress: () {},
                            enabled: true,
                            isThreeLine: true,
                            leading: SvgPicture.asset("assets/icons/ic_card.svg",
                                fit: BoxFit.none),
                            title: Text(
                                "${widget.addressData.customer?.customerFirstName} ${widget.addressData.customer?.customerLastName}"),
                            // titleMedium: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: <Widget>[
                            //     Text(widget.addressData.streetAddress!),
                            //     Text(widget.addressData.phone!),
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
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
                          ),
                          padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Subtotal:"
                                   //   AppLocalizations.of(context)!.translate("Subtotal:")!
                                  ),
                                  Text(AppData.currency!.code !+
                                      subtotal.toStringAsFixed(2)),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Discount:"
                                      //AppLocalizations.of(context)!.translate("Discount:")!
                                  ),
                                  Text(AppData.currency!.code !+
                                      discount.toStringAsFixed(2)),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                    // Text(AppData.currency!.code !+
                                    //  shipping.toStringAsFixed(2)),


                                  BlocBuilder<ShipmentBloc, ShipmentState>(
                                    builder: (context, state){
                                        if(state is ShipmentLoaded){
                                          shipping=double.parse(state.shipmentData.shippingCost??"0.00");
                                          print(sum());
                                          print("ok");
                                          orderTotal=shipping+sum()!;
                                         // sum();
                                          print("_________--sum_________");
                                          print(sum());
                                          return (
                                              ListView.builder(
                                                                 shrinkWrap: true,
                                                                   itemCount: 1,
                                                                   itemBuilder: (BuildContext,index){
                                                                     return
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                               children: [
                                                                                 const Text(
                                                                                   "Estimated Shipping:"
                                                                                   //AppLocalizations.of(context)!.translate("Estimated Shipping:")!
                                                                               ),
                                                                               Spacer(),
                                                                                 Text("${state.shipmentData.shippingCost??"0.00"}")
                                                                               ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                 Text("Order Total:"),
                                                                                 Spacer(),
                                                                                 Text(("\$${shipping+sum()!}").toString()),
                                                                                ],
                                                                              )
                                                                            ],

                                                                          );

                                                                       }
                                                                   )
                                );
                              }
                                       return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                            },
                          ),
                                             //   Text("${AppData.currency!.code}400"),
                                              ],
                                            ),
                              const SizedBox(
                                height: 2,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //         "Tax:"
                              //      //   AppLocalizations.of(context)!.translate("Tax:")!
                              //     ),
                              //     Text("${AppData.currency!.code}0.00"),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //         "Order Total:"
                              //       //  AppLocalizations.of(context)!.translate("Order Total:")!
                              //     ),
                              //     Text(
                              //       AppData.currency!.code !+
                              //           orderTotal.toStringAsFixed(2),
                              //       style: TextStyle(
                              //         color: Theme.of(context).primaryColor,
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      if (widget.paymentMethod.paymentMethodType == "card")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text(
                                AppLocalizations.of(context)!.translate("Card Payment")!
                            )),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //         padding:
                            //             EdgeInsets.only(left: 15, right: 15),
                            //         child: TextFormField(
                            //           controller: _expMonthTextController,
                            //           decoration: InputDecoration(
                            //             hintText: "Expiry Month",
                            //             hintStyle: TextStyle(
                            //                 color: Colors.grey[400],
                            //                 fontSize: 12),
                            //             border: InputBorder.none,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Container(
                            //         padding:
                            //             EdgeInsets.only(left: 15, right: 15),
                            //         child: TextFormField(
                            //           controller: _expYearTextController,
                            //           decoration: InputDecoration(
                            //             hintText: "Expiry Year",
                            //             hintStyle: TextStyle(
                            //                 color: Colors.grey[400],
                            //                 fontSize: 12),
                            //             border: InputBorder.none,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 5),
                            Text(
                              AppLocalizations.of(context)!.translate("Expire Month")!,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: _expMonthTextController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  hintText:
                                  AppLocalizations.of(context)!.translate("Expiry Month")!,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              AppLocalizations.of(context)!.translate("Expire Year")!,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: _expYearTextController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  hintText:
                                  AppLocalizations.of(context)!.translate("Expiry Year"),
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              AppLocalizations.of(context)!.translate("Card Cvc")!,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: _cvcTextController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  hintText:  AppLocalizations.of(context)!.translate("Card Cvc"),
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              AppLocalizations.of(context)!.translate("Card Number")!,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: _cardNumberTextController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  hintText:
                                  AppLocalizations.of(context)!.translate("Card Number"),
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return
                                      AppLocalizations.of(context)!.translate( 'Please enter Your Address');
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                  horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
              width: double.maxFinite,
              height: 40.0,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ))),
                  onPressed: () {
                    if (widget.paymentMethod.paymentMethodType == "card") {
                      if (_expYearTextController.text.isEmpty ||
                          _expMonthTextController.text.isEmpty ||
                          _cvcTextController.text.isEmpty ||
                          _cardNumberTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!.translate("Input valid payment credentials")!
                            )));
                      } else {
                        // BlocProvider.of<CheckoutBloc>(context).add(PlaceOrder(
                        //     widget.addressData.customer!.customerFirstName!,
                        //     widget.addressData.customer!.customerLastName!,
                        //     widget.addressData.streetAddress!,
                        //     widget.addressData.streetAddress!,
                        //     widget.addressData.postcode!,
                        //     widget.addressData.countryId!.countryId!,
                        //     widget.addressData.stateId!.id!,
                        //     widget.addressData.phone!,
                        //     widget.addressData.customer!.customerFirstName!,
                        //     widget.addressData.customer!.customerLastName!,
                        //     widget.addressData.city!,
                        //     widget.addressData.streetAddress!,
                        //     widget.addressData.postcode!,
                        //     widget.addressData.countryId!.countryId!,
                        //     widget.addressData.stateId!.id!,
                        //     widget.addressData.phone!,
                        //     AppData.currency!.currencyId!,
                        //     AppData.language!.id!,
                        //     widget.paymentMethod.paymentMethodName!,
                        //     "${widget.addressData.lattitude},${widget.addressData.longitude}",
                        //     _cardNumberTextController.text,
                        //     _cvcTextController.text,
                        //     _expMonthTextController.text,
                        //     _expYearTextController.text));
                      }
                    } else if (widget.paymentMethod.paymentMethodType ==
                        "webview") {
                      showWebViewForPayment();
                    } else {
                      // BlocProvider.of<CheckoutBloc>(context).add(PlaceOrder(
                      //     widget.addressData.customer!.customerFirstName!,
                      //     widget.addressData.customer!.customerLastName!,
                      //     widget.addressData.streetAddress!,
                      //     widget.addressData.streetAddress!,
                      //     widget.addressData.postcode!,
                      //     widget.addressData.countryId!.countryId!,
                      //     widget.addressData.stateId!.id!,
                      //     widget.addressData.phone!,
                      //     widget.addressData.customer!.customerFirstName!,
                      //     widget.addressData.customer!.customerLastName!,
                      //     widget.addressData.streetAddress!,
                      //    // widget.addressData.city!,
                      //     widget.addressData.streetAddress!,
                      //     widget.addressData.postcode!,
                      //     widget.addressData.countryId!.countryId!,
                      //     widget.addressData.stateId!.id!,
                      //     widget.addressData.phone!,
                      //     AppData.currency!.currencyId!,
                      //     AppData.language!.id!,
                      //     widget.paymentMethod.paymentMethodName!,
                      //     "null",
                      //     "",
                      //     "",
                      //     "",
                      //     ""));
                    }
                  },
                  child: Text(
                      AppLocalizations.of(context)!.translate("Place Order")!
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void showWebViewForPayment() async {
    var success = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              WebViewExample(widget.paymentMethod, widget.addressData)),
    );

    if (success == "Success") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ThankYouScreen()),
      );
    }
  }
}

class WebViewExample extends StatefulWidget {
  PaymentMethod paymentMethod;
  AddressData addressData;

  WebViewExample(this.paymentMethod, this.addressData);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  String url = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    url = "${AppConfig.ECOMMERCE_URL}/order-web-view";
    url += "?token=${AppData.accessToken}";
    url += "&payment_method=${widget.paymentMethod.paymentMethodName}";
    url += "&locations=${widget.addressData.lattitude},${widget.addressData.longitude}";
    url +=
        "&billing_first_name=${widget.addressData.customer?.customerFirstName}";
    url += "&billing_last_name=${widget.addressData.customer?.customerLastName}";
    url += "&billing_street_aadress=${widget.addressData.streetAddress}";
    url +=
        "&billing_country=${widget.addressData.countryId?.countryId}";
    url += "&billing_state=${widget.addressData.stateId?.id}";
    url += "&billing_city=${widget.addressData.city}";
    url += "&billing_postcode=${widget.addressData.postcode}";
    url += "&billing_phone=${widget.addressData.phone}";
    url +=
        "&delivery_first_name=${widget.addressData.customer?.customerFirstName}";
    url +=
        "&delivery_last_name=${widget.addressData.customer?.customerLastName}";
    url += "&delivery_street_aadress=${widget.addressData.streetAddress}";
    url += "&delivery_country=${widget.addressData.countryId?.countryId}";
    url += "&delivery_state=${widget.addressData.stateId?.id}";
    url += "&delivery_city=${widget.addressData.city}";
    url += "&delivery_postcode=${widget.addressData.postcode}";
    url += "&delivery_phone=${widget.addressData.phone}";
    url += "&currency_id=${AppData.currency?.currencyId}";
    url += "&language_id=${AppData.language?.id}";
    url += "&order_notes=";

    SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (progress) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
/*
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains("thankyou")) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thankyou")));
            }
            return NavigationDecision.navigate;
          },
*/
          onPageStarted: (url) {
            print(url);
            if (url.contains("thankyou")) {
              Navigator.pop(context, "Success");
            }
          },
          initialUrl: url,
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
            ),
          )
      ],
    );
  }
}
