import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/shipping_cost/shipping_cost_state.dart';
import 'package:flutter_kundol/repos/countryy_repo.dart';
import 'package:flutter_kundol/ui/add_address_screen_book_checkout.dart';
import 'package:flutter_kundol/ui/checkout_screen_v2.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/add_addressbook/add_addressbook_bloc.dart';
import '../blocs/address/address_bloc.dart';
import '../blocs/cityy/city_bloc.dart';
import '../blocs/countryy/country_bloc.dart';
import '../blocs/nearest_warehouse/warehouse_bloc.dart';
import '../blocs/nearest_warehouse/warehouse_event.dart';
import '../blocs/nearest_warehouse/warehouse_state.dart';
import '../blocs/shipping_cost/shipping_cost_bloc.dart';
import '../blocs/shipping_cost/shipping_cost_event.dart';
import '../blocs/statee/statee_bloc.dart';
import '../blocs/tax/tax_bloc.dart';
import '../blocs/tax/tax_event.dart';
import '../blocs/tax/tax_state.dart';
import '../blocs/waybill/waybill_bloc.dart';
import '../blocs/waybill/waybill_event.dart';
import '../blocs/waybill/waybill_state .dart';
import '../constants/app_constants.dart';
import '../models/address_data.dart';
import '../models/cart_data.dart';
import '../models/coupon_data.dart';
import '../models/nearest_warehouse.dart';
import '../repos/address_repo.dart';
import '../repos/cityy_repo.dart';
import '../repos/statee_repo.dart';
import 'my_address_screen.dart';
import 'my_address_screen_checkout_navigation.dart';


class CheckoutAddressScreen extends StatefulWidget {

  final List<CartData> cartItems;
  final CouponData? couponData;
  final double ?gstDiscount;
  final String ?gstNumber;
  final double? orderAmount;


  const CheckoutAddressScreen({required this.couponData,required this.cartItems,required this.gstDiscount,required this.gstNumber,required this.orderAmount,Key? key}) : super(key: key);

  @override
  _CheckoutAddressScreenState createState() => _CheckoutAddressScreenState();
}

class _CheckoutAddressScreenState extends State<CheckoutAddressScreen> {

  AddressData? addressData;

  int onAddressSelected = -1;
  late AddressBloc addressBloc;
  late ShippingCostBloc shippingCostBloc;
  late TaxRateBloc taxRateBloc;
  late WarehouseBloc warehouseBloc;
  late WaybillBloc waybillBloc;
  Warehouse? warehouseData;

