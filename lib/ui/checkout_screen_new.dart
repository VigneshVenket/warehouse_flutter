// import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/shipment_city.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/nearest_warehouse/warehouse_bloc.dart';
import 'package:flutter_kundol/blocs/nearest_warehouse/warehouse_event.dart';
import 'package:flutter_kundol/blocs/nearest_warehouse/warehouse_state.dart';
import 'package:flutter_kundol/blocs/shipment_creation_bloc/shipment_creation_bloc.dart';
import 'package:flutter_kundol/blocs/shipment_creation_bloc/shipment_creation_event.dart';
import 'package:flutter_kundol/blocs/shipmentwithcity/shipment_bloc.dart';
import 'package:flutter_kundol/blocs/shipmentwithcity/shipment_state.dart';
import 'package:flutter_kundol/blocs/shipping_cost/shipping_cost_event.dart';
import 'package:flutter_kundol/blocs/shipping_cost/shipping_cost_state.dart';
import 'package:flutter_kundol/blocs/tax/tax_event.dart';
import 'package:flutter_kundol/ui/payment_screen_new.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_kundol/blocs/waybill/waybill_event.dart';
import 'package:flutter_kundol/blocs/waybill/waybill_state%20.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/models/cityy.dart';
import 'package:flutter_kundol/models/countryy.dart';
import 'package:flutter_kundol/models/shipment_creation.dart';
import 'package:flutter_kundol/ui/my_address_screen.dart';
import 'package:flutter_kundol/ui/thank_you_screen.dart';
import 'package:intl/intl.dart';

import '../blocs/checkout/checkout_bloc.dart';
import '../blocs/payment_methods/payment_methods_bloc.dart';
import '../blocs/shipmentwithcity/shipment_event.dart';
import '../blocs/shipping_cost/shipping_cost_bloc.dart';
import '../blocs/tax/tax_bloc.dart';
import '../blocs/tax/tax_state.dart';
import '../blocs/waybill/waybill_bloc.dart';
import '../constants/app_constants.dart';
import '../constants/app_data.dart';
import '../models/cart_data.dart';
import '../models/coupon_data.dart';
import '../models/payment_method.dart';
import '../repos/address_repo.dart';
import '../repos/checkout_repo.dart';
import '../repos/nearest_warehouse_repo.dart';
import '../repos/shipment_creation_repo.dart';
import '../repos/shipmentcity_repo.dart';
import '../repos/shipping_cost_repo.dart';

class CheckoutScreenNew extends StatefulWidget {
  final List<CartData> cartItems;
  final CouponData? couponData;

  const CheckoutScreenNew(this.cartItems, this.couponData);

  @override
  _CheckoutScreenNewState createState() => _CheckoutScreenNewState();
}

class _CheckoutScreenNewState extends State<CheckoutScreenNew> {
  AddressData? addressData;
  PaymentMethod? paymentMethod;

  int onPaymentSelected = -1;
  int onAddressSelected = -1;
  late AddressBloc addressBloc;
  late PaymentMethodsBloc paymentMethodsBloc;
  late WarehouseBloc warehouseBloc;
  late ShippingCostBloc shippingCostBloc;
  late TaxRateBloc taxRateBloc;
  late WaybillBloc waybillBloc;

  String? waybill;

