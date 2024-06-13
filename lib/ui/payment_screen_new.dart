import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/nearest_warehouse.dart';
import 'package:flutter_kundol/ui/thank_you_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../blocs/checkout/checkout_bloc.dart';
import '../blocs/payment_methods/payment_methods_bloc.dart';
import '../blocs/shipment_creation_bloc/shipment_creation_bloc.dart';
import '../blocs/shipment_creation_bloc/shipment_creation_event.dart';
import '../constants/app_data.dart';
import '../models/address_data.dart';
import '../models/coupon_data.dart';
import '../models/payment_method.dart';
import '../models/shipment_creation.dart';


class PaymentScreenNew extends StatefulWidget {

  AddressData? addressData;
  CouponData? couponData;
  String? waybill;
  String? prodDesc;
  double? orderAmount;
  double? orderweight;
  num? qty;
  double ?shippingcost;
  Warehouse? warehouse;
  String? gstNumber;
  double? gstDiscount;

  PaymentScreenNew({Key? key,this.addressData,this.couponData,this.waybill,this.prodDesc,this.orderAmount,this.orderweight,this.qty,this.shippingcost,required this.warehouse,required this.gstNumber,required this.gstDiscount}) : super(key: key);

  @override
  _PaymentScreenNewState createState() => _PaymentScreenNewState();
}

class _PaymentScreenNewState extends State<PaymentScreenNew> {

  PaymentMethod? paymentMethod;
  late PaymentMethodsBloc paymentMethodsBloc;

  int onPaymentSelected=-1;

  String ?razor_pay_transaction_id;