  @override
  void initState() {
    // TODO: implement initState
    addressBloc = BlocProvider.of<AddressBloc>(context);
    addressBloc.add(GetAddress());
    shippingCostBloc = BlocProvider.of<ShippingCostBloc>(context);
    taxRateBloc = BlocProvider.of<TaxRateBloc>(context);
    warehouseBloc = BlocProvider.of<WarehouseBloc>(context);
    waybillBloc = BlocProvider.of<WaybillBloc>(context);

    print("Address loaded");

    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {


    double subtotal = 0;
    double discount = 0;
    double shipping = 0;
    double tax = 0;
    double orderTotal = 0;
    double total_by_weight = 0;
    String? waybill;
    num qty=0;
    String  productDesc="";
    double orderTotalGst=0;


    addqty() {
      for (int i = 0; i < widget.cartItems.length; i++) {
        qty += widget.cartItems[i].qty;
      }
      print(qty);
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
        total_by_weight += (double.parse(widget.cartItems[i].productWeight.toString()));
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
      print("ordertotal"+orderTotal.toString());
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
          BlocListener<WaybillBloc,WaybillState>(
              listener: (context,state){
                if(state is WaybillLoadedState){
                  waybill=state.waybillResponse.waybill;
                  print(waybill);
                }

              }),
          BlocListener<TaxRateBloc, TaxRateState>(listener: (context, state) {
            if (state is TaxRateLoaded) {
              if (state.taxRates.length == 2) {
                // double taxSubtotal=0.0;
                // for (int i = 0; i < widget.cartItems.length; i++) {
                //   print("taxamount"+state.taxRates[0].taxAmount.toString());
                //   print("qty"+qty.toString());
                //   // tax = (double.parse(
                //   //     widget.cartItems[i].discountPrice.toString()) *
                //   //     double.parse(state.taxRates[0].taxAmount.toString()) /
                //   //     100)*2*qty ;
                //   // print("Tax $tax");
                //
                //   taxSubtotal=   (double.parse(widget.cartItems[i].discountPrice.toString()) *
                //       int.parse(widget.cartItems[i].qty.toString()));
                // }
                // print("taxsubtotal"+taxSubtotal.toString());
                tax=orderTotal*(state.taxRates[0].taxAmount/100)*2;
                print("tax"+tax.toString());

              } else {
                // for (int i = 0; i < widget.cartItems.length; i++) {
                //   tax = (double.parse(
                //       widget.cartItems[i].discountPrice.toString()) *
                //       double.parse(state.taxRates[0].taxAmount.toString()) /
                //       100)*qty;
                //   print(tax);
                // }
                tax=orderTotal*(state.taxRates[0].taxAmount/100);
                print("tax"+tax.toString());
              }
              orderTotalGst = widget.orderAmount! + tax;
              print(orderTotal);
            }
          }),
          BlocListener<ShippingCostBloc,ShippingCostState>(
              listener: (context,state){
                if(state is ShippingCostLoadedState){
                  shipping=state.shippingCostResponse.data;
                  print(waybill);
                  print(shipping);
                  orderTotalGst=orderTotalGst+shipping;
                  print(orderTotal);
                  AppConstants.showMessage(context,"Shippingcost added successfully ",Colors.green);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckoutScreenV2(
                    couponData:widget.couponData,
                    cartItems: widget.cartItems,
                    orderTotal:orderTotalGst,
                    shipping: shipping,
                    tax: tax,
                    discount: discount,
                    addressData: addressData!,
                    qty: qty,
                    waybill: waybill!,
                    proDesc: productDesc,
                    total_by_weight: total_by_weight,
                    warehouse: warehouseData!,
                    gstNumber: widget.gstNumber!,
                    gstDicount: widget.gstDiscount!,
                  )));
                }
                else if (state is ShippingCostErrorState){
                  print(state.error);
                  AppConstants.showMessage(context,"Something went wrong,please go back and try again",Colors.red);
                }
                else {
                  AppConstants.showMessage(context,"Fetching...",Colors.green);

                }
              })

        ],
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.95,
                height: MediaQuery.of(context).size.height*0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                ),
                child: Center(
                  child: Text("Select a shipping address",style: GoogleFonts.gothicA1(
                      color:Color.fromRGBO(255, 76, 59, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),),
                ),
              ),
              SizedBox(height: 10,),
              BlocBuilder<AddressBloc, AddressState>(
                  bloc: BlocProvider.of<AddressBloc>(context),
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return const CircularProgressIndicator(
                        color: Color.fromRGBO(255, 76, 59, 1),
                      );
                    } else if (state is AddressLoaded) {
                      // print(state.addressData[0].stateId!.id);
                      return Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: state.addressData.isNotEmpty
                              ?
                          Column(
                            children: [
                              ListView.builder(
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
                                              Container(
                                                  width:40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color:Theme.of(context).brightness==Brightness.dark?
                                                    Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                                                  ),
                                                  child: Image.asset("assets/images/Icon loaction checkout.png",width: 24,height: 24,)),
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
                                  }),
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
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                                create: (context) =>
                                                    AddAddressBookBloc(RealAddressRepo())),
                                            BlocProvider(
                                                create: (context) =>
                                                    CountryyBloc(RealCountryyRepo())),
                                            BlocProvider(
                                                create: (context) =>
                                                    StateeBloc(RealStateeRepo())),
                                            BlocProvider(
                                                create: (context) => CityyBloc(RealCityyRepo())),
                                          ],
                                          child: AddAddressBookScreenCheckout(null,widget.couponData,widget.cartItems,widget.gstDiscount,widget.gstNumber,widget.orderAmount),
                                        );
                                      },
                                    ));
                                  },
                                  child: Text("Add New Address",
                                    style: GoogleFonts.gothicA1(
                                      color: Color.fromRGBO(255, 76, 59, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                ),
                              )
                            ],
                          )
                              : Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 300,
                                        child: Image.asset(
                                            "assets/images/empty address data image.jpg"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "No address data found",
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
                                    ],
                                  ),
                                ),
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
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                                create: (context) =>
                                                    AddAddressBookBloc(RealAddressRepo())),
                                            BlocProvider(
                                                create: (context) =>
                                                    CountryyBloc(RealCountryyRepo())),
                                            BlocProvider(
                                                create: (context) =>
                                                    StateeBloc(RealStateeRepo())),
                                            BlocProvider(
                                                create: (context) => CityyBloc(RealCityyRepo())),
                                          ],
                                          child: AddAddressBookScreenCheckout(null,widget.couponData,widget.cartItems,widget.gstDiscount,widget.gstNumber,widget.orderAmount),
                                        );
                                      },
                                    ));
                                  },
                                  child: Text("Add New Address",
                                    style: GoogleFonts.gothicA1(
                                      color: Color.fromRGBO(255, 76, 59, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                ),
                              )
                            ],
                          )
                      );
                    } else if (state is AddressError) {
                      return Text(state.error);
                    }
                    return Text("Empty",style: GoogleFonts.gothicA1(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),);
                  }),
              const SizedBox(height: 20,),
              BlocBuilder<WarehouseBloc, WarehouseState>(
                builder: (context, state) {
                  if (state is WarehouseLoadedState) {
                    warehouseData=state.warehouse;
                    return
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
                          shippingCostBloc.add(FetchShippingCostEvent(
                            md: "S",
                            ss: "Delivered",
                            dPin: addressData!.postcode!,
                            oPin: state.warehouse.warehouseCode,
                            cgm: total_by_weight,
                            pt: "cod",
                            cod: widget.orderAmount!,
                          ));
                          waybillBloc.add(FetchWaybillEvent());
                        },
                        child: Text(
                          "Proceed to checkout",
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
                  return   SizedBox(
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
                        AppConstants.showMessage(context, "Please add address", Colors.red);
                      },
                      child: Text(
                        "Proceed to checkout",
                        style: GoogleFonts.gothicA1(
                          color: Color.fromRGBO(255, 76, 59, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}
