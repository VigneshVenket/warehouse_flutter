import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/models/nearest_warehouse.dart';
import 'package:flutter_kundol/ui/payment_screen_new.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/checkout/checkout_bloc.dart';
import '../blocs/shipment_creation_bloc/shipment_creation_bloc.dart';
import '../blocs/shipping_cost/shipping_cost_bloc.dart';
import '../constants/app_constants.dart';
import '../constants/app_data.dart';
import '../models/address_data.dart';
import '../models/cart_data.dart';
import '../models/coupon_data.dart';
import '../repos/checkout_repo.dart';
import '../repos/shipment_creation_repo.dart';
import '../repos/shipping_cost_repo.dart';


class CheckoutScreenV2 extends StatefulWidget {

  final List<CartData> cartItems;
  final CouponData? couponData;
  final double ?orderTotal;
  final double ?tax;
  final double ?shipping;
  final double?discount;
  final AddressData addressData;
  final num qty;
  final double total_by_weight;
  final String waybill;
  final String proDesc;
  final Warehouse warehouse;
  final String gstNumber;
  final double gstDicount;

  const CheckoutScreenV2({required this.couponData,required this.cartItems,required this.orderTotal,required this.shipping,required this.tax,required this.discount,required this.addressData,required this.waybill,required this.qty,required this.total_by_weight,required this.proDesc,required this.warehouse,required this.gstDicount,required this.gstNumber,Key? key}) : super(key: key);

  @override
  _CheckoutScreenV2State createState() => _CheckoutScreenV2State();
}

class _CheckoutScreenV2State extends State<CheckoutScreenV2> {
  @override
  Widget build(BuildContext context) {


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
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
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
                Text(AppData.currency!.code !+widget.orderTotal!.toStringAsFixed(2),
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
                    width:150,
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
                  ),
                  Text(AppData.currency!.code !+
                      double.tryParse(widget.cartItems[index].total.toString())
                      !.toStringAsFixed(2),
                    style: GoogleFonts.gothicA1(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .brightness ==
                          Brightness.dark
                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),

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
                Text("-"+AppData.currency!.code !+ widget.discount!.toStringAsFixed(2),
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
                Text("Discount(GST)",
                  style: GoogleFonts.gothicA1(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .brightness ==
                        Brightness.dark
                        ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                Text("-"+AppData.currency!.code !+ widget.gstDicount.toStringAsFixed(2),
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
                Text(AppData.currency!.code !+ widget.tax!.toStringAsFixed(2),
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
                Text(AppData.currency!.code !+"${widget.shipping}",
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
            Container(
                width: double.maxFinite,
                height: 45.0,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1) ,
                        ),
                        side: MaterialStatePropertyAll(
                            BorderSide(color: Color.fromRGBO(255, 76, 59, 1))
                        ),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (c){
                        return  MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                  create: (BuildContext context) {
                                    return CheckoutBloc(RealCheckoutRepo());
                                  }
                              ),
                              BlocProvider(
                                  create: (BuildContext context) {
                                    return ShippingCostBloc(RealShippingCostRepo());
                                  }
                              ),
                              BlocProvider(
                                  create:(BuildContext context){
                                    return ShipmentCreateBloc(RealShipmentCreationRepo());
                                  }),
                            ],
                            child: PaymentScreenNew(
                              addressData: widget.addressData,
                              couponData: widget.couponData,
                              orderAmount: widget.orderTotal,
                              orderweight: widget.total_by_weight,
                              prodDesc:widget.proDesc,
                              waybill: widget.waybill,
                              qty: widget.qty,
                              shippingcost: widget.shipping!.toDouble(),
                              warehouse: widget.warehouse,
                              gstNumber: widget.gstNumber,
                              gstDiscount: widget.gstDicount,
                            )
                        );
                      }));
                    },
                    child: Text("Proceed to payment",style:GoogleFonts.gothicA1(
                        color: Color.fromRGBO(255, 76, 59, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                    ),))
            ),
          ],
        ),
      ),
    );
  }
}