  @override
  void initState() {
    // TODO: implement initState
    addressBloc = BlocProvider.of<AddressBloc>(context);
    addressBloc.add(GetAddress());
    paymentMethodsBloc = BlocProvider.of<PaymentMethodsBloc>(context);
    paymentMethodsBloc.add(const GetPaymentMethods());
    warehouseBloc = BlocProvider.of<WarehouseBloc>(context);
    shippingCostBloc = BlocProvider.of<ShippingCostBloc>(context);
    waybillBloc = BlocProvider.of<WaybillBloc>(context);
    taxRateBloc = BlocProvider.of<TaxRateBloc>(context);

    super.initState();
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    print(response.data.toString());
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double discount = 0;
    double shipping = 0;
    double tax = 0;
    double orderTotal = 0;
    double total_by_weight = 0;
    String productDesc = "";
    num qty = 0;

    bool shippingcostCalculated=false;

    addqty() {
      for (int i = 0; i < widget.cartItems.length; i++) {
        qty += widget.cartItems[i].qty;
      }
      // print(qty);
    }

    addqty();

    addProductName() {
      for (int i = 0; i < widget.cartItems.length; i++) {
        if (widget.cartItems.length == 1) {
          productDesc += widget.cartItems[i].productDetail!.first.title!;
          // print(widget.cartItems[i].productWeight);
        } else {
          productDesc += widget.cartItems[i].productDetail!.first.title! + ", ";
        }
      }
      // print(productDesc);
    }

    addProductName();

    sumWeight() {
      total_by_weight = 0;
      for (int i = 0; i < widget.cartItems.length; i++) {
        // print(widget.cartItems[i].productWeight);
        total_by_weight +=
            (double.parse(widget.cartItems[i].productWeight.toString()));
      }
    }

    sumWeight();

    sum() {
      subtotal = 0;
      for (int i = 0; i < widget.cartItems.length; i++) {
        subtotal +=
            (double.parse(widget.cartItems[i].discountPrice.toString()) *
                int.parse(widget.cartItems[i].qty.toString()));
        // shipping = 0;
        //  tax = 0;
        orderTotal = subtotal;
        // print(orderTotal);
        // print(subtotal);
      }
      return orderTotal;
    }

    sum();

    if (widget.couponData != null) if (widget.couponData?.type ==
        AppConstants.COUPON_TYPE_FIXED) {
      discount = double.parse(widget.couponData!.amount.toString());
    } else {
      if (widget.couponData?.type == AppConstants.COUPON_TYPE_PERCENTAGE) {
        discount = (double.parse(widget.couponData!.amount.toString()) / 100) *
            subtotal;
      }
    }
    orderTotal = orderTotal - discount + shipping + tax;
    print(orderTotal);
    // print(widget.couponData!.couponCode);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(18, 18, 18, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          "Checkout",
          style: GoogleFonts.gothicA1(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(18, 18, 18, 1),
              fontSize: 18,
              fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(255, 255, 255, 1)
              : Color.fromRGBO(18, 18, 18, 1),),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TaxRateBloc, TaxRateState>(listener: (context, state) {
            if (state is TaxRateLoaded) {
              if (state.taxRates.length == 2) {
                for (int i = 0; i < widget.cartItems.length; i++) {
                  tax = (double.parse(
                              widget.cartItems[i].discountPrice.toString()) *
                          double.parse(state.taxRates[0].taxAmount.toString()) /
                          100) * 2;
                  print(tax);
                }
              } else {
                for (int i = 0; i < widget.cartItems.length; i++) {
                  tax = (double.parse(
                          widget.cartItems[i].discountPrice.toString()) *
                      double.parse(state.taxRates[0].taxAmount.toString()) /
                      100);
                  print(tax);
                }
              }
              orderTotal = orderTotal + tax;
            }
          })
        ],
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<ShippingCostBloc,ShippingCostState>(
                    builder: (context,state){
                      if(state is ShippingCostLoadedState){
                        return BlocBuilder<TaxRateBloc,TaxRateState>
                          (builder: (context,state){
                          if(state is TaxRateLoaded){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("My Orders",style:GoogleFonts.gothicA1(
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    Text(AppData.currency!.code !+ orderTotal.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Divider(thickness: 0.5),
                                SizedBox(
                                  height: 20,
                                ),
                                ListView.separated(
                                  itemCount: widget.cartItems.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) =>Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:200,
                                        child: Text(widget.cartItems[index].productDetail!.first.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.gothicA1(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .brightness ==
                                                Brightness.dark
                                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                          ),
                                        ),
                                      ),
                                      Text(widget.cartItems[index].qty.toString()+" "+"x"+" "+AppData.currency!.code !+
                                          double.tryParse(widget.cartItems[index].discountPrice.toString())
                                          !.toStringAsFixed(2),
                                        style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 15);
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount(Coupon)",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text("-"+AppData.currency!.code !+ discount.toStringAsFixed(2),
                                      style:  GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(74, 222, 128, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tax",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text(AppData.currency!.code !+ tax!.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color:Color.fromRGBO(237, 0, 6, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Shipping",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text(AppData.currency!.code !+"${shipping}",
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(237, 0, 6, 1)
                                      ),

                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 15
                                ),
                                Divider(thickness: 0.5,),
                                SizedBox(
                                    height: 20
                                ),
                              ],
                            );
                          }
                          return  Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("My Orders",style: GoogleFonts.gothicA1(
                                      color: Theme.of(context).brightness==Brightness.dark?
                                      Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  Text(AppData.currency!.code !+ orderTotal.toStringAsFixed(2),
                                    style: GoogleFonts.gothicA1(
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Divider(thickness: 0.5),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.separated(
                                itemCount: widget.cartItems.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) =>Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:200,
                                      child: Text(widget.cartItems[index].productDetail!.first.title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                      ),
                                    ),
                                    Text(widget.cartItems[index].qty.toString()+" "+"x"+" "+AppData.currency!.code !+
                                        double.tryParse(widget.cartItems[index].discountPrice.toString())
                                        !.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    )
                                  ],
                                ),
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 15);
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Discount(Coupon)",
                                    style: GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),
                                  Text("-"+AppData.currency!.code !+ discount.toStringAsFixed(2),
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(74, 222, 128, 1)
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax",
                                    style:GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),
                                  Text(AppData.currency!.code !+ tax!.toStringAsFixed(2),
                                    style:GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Color.fromRGBO(237, 0, 6, 1)
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Shipping",
                                    style:GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),
                                  Text(AppData.currency!.code !+"${shipping}",
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(237, 0, 6, 1)
                                    ),

                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: 15
                              ),
                              Divider(thickness: 0.5,),
                              SizedBox(
                                  height: 20
                              ),
                            ],
                          );
                        }
                        );
                      }
                      else if(state is ShippingCostInitialState){
                        return BlocBuilder<TaxRateBloc,TaxRateState>
                          (builder: (context,state){
                          if(state is TaxRateLoaded){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("My Orders",style: GoogleFonts.gothicA1(
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    Text(AppData.currency!.code !+ orderTotal.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Divider(thickness: 0.5),
                                SizedBox(
                                  height: 20,
                                ),
                                ListView.separated(
                                  itemCount: widget.cartItems.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) =>Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:200,
                                        child: Text(widget.cartItems[index].productDetail!.first.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.gothicA1(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .brightness ==
                                                Brightness.dark
                                                ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                          ),
                                        ),
                                      ),
                                      Text(widget.cartItems[index].qty.toString()+" "+"x"+" "+AppData.currency!.code !+
                                          double.tryParse(widget.cartItems[index].discountPrice.toString())
                                          !.toStringAsFixed(2),
                                        style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 15);
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount(Coupon)",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text("-"+AppData.currency!.code !+ discount.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(74, 222, 128, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tax",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text(AppData.currency!.code !+ tax!.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:Color.fromRGBO(237, 0, 6, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Shipping",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text(AppData.currency!.code !+"${shipping}",
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(237, 0, 6, 1)
                                      ),

                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 15
                                ),
                                Divider(thickness: 0.5,),
                                SizedBox(
                                    height: 20
                                ),
                              ],
                            );
                          }
                          return  Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("My Orders",style: GoogleFonts.gothicA1(
                                      color: Theme.of(context).brightness==Brightness.dark?
                                      Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  Text(AppData.currency!.code !+ orderTotal.toStringAsFixed(2),
                                    style: GoogleFonts.gothicA1(
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Divider(thickness: 0.5),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.separated(
                                itemCount: widget.cartItems.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) =>Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:200,
                                      child: Text(widget.cartItems[index].productDetail!.first.title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                      ),
                                    ),
                                    Text(widget.cartItems[index].qty.toString()+" "+"x"+" "+AppData.currency!.code !+
                                        double.tryParse(widget.cartItems[index].discountPrice.toString())
                                        !.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    )
                                  ],
                                ),
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 15);
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Discount(Coupon)",
                                    style: GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),
                                  Text("-"+AppData.currency!.code !+ discount.toStringAsFixed(2),
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(74, 222, 128, 1)
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax",
                                    style:GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),
                                  Text(AppData.currency!.code !+ tax!.toStringAsFixed(2),
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Color.fromRGBO(237, 0, 6, 1)
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Shipping",
                                    style: GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),
                                  Text(AppData.currency!.code !+"${shipping}",
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(237, 0, 6, 1)
                                    ),

                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: 15
                              ),
                              Divider(thickness: 0.5,),
                              SizedBox(
                                  height: 20
                              ),
                            ],
                          );
                        }
                        );
                      }
                      else if(state is ShippingCostErrorState){
                        return CircularProgressIndicator(
                          color: Color.fromRGBO(255, 76, 59,1),
                        );
                      }
                      else return   const CircularProgressIndicator(
                          color: Color.fromRGBO(255, 76, 59,1),
                        );;
                    },
                    listener:(context,state){
                      if(state is ShippingCostLoadedState){
                        shipping=state.shippingCostResponse.data;
                        orderTotal=orderTotal+shipping;
                        shippingcostCalculated=true;
                        AppConstants.showMessage(context,"Shippingcost added successfully ",Colors.green);

                      }
                      else if (state is ShippingCostErrorState){

                        AppConstants.showMessage(context,"Something went wrong,please go back and try again",Colors.red);

                      }
                      else {
                        AppConstants.showMessage(context,"Fetching...", Colors.green);

                      }
                    }),
                BlocBuilder<AddressBloc, AddressState>(
                    bloc: BlocProvider.of<AddressBloc>(context),
                    builder: (context, state) {
                      if (state is AddressLoading) {
                        return const CircularProgressIndicator(
                          color: Color.fromRGBO(255, 76, 59, 1),
                        );
                      } else if (state is AddressLoaded) {
                        // print(state.addressData[0].stateId!.id);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Select Shipping Address",style: GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness==Brightness.dark?
                                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 5,),
                            Divider(thickness: 0.5),
                            SizedBox(height: 5,),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: state.addressData.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: state.addressData.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    addressData = state.addressData[index];
                                                    onAddressSelected = index;
                                                    taxRateBloc.add(FetchTaxRate(state.addressData[index].stateId!.id!));
                                                    warehouseBloc.add(FetchNearestWarehouseEvent(address: addressData!.streetAddress!));
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Image.asset("assets/images/Icon loaction checkout.png",width: 24,height: 24,),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width*0.75,
                                                      height: 50,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 15.0),
                                                        child: Text(state.addressData[index].streetAddress!,
                                                          maxLines: 2,
                                                          textAlign: TextAlign.left,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.gothicA1( color: Theme.of(context).brightness == Brightness.dark
                                                              ? Color.fromRGBO(255, 255, 255, 1)
                                                              : Color.fromRGBO(0, 0, 0, 1),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                    ),
                                                    onAddressSelected == index
                                                        ? Icon(Icons.radio_button_on,
                                                            color: Theme.of(context).brightness == Brightness.dark
                                                                ? Color.fromRGBO(255, 255, 255, 1)
                                                                : Color.fromRGBO(0, 0, 0, 1),
                                                            size: 24,
                                                          )
                                                        : Icon(Icons.radio_button_off,
                                                            color: Theme.of(context).brightness == Brightness.dark
                                                                ? Color.fromRGBO(255, 255, 255, 1)
                                                                : Color.fromRGBO(0, 0, 0, 1),
                                                            size: 24,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          );
                                        })
                                    : Column(
                                        children: [
                                          Text("Empty",
                                            textAlign: TextAlign.center,
                                            style:GoogleFonts.gothicA1(
                                                color: Theme.of(context).brightness == Brightness.dark? Color.fromRGBO(160, 160, 160, 1)
                                                    : Color.fromRGBO(112, 112, 112, 1),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                          SizedBox(height: 10,),
                                          SizedBox(
                                            width: double.maxFinite,
                                            height: 45,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(
                                                  Theme.of(context).brightness ==
                                                      Brightness.dark
                                                      ? Color.fromRGBO(0, 0, 0, 1)
                                                      : Color.fromRGBO(255, 255, 255, 1),
                                                ),
                                                side: const MaterialStatePropertyAll(
                                                    BorderSide(
                                                        color:
                                                        Color.fromRGBO(255, 76, 59, 1))),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (c) =>
                                                            BlocProvider(
                                                                create:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AddressBloc(
                                                                      RealAddressRepo())..add(GetAddress());
                                                                },
                                                                child: MyAddressScreen())));
                                              },
                                              child: Text("Add Address",
                                                style: GoogleFonts.gothicA1(
                                                  color: Color.fromRGBO(255, 76, 59, 1),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),),
                                            ),
                                          )
                                        ],
                                      )
                            ),
                            Divider(thickness: 0.5),
                          ],
                        );
                      } else if (state is AddressError) {
                        return Text(state.error);
                      }
                      return Text("Empty");
                    }),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<WarehouseBloc, WarehouseState>(
                        builder: (context, state) {
                          if (state is WarehouseLoadedState) {
                            return SizedBox(
                              width: double.maxFinite,
                              height: 45,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(0, 0, 0, 1)
                                        : Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  side: const MaterialStatePropertyAll(
                                      BorderSide(
                                          color:
                                              Color.fromRGBO(255, 76, 59, 1))),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  shippingCostBloc.add(FetchShippingCostEvent(
                                    md: "S",
                                    ss: "Delivered",
                                    dPin: addressData!.postcode!,
                                    oPin: state.warehouse.warehouseCode,
                                    cgm: total_by_weight,
                                    pt: "cod",
                                    cod: orderTotal,
                                  ));
                                  waybillBloc.add(FetchWaybillEvent());
                                },
                                child: Text(
                                 shippingcostCalculated? "Shipping cost added":"Calculate shipping cost",
                                  style: GoogleFonts.gothicA1(
                                    color: Color.fromRGBO(255, 76, 59, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is WarehouseErrorState) {
                            return CircularProgressIndicator(
                                color: Color.fromRGBO(255, 76, 59, 1));
                          }
                          return Container();
                        },
                      ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).brightness ==
                            Brightness.dark
                            ? Color.fromRGBO(0, 0, 0, 1)
                            : Color.fromRGBO(255, 255, 255, 1),
                      ),
                      side: const MaterialStatePropertyAll(
                          BorderSide(
                              color:
                              Color.fromRGBO(255, 76, 59, 1))),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {

                      if(addressData==null){
                        AppConstants.showMessage(context,"Please select the address before proceeding to payment",Colors.red);
                      }
                       else{
                        // Navigator.of(context).push(MaterialPageRoute(builder: (c){
                        //   return  MultiBlocProvider(
                        //       providers: [
                        //         BlocProvider(
                        //             create: (BuildContext context) {
                        //               return CheckoutBloc(RealCheckoutRepo());
                        //             }
                        //         ),
                        //         BlocProvider(
                        //             create: (BuildContext context) {
                        //               return ShippingCostBloc(RealShippingCostRepo());
                        //             }
                        //         ),
                        //         BlocProvider(
                        //             create:(BuildContext context){
                        //               return ShipmentCreateBloc(RealShipmentCreationRepo());
                        //             }),
                        //       ],
                        //       child:
                        //       PaymentScreenNew(
                        //         addressData: addressData,
                        //         couponData: widget.couponData,
                        //         orderAmount: orderTotal,
                        //         orderweight: total_by_weight,
                        //         prodDesc: productDesc,
                        //         waybill: waybill,
                        //         qty: qty,
                        //       )
                        //   );
                        // }));
                      }

                    },
                    child:  Text(
                      "Proceed to payment",
                      style: GoogleFonts.gothicA1(
                        color: Color.fromRGBO(255, 76, 59, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<WaybillBloc,WaybillState>(
                  builder: (context,state){
                    if(state is WaybillLoadedState){
                      waybill=state.waybillResponse.waybill;
                      return Container();
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// // Function to initiate Razorpay payment
// void _startRazorpayPayment() async {
//   var options = {
//     'key': 'YOUR_RAZORPAY_KEY',
//     'amount': 100, // amount in the smallest currency unit (e.g., cents)
//     'name': 'Your App Name',
//     'description': 'Payment for Order',
//     'prefill': {
//       'contact': '1234567890', // user's phone number
//       'email': 'example@example.com', // user's email
//     },
//     'external': {
//       'wallets': ['paytm'], // additional supported wallets
//     }
//   };
//
//   try {
//     _razorpay.open(options);
//   } catch (e) {
//     print("Error initiating Razorpay payment: $e");
//   }
// }