  @override
  void initState() {
    // TODO: implement initState
    paymentMethodsBloc = BlocProvider.of<PaymentMethodsBloc>(context);
    paymentMethodsBloc.add(const GetPaymentMethods());
    super.initState();
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    print(response.message);
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    razor_pay_transaction_id= response.paymentId!;
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
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
    Widget continueButton = SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1) ,
            ),
            side: const MaterialStatePropertyAll(
                BorderSide(color: Color.fromRGBO(255, 76, 59, 1))
            ),
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        child: Text("Okay",style: GoogleFonts.gothicA1(
            color: Color.fromRGBO(255, 76, 59, 1),
            fontSize: 18,
            fontWeight: FontWeight.w700
        ),),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title,style: GoogleFonts.gothicA1(
          color:Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
          fontSize: 18,
          fontWeight: FontWeight.w800
      ),),
      content: Text(message,style: GoogleFonts.gothicA1(
          color:Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
          fontSize: 16,
          fontWeight: FontWeight.w600
      ),),
      actions: [
        continueButton
      ],
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
    print(widget.orderAmount.toString()+"OrderAmount");
    // print(int.parse((widget.orderAmount!*100).toStringAsFixed(2)));

    int amount = double.parse((widget.orderAmount! * 100).toStringAsFixed(2)).toInt();
    int parsedAmount = amount.toInt();
    print(amount);

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
      // title: Text(
      //   "Payment",
      //   style: GoogleFonts.gothicA1(
      //       color: Theme.of(context).brightness == Brightness.dark
      //           ? Color.fromRGBO(255, 255, 255, 1)
      //           : Color.fromRGBO(18, 18, 18, 1),
      //       fontSize: 18,
      //       fontWeight: FontWeight.w800),
      // ),
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
          BlocListener<CheckoutBloc, CheckoutState>(
            listener: (BuildContext context, state) {
              if (state is CheckoutLoaded) {
                // BlocProvider.of<ShipmentCreateBloc>(context).add(
                //     PostShipmentCreateEvent(
                //         shipmentCreateData: ShipmentCreateData(
                //             shipments: [
                //            ShipmentsData(
                //           name: widget.addressData!.customer!.customerFirstName!,
                //           add: widget.addressData!.streetAddress!,
                //           pin: widget.addressData!.postcode!,
                //           phone: widget.addressData!.phone!,
                //           country: widget.addressData!.countryId.toString(),
                //           state: widget.addressData!.stateId.toString(),
                //           city:widget.addressData!.city!,
                //           order: state.orderPlaceResponse.data!.orderId,
                //           paymentMode: paymentMethod!.paymentMethodName!,
                //           shipmentHeight: 20,
                //           shipmentWidth: 20,
                //           shippingMode: "Surface",
                //           codAmount: widget.orderAmount!,
                //           addressType: "Home",
                //           weight: widget.orderweight!,
                //           waybill: widget.waybill!,
                //           orderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                //           products_desc: widget.prodDesc!,
                //           quantity: widget.qty!)
                //     ],
                //             pickupLocation: PickupLocation(
                //                 add:widget.warehouse!.warehouseAddress,
                //                 city: widget.warehouse!.warehouseState1,
                //                 country: widget.warehouse!.warehouseCountry1,
                //                 name: "B2CKEYTEST EXPRESS",
                //                 phone: widget.warehouse!.warehousePhone,
                //                 pinCode: widget.warehouse!.warehouseCode)
                //         )
                //     )
                // );

                //Navigator.of(context).popUntil((route) => route.isFirst);

                AppConstants.showMessage(context, "Order Placed Successfully", Colors.green);

                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text("Order Placed Successfully")));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ThankYouScreen(),), (route) => false
                );
              } else if (state is CheckoutError) {
                print(state.error);

                AppConstants.showMessage(context, state.error, Colors.red);

                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),

        ],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                  child: Text("Select a payment method",style: GoogleFonts.gothicA1(
                      color:Color.fromRGBO(255, 76, 59, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),),
                ),
              ),
              SizedBox(height: 10,),
              BlocBuilder<PaymentMethodsBloc,PaymentMethodsState>
                (
                  bloc: paymentMethodsBloc,
                  builder:(context, state) {
                    if(state is PaymentMethodsLoading){
                      return const CircularProgressIndicator(
                        color: Color.fromRGBO(255, 76, 59,1),
                      );
                    }
                    else if(state is PaymentMethodsError){
                      return Text(state.error);
                    }else if(state is PaymentMethodsLoaded){
                      return Container(
                        width: MediaQuery.of(context).size.width*0.95,
                        height: MediaQuery.of(context).size.height*0.15,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:state.paymentMethodsResponse.data?.length,
                            itemBuilder: (context,index){
                              if(state.paymentMethodsResponse.data![index].paymentMethodId==4||state.paymentMethodsResponse.data![index].paymentMethodId==9){
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          paymentMethod=state.paymentMethodsResponse.data![index];
                                          onPaymentSelected=index;
                                        });

                                        if(state.paymentMethodsResponse.data![index].paymentMethodId==9){
                                                        Razorpay razorpay = Razorpay();
                                                        var options = {
                                                          'key': 'rzp_test_uMlaurhShICIeb',
                                                          'amount':double.parse((widget.orderAmount! * 100).toStringAsFixed(2)).toInt(),
                                                          'name': 'LIVEKART',
                                                          'description': 'Fine T-Shirt',
                                                          'retry': {'enabled': true,'max_count': 1},
                                                          'send_sms_hash': true,
                                                          'prefill': {
                                                            'contact': '8888888888',
                                                            'email': 'test@razorpay.com'
                                                          },
                                                          'external': {
                                                            'wallets': ['paytm']
                                                          }
                                                        };
                                                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                                            handlePaymentErrorResponse);
                                                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                                            handlePaymentSuccessResponse);
                                                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                                            handleExternalWalletSelected);
                                                        razorpay.open(options);

                                        }
                                        else{

                                        }
                                      },
                                      child:
                                      Row(
                                        children: [
                                          Container(
                                              width:40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color:Theme.of(context).brightness==Brightness.dark?
                                                Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                                              ),
                                              child: Image.asset("assets/images/Icon  payment checkout.png",width: 24,height: 24,)),
                                          SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.5,
                                            height: 50,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top:15.0),
                                              child: Text(state.paymentMethodsResponse.data![index].paymentMethodTitle.toString().toUpperCase(),
                                                textAlign:TextAlign.left,
                                                style: GoogleFonts.gothicA1(
                                                    color: Theme.of(context).brightness==Brightness.dark?
                                                    Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                                          onPaymentSelected==index?
                                          Icon(Icons.radio_button_on,color:Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1) ,size: 24,):
                                          Icon(Icons.radio_button_off,color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),size: 24,),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }else {
                                return SizedBox();
                              }

                            }),
                      );}
                    return Text("Empty");
                  }
              ),
              SizedBox(height: 20),
              Container(
                  width: double.maxFinite,
                  height: 45.0,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1) ,
                          ),
                          side: const MaterialStatePropertyAll(
                              BorderSide(color: Color.fromRGBO(255, 76, 59, 1))
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () {
                        // print(paymentMethod!.paymentMethodId);
                        // print(razor_pay_transaction_id);
                        print('customerFirstName: ${widget.addressData?.customer?.customerFirstName}');
                        print('customerLastName: ${widget.addressData?.customer?.customerLastName}');
                        print('streetAddress: ${widget.addressData?.streetAddress}');
                        print('postcode: ${widget.addressData?.postcode}');
                        print('countryId: ${widget.addressData?.countryId?.countryId}');
                        print('stateId: ${widget.addressData?.stateId?.id}');
                        print('phone: ${widget.addressData?.phone}');
                        print('currencyId: ${AppData.currency?.currencyId}');
                        print('languageId: ${AppData.language?.id}');
                        print('paymentMethodName: ${paymentMethod?.paymentMethodName}');
                        print('couponCode: ${widget.couponData?.couponCode}');
                        print('waybill: ${widget.waybill}');
                        print('razor_pay_transaction_id: ${razor_pay_transaction_id}');
                        print('shippingcost: ${widget.shippingcost}');
                        print('gstNumber: ${widget.gstNumber}');
                        print('gstDiscount: ${widget.gstDiscount}');
                        print('orderAmount: ${widget.orderAmount}');
                        print('orderweight: ${widget.orderweight}');
                        print('prodDesc: ${widget.prodDesc}');
                        print('qty: ${widget.qty}');
                        print('warehouseAddress: ${widget.warehouse?.warehouseAddress}');
                        print('warehouseState1: ${widget.warehouse?.warehouseState1}');
                        print('warehouseCountry1: ${widget.warehouse?.warehouseCountry1}');
                        print('warehousePhone: ${widget.warehouse?.warehousePhone}');
                        print('warehouseCode: ${widget.warehouse?.warehouseCode}');
                        BlocProvider.of<CheckoutBloc>(context).add(
                            PlaceOrder(
                               widget.addressData!.customer!.customerFirstName!,
                                widget.addressData!.customer!.customerLastName!,
                                widget.addressData!.streetAddress!,
                                widget. addressData!.streetAddress!,
                                widget. addressData!.postcode!,
                                widget.addressData!.countryId!.countryId!,
                                widget.addressData!.stateId!.id!,
                                widget.addressData!.phone!,
                                widget.addressData!.customer!.customerFirstName!,
                                widget.addressData!.customer!.customerLastName!,
                                widget.addressData!.streetAddress!,
                                // widget.addressData.city!,
                                widget.addressData!.streetAddress!,
                                widget.addressData!.postcode!,
                                widget.addressData!.countryId!.countryId!,
                                widget.addressData!.stateId!.id!,
                                widget.addressData!.phone!,
                                AppData.currency!.currencyId!,
                                AppData.language!.id!,
                                paymentMethod!.paymentMethodName!,
                                widget.addressData!.streetAddress!,
                                "",
                                "",
                                "",
                                "",
                                // widget.couponData!.couponCode==null?" ":widget.couponData!.couponCode!,
                                widget.couponData?.couponCode==null?" ":widget.couponData!.couponCode!,
                                widget.waybill!,
                                paymentMethod!.paymentMethodId==9?razor_pay_transaction_id!:"",
                                widget.shippingcost!,
                                widget.gstNumber!??" ",
                                widget.gstNumber!=null?widget.gstDiscount!:0.0,
                                [
                                  ShipmentsData(
                                      name: widget.addressData!.customer!.customerFirstName!,
                                      add: widget.addressData!.streetAddress!,
                                      pin: widget.addressData!.postcode!,
                                      phone: widget.addressData!.phone!,
                                      country: widget.addressData!.countryId.toString(),
                                      state: widget.addressData!.stateId.toString(),
                                      city:widget.addressData!.city!,
                                      // order: state.orderPlaceResponse.data!.orderId,
                                      paymentMode: paymentMethod!.paymentMethodName! =="razorpay"?"Prepaid":paymentMethod!.paymentMethodName!,
                                      shipmentHeight: 20,
                                      shipmentWidth: 20,
                                      shippingMode: "Surface",
                                      codAmount: widget.orderAmount!,
                                      addressType: "Home",
                                      weight: widget.orderweight!,
                                      waybill: widget.waybill!,
                                      orderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                      products_desc: widget.prodDesc!,
                                      quantity: widget.qty!)
                                ],
                                PickupLocation(
                                    add:widget.warehouse!.warehouseAddress,
                                    city: widget.warehouse!.warehouseState1,
                                    country: widget.warehouse!.warehouseCountry1,
                                    name: "B2CKEYTEST EXPRESS",
                                    phone: widget.warehouse!.warehousePhone,
                                    pinCode: widget.warehouse!.warehouseCode)

                            )
                        );

                        // Navigator.of(context).push(MaterialPageRoute(builder:(c)=>ThankYouScreen()));
                      },
                      child:  Text("Place the order",style: GoogleFonts.gothicA1(
                          color: Color.fromRGBO(255, 76, 59, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                      ),))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
