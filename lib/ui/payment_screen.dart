import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/shipment_city.dart';
import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_kundol/blocs/payment_methods/payment_methods_bloc.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/checkout_repo.dart';
import 'package:flutter_kundol/ui/checkout_screen.dart';
import '../blocs/shipmentwithcity/shipment_bloc.dart';
import '../repos/shipmentcity_repo.dart';
import '../tweaks/app_localization.dart';

class PaymentScreen extends StatefulWidget {
  // final List<CartData> cartItems;
  // final CouponData? couponData;
  // final AddressData addressData;

  const PaymentScreen();

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentScreen> {
  late PaymentMethodsBloc paymentMethodsBloc;

  @override
  void initState() {
    super.initState();

    paymentMethodsBloc = BlocProvider.of<PaymentMethodsBloc>(context);
    paymentMethodsBloc.add(const GetPaymentMethods());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0,0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
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
            "Payments",style: TextStyle(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w900
          ),
          )),
      body: BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
        bloc: paymentMethodsBloc,
        builder: (context, state) {
          if (state is PaymentMethodsLoaded) {
            return ListView.builder(
              itemCount: state.paymentMethodsResponse.data?.length,
              itemBuilder: (context, index) {
              //  if(
              //  state.paymentMethodsResponse.data![index].paymentMethodStatus == 1
              //  )
              //  {
                if(state.paymentMethodsResponse.data![index].paymentMethodId==4||state.paymentMethodsResponse.data![index].paymentMethodId==9){
                  return ListTile(
                    onTap: () {
                      //                    Navigator.push(
                      //                      context,
                      //                      MaterialPageRoute(
                      //                        builder: (context) =>
                      //                         MultiBlocProvider(
                      //                         providers: [
                      //                         BlocProvider(
                      //                          create: (BuildContext context) {
                      //                            return CheckoutBloc(RealCheckoutRepo());
                      //                          }
                      //                          ),
                      //                          BlocProvider(
                      //                          create: (BuildContext context) {
                      //                            return ShipmentBloc(RealShipmentRepo());
                      //                          }
                      //                          ),
                      // ],
                      //  child: CheckoutScreen(
                      //
                      //                            widget.cartItems,
                      //                            widget.couponData,
                      //                            widget.addressData,
                      //                            state.paymentMethodsResponse.data![index],
                      //
                      //                          ),
                      //  )
                      //                       //   BlocProvider(
                      //                       //    create: (BuildContext context) {
                      //                       //      return CheckoutBloc(RealCheckoutRepo());
                      //                       //    },
                      //                       //    child: CheckoutScreen(
                      //                       //      widget.cartItems,
                      //                       //      widget.couponData,
                      //                       //      widget.addressData,
                      //                       //      state.paymentMethodsResponse.data![index],
                      //                       //    ),
                      //                       //  ),
                      //                      ),
                      //                    );
                    },
                    enabled: true,
                    leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(29, 29, 29, 1):Color.fromRGBO(240, 240, 240, 1)
                        ),
                        child: Icon(Icons.payment, color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(18, 18, 18, 1))),
                    title: Text(state.paymentMethodsResponse.data![index].paymentMethodTitle.toString().toUpperCase(),
                      style:TextStyle(
                          color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                      ) ,),
                  );
                }

             //  }
               return Container();
              },
            );
          } else if (state is PaymentMethodsError) {
            return Text(state.error);
          } else {
            return Center(child: CircularProgressIndicator(
              color: Color.fromRGBO(255, 76, 59, 1),
            ),);
          }
        },
      ),
    );
  }
}
