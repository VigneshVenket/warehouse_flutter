import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/banners_response.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/nearest_warehouse/warehouse_bloc.dart';
import 'package:flutter_kundol/blocs/nearest_warehouse/warehouse_state.dart';
import 'package:flutter_kundol/blocs/shipment_creation_bloc/shipment_creation_bloc.dart';
import 'package:flutter_kundol/blocs/shipping_cost/shipping_cost_bloc.dart';
import 'package:flutter_kundol/blocs/tax/tax_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/repos/nearest_warehouse_repo.dart';
import 'package:flutter_kundol/repos/shipment_creation_repo.dart';
import 'package:flutter_kundol/repos/shipmentcity_repo.dart';
import 'package:flutter_kundol/repos/shipping_cost_repo.dart';
import 'package:flutter_kundol/repos/tax_repo.dart';
import 'package:flutter_kundol/repos/waybill_repo.dart';
import 'package:flutter_kundol/ui/checkout_address_screen.dart';
import 'package:flutter_kundol/ui/checkout_screen_new.dart';
import 'package:flutter_kundol/ui/main_screen.dart';
import 'package:flutter_kundol/ui/settings_new.dart';
import 'package:flutter_kundol/ui/shipping_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/responses/shipment_city.dart';
import '../blocs/checkout/checkout_bloc.dart';
import '../blocs/shipmentwithcity/shipment_bloc.dart';
import '../blocs/waybill/waybill_bloc.dart';
import '../repos/checkout_repo.dart';
import '../tweaks/app_localization.dart';

class CartScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  CartScreen(this.navigateToNext);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _couponTextController = TextEditingController();
  TextEditingController _gstdataTextController=TextEditingController();

  int quantity=0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CartBloc>(context).add(GetCart());

  }

  @override
  Widget build(BuildContext context) {
    CouponData? couponData;
    double subtotal = 0;
    double shipping = 0;
    double promodiscount = 0;
    double tax = 0;
    double orderTotal = 0;
    double pricediscount=0;
    bool coupenSelected=false;
    String ?coupenNotification;

    bool cartUpdated =false;
    var updatedQty;

    double gstDiscount=0.0;
    bool showGstDiscountdialog=false;



    return Scaffold(

      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(255, 255, 255, 1)
              : Color.fromRGBO(18, 18, 18, 1),),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
        title: Text(
          "Cart",style: GoogleFonts.gothicA1(
            color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
            fontSize: 18,
            fontWeight: FontWeight.w800
        ),
        ),
      ),
      body: BlocConsumer(
        listener: (context, state) {
          if (state is CartError) {
            AppConstants.showMessage(context,state.error,Colors.red);
          } else if (state is CartCouponError) {
            _couponTextController.clear();
            coupenSelected=true;
            coupenNotification=state.error;


            BlocProvider.of<CartBloc>(context).add(GetCart());
          } else if (state is CartDeleted) {
            BlocProvider.of<CartBloc>(context).add(GetCart());
          }else if(state is CartUpdated){

            cartUpdated=true;
            updatedQty=state.updatedCartData.qty;
            print(updatedQty);

            AppConstants.showMessage(context,"Cart updated successfully",Colors.green);
            print(state.updatedCartData.product_max_order);
            if(int.parse(state.updatedCartData.qty)>state.updatedCartData.product_max_order){
              showGstDiscountdialog=true;
              gstDiscount=state.updatedCartData.total*0.1;
            }
            BlocProvider.of<CartBloc>(context).add(GetCart());
          }
          else if (state is CouponApplied) {
            couponData = state.couponData;
            _couponTextController.clear();
            coupenSelected=true;
            coupenNotification="Coupon added successfully";

            BlocProvider.of<CartBloc>(context).add(GetCart());

          }else if(state is CartLoaded){
                  for(int i=0;i<state.cartData.length;i++){
                    if(state.cartData[i].qty> state.cartData[i].product_max_order){
                      showGstDiscountdialog=true;
                    }
                  }
          }
        },
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.cartData.isNotEmpty) {
              subtotal = 0;
              shipping = 0;
              tax = 0;
              orderTotal = 0;
              for (int i = 0; i < state.cartData.length; i++) {
                subtotal += (double.parse(state.cartData[i].discountPrice.toString()) *
                    (double.parse(state.cartData[i].qty.toString())));
                orderTotal = subtotal;
              }


              if (couponData != null) if (couponData?.type ==
                  AppConstants.COUPON_TYPE_FIXED) {
                promodiscount = double.parse(couponData!.amount.toString());
              } else if (couponData?.type ==
                  AppConstants.COUPON_TYPE_PERCENTAGE) {
                promodiscount = (double.parse(couponData!.amount.toString()) / 100) *
                    subtotal;
              }
              orderTotal = orderTotal - promodiscount;

             double calculateGstDiscountPrice(){

               for(int i=0;i<state.cartData.length;i++){
                  if(state.cartData[i].qty>state.cartData[i].product_max_order){
                    print(state.cartData[i].discountPrice*state.cartData[i].qty);
                    print(state.cartData[i].total);
                      gstDiscount+=state.cartData[i].total*0.1;
                  }
               }
               return gstDiscount;
             }

             calculateGstDiscountPrice();
             orderTotal=orderTotal-gstDiscount;
             print(gstDiscount);
              return
                Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.cartData.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                quantity=state.cartData[index].qty!;
                                return Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 140,
                                        width: 140,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              AppStyles.CARD_RADIUS),
                                          child:
                                          CachedNetworkImage(
                                            imageUrl:
                                            ApiProvider.imgMediumUrlString +
                                                state
                                                    .cartData[index]
                                                    .productGallary!
                                                    .gallaryName!,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) =>
                                                Center(
                                                    child:
                                                    CircularProgressIndicator(
                                                        color: Color.fromRGBO(255, 76, 59,1),
                                                        value:
                                                        downloadProgress
                                                            .progress)),
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.error,color: Color.fromRGBO(255, 76, 59,1),),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          width: double.maxFinite,
                                          height: 140,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.cartData[index]
                                                    .productDetail![0].title!
                                                    .trim(),
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                softWrap: false,
                                                style: GoogleFonts.gothicA1(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                                ),
                                              ),
                                              SizedBox(height: 15.0),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppData.currency!.code! +
                                                        double.tryParse(state
                                                            .cartData[index].discountPrice
                                                            .toString())!
                                                            .toStringAsFixed(2),
                                                    style: GoogleFonts.gothicA1(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w700,
                                                        color: Color.fromRGBO(255, 76, 59,1)
                                                    ),),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    AppData.currency!.code! +
                                                        double.tryParse(state
                                                            .cartData[index].price
                                                            .toString())!
                                                            .toStringAsFixed(2),
                                                    style: GoogleFonts.gothicA1(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      decoration:TextDecoration.lineThrough ,
                                                      color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                                    ),),
                                                ],
                                              ),
                                              SizedBox(height: 25),
                                              Container(
                                                width: 96,
                                                height: 24,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          if(state.cartData[index].qty>1){

                                                            state.cartData[index].qty--;

                                                            BlocProvider.of<CartBloc>(context).add(UpdateCart(
                                                                state.cartData[index].productId,
                                                                state.cartData[index].productCombinationId,
                                                                state.cartData[index].qty
                                                            )
                                                            );
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            border: Border.all(
                                                                color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                                                            )
                                                        ),
                                                        child: Icon(Icons.remove,
                                                            size: 20,
                                                            color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        width: 40,
                                                        height: 24,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(29, 29, 29, 1):Color.fromRGBO(240, 240, 240, 1) ,
                                                          // border: Border.all(
                                                          //     color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                                                          // )
                                                        ),
                                                        child: Center(
                                                          child: Text(state.cartData[index].qty.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: GoogleFonts.gothicA1(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14,
                                                              color:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0,0, 0, 1) ,
                                                            ),),
                                                        )
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          state.cartData[index].qty++;


                                                          BlocProvider.of<CartBloc>(context).add(UpdateCart(
                                                              state.cartData[index].productId,
                                                              state.cartData[index].productCombinationId,
                                                              state.cartData[index].qty
                                                          )
                                                          );
                                                        });



                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            border: Border.all(
                                                                color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                                                            )
                                                        ),
                                                        child: Icon(
                                                            Icons.add,
                                                            size: 20,
                                                            color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                                                        ),

                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(Icons.delete,size: 24,
                                              color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                                          ),
                                          // SvgPicture.asset(
                                          //     "assets/icons/ic_delete.svg",
                                          //     fit: BoxFit.none),
                                          onPressed: () {
                                            BlocProvider.of<CartBloc>(context)
                                                .add(DeleteCartItem(
                                                int.parse(state
                                                    .cartData[index].productId
                                                    .toString()),
                                                state.cartData[index]
                                                    .productCombinationId));

                                            // BlocProvider.of<CartBloc>(context).add(
                                            //   UpdateCart(state.cartData[index].productId,state.cartData[index].productCombinationId,state.cartData[index].qty)
                                            // );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );  },
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(height: 15);
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(thickness: 0.5,),
                            SizedBox(
                              height: 15,
                            ),
                            ClipRRect(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text("Promo Code :",style: GoogleFonts.gothicA1(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                              ),),

                                            ),
                                            // Icon(Icons.arrow_drop_down_sharp),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 12.0),
                                              padding: EdgeInsets.only(bottom: 4, left: 12),
                                              width: MediaQuery.of(context).size.width*0.78,
                                              height: 48,
                                              decoration: BoxDecoration(// set border width
                                                color:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(29, 29, 29, 1):Color.fromRGBO(240, 240, 240, 1) ,
                                                borderRadius: const BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
                                              ),
                                              child: TextField(
                                                controller: _couponTextController,
                                                style: GoogleFonts.gothicA1(),
                                                textAlignVertical: TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .translate("Enter Code Here"),
                                                  hintStyle: GoogleFonts.gothicA1(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: coupenSelected?Color.fromRGBO(74, 222, 128,1):Theme.of(context).brightness==Brightness.dark?
                                                Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                              ),
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: (){
                                                    if (_couponTextController.text.toString().trim().isNotEmpty)
                                                          {BlocProvider.of<CartBloc>(context).
                                                            add(ApplyCoupon(_couponTextController.text.toString().trim()));}
                                                          },
                                                  icon:coupenSelected?Icon(Icons.close,size: 30,color: Color.fromRGBO(255, 255, 255, 1),):Icon(Icons.add,
                                                    color: Theme.of(context).brightness==Brightness.dark?
                                                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),
                                                    size: 30,)
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        coupenSelected?Text(coupenNotification!,style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: coupenNotification=="Coupon added successfully"?Colors.green:Colors.red
                                        ),):Container(),
                                        SizedBox(height: 10),
                                        showGstDiscountdialog?
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text("GST Number :",style: GoogleFonts.gothicA1(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                                  ),),

                                                ),
                                                // Icon(Icons.arrow_drop_down_sharp),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  // padding: EdgeInsets.symmetric(
                                                  //     horizontal: 12.0),
                                                  padding: EdgeInsets.only(bottom: 4, left: 12),
                                                  width: MediaQuery.of(context).size.width*0.915,
                                                  height: 48,
                                                  decoration: BoxDecoration(// set border width
                                                    color:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(29, 29, 29, 1):Color.fromRGBO(240, 240, 240, 1) ,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
                                                  ),
                                                  child: TextField(
                                                    controller: _gstdataTextController,
                                                    style: GoogleFonts.gothicA1(),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Enter GST Number here",
                                                      hintStyle: GoogleFonts.gothicA1(
                                                          color: Theme.of(context)
                                                              .brightness ==
                                                              Brightness.dark
                                                              ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Container(
                                                //   width: 48,
                                                //   height: 48,
                                                //   decoration: BoxDecoration(
                                                //       borderRadius: BorderRadius.circular(10),
                                                //       color: coupenSelected?Color.fromRGBO(74, 222, 128,1):Theme.of(context).brightness==Brightness.dark?
                                                //       Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                                //   ),
                                                //   child: Center(
                                                //     child: IconButton(
                                                //         onPressed: (){
                                                //
                                                //         },
                                                //         icon:coupenSelected?Icon(Icons.close,size: 30,color: Color.fromRGBO(255, 255, 255, 1),):Icon(Icons.add,
                                                //           color: Theme.of(context).brightness==Brightness.dark?
                                                //           Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),
                                                //           size: 30,)
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ],
                                        ):Container()

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(thickness: 0.5,),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(AppLocalizations.of(context)!
                                        .translate("Subtotal")!,
                                    style: GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                        color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                    ),

                                    ),
                                    Text(AppData.currency!.code! +
                                        subtotal.toStringAsFixed(2),
                                      style:GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount(Coupon)",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text(AppData.currency!.code! +
                                        promodiscount.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(74, 222, 128, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount(GST)",
                                      style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Text(AppData.currency!.code! +
                                        gstDiscount.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(74, 222, 128, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total :',
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                      ),
                                    ),
                                    Text(
                                      AppData.currency!.code! +
                                          orderTotal.toStringAsFixed(2),
                                      style: GoogleFonts.gothicA1(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color:Color.fromRGBO(255, 76, 59, 1)
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 2,
                                // ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(AppLocalizations.of(context)!
                                //         .translate("Tax")!,
                                //       style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color: Theme.of(context)
                                //             .brightness ==
                                //             Brightness.dark
                                //             ? Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1),
                                //       ),
                                //     ),
                                //     Text(AppData.currency!.code! + "0.00"),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(AppLocalizations.of(context)!
                                //         .translate("Order Total")!),
                                //     Text(
                                //       AppData.currency!.code! +
                                //           orderTotal.toStringAsFixed(2),
                                //       style: TextStyle(
                                //         color:
                                //             Theme.of(context).primaryColor,
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(thickness: 0.5,),
                            SizedBox(
                              height: 15,
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

                                     widget.navigateToNext(
                                         MultiBlocProvider(
                                             providers: [
                                               BlocProvider(
                                                 create: (BuildContext context) {
                                                   return AddressBloc(RealAddressRepo())
                                                     ..add(GetAddress());
                                                 },),
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
                                                     return WarehouseBloc(RealWarehouseRepo());
                                                   }),
                                               BlocProvider(
                                                   create:(BuildContext context){
                                                     return WaybillBloc(RealWaybillRepo());
                                                   }),
                                               BlocProvider(
                                                   create:(BuildContext context){
                                                     return ShipmentCreateBloc(RealShipmentCreationRepo());
                                                   }),
                                               BlocProvider(
                                                   create:(BuildContext context){
                                                     return TaxRateBloc(RealTaxRepo());
                                                   })
                                             ],
                                             child: CheckoutAddressScreen(
                                                couponData: couponData,
                                                cartItems: state.cartData,
                                               orderAmount: orderTotal,
                                               gstDiscount: gstDiscount,
                                               gstNumber: _gstdataTextController.text,
                                             )
                                         )
                                    );
                                  },
                                  child: Text("Continue",style:GoogleFonts.gothicA1(
                                    color: Color.fromRGBO(255, 76, 59, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                  ),))
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height*0.48,
                      child: Image.asset("assets/images/cart_empty_image2-removebg-preview.png",fit: BoxFit.fill,),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("Your Cart is Empty!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gothicA1(
                          fontSize:28,
                          color:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w700
                      ),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("Looks like you haven’t made your order yet.",
                        textAlign: TextAlign.center,
                        style:GoogleFonts.gothicA1(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness==Brightness.dark?
                          Color.fromRGBO(160, 160, 160,1):
                          Color.fromRGBO(112, 112, 112, 1)
                      ) ,),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: Color.fromRGBO(255, 76, 59,1),
                            backgroundColor:Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1) ,
                            side: BorderSide(
                              color: Color.fromRGBO(255, 76, 59, 1)
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        child:Text("Shop Now",
                          style: GoogleFonts.gothicA1(
                              color: Color.fromRGBO(255, 76, 59, 1,),
                              fontSize: 18,
                              fontWeight:FontWeight.w700
                          ),),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>MainScreen()));
                                // Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          else if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(255, 76, 59, 1),
              ),
            );
          }
          else
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(255, 76, 59, 1),
              ),
            );
        },
      ),
    );
  }
}
