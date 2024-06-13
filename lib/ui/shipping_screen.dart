import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/add_address/add_address_bloc.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/ui/add_address_screen.dart';
import 'package:flutter_kundol/ui/payment_screen.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import '../api/responses/shipment_city.dart';
import '../blocs/cityy/city_bloc.dart';
import '../blocs/countryy/country_bloc.dart';
import '../blocs/statee/statee_bloc.dart';
import '../repos/cityy_repo.dart';
import '../repos/countries_repo.dart';
import '../repos/countryy_repo.dart';
import '../repos/statee_repo.dart';
import '../tweaks/app_localization.dart';

class ShippingScreen extends StatefulWidget {
  final List<CartData> cartItems;

  final CouponData? couponData;

  const ShippingScreen(this.cartItems, this.couponData);

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<ShippingScreen> {
  final int _activeStepIndex = 0;

/*
  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text('Shipping'),
            content: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                        create: (BuildContext context) {
                                      return AddAddressBloc(RealAddressRepo());
                                    }),
                                    BlocProvider(
                                        create: (context) =>
                                            CountriesBloc(RealCountriesRepo())),
                                  ],
                                  child: AddAddressScreen(
                                      widget.cartItems, widget.couponData))),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppStyles.CARD_RADIUS),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppStyles
                                  .CARD_RADIUS) //                 <--- border radius here
                              ),
                        ),
                        padding: EdgeInsets.only(top: 40, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Add A New Address"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AddressBloc, AddressState>(
                  bloc: BlocProvider.of<AddressBloc>(context),
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is AddressLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.addressData.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(
                              left: 0, right: 0, top: 12, bottom: 0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppStyles.CARD_RADIUS),
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppStyles
                                        .CARD_RADIUS) //                 <--- border radius here
                                    ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentScreen(
                                            widget.cartItems,
                                            widget.couponData,
                                            state.addressData[index])),
                                  );
                                },
                                enabled: true,
                                isThreeLine: true,
                                leading: Icon(Icons.location_pin),
                                title: Text(state.addressData[index].customer
                                        .customerFirstName +
                                    " " +
                                    state.addressData[index].customer
                                        .customerLastName),
                                titleMedium: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(state.addressData[index].city),
                                    Text(
                                        state.addressData[index].streetAddress),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is AddressError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Payment'),
            content: Container()),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Review'),
            content: Container())
      ];
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
            AppLocalizations.of(context)!.translate("Shipping")!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
/*
      body:Stepper(
        elevation: 0.0,
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
      ),
*/
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(create: (BuildContext context) {
                                    return AddAddressBloc(RealAddressRepo());
                                  }),
                                  BlocProvider(
                                      create: (context) =>
                                          CountryyBloc(RealCountryyRepo())),
                                  BlocProvider(
                                      create: (context) =>
                                          StateeBloc(RealStateeRepo())),
                                  BlocProvider(
                                      create: (context) =>
                                          CityyBloc(RealCityyRepo())),
                                ],
                                child: AddAddressScreen(
                                    widget.cartItems,
                                     widget.couponData
                                ))),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: const BorderRadius.all(Radius.circular(AppStyles
                                .CARD_RADIUS) //                 <--- border radius here
                            ),
                      ),
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              AppLocalizations.of(context)!.translate("Add A New Address")!
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<AddressBloc, AddressState>(
                bloc: BlocProvider.of<AddressBloc>(context),
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return  Center(child: CircularProgressIndicator(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
                    ));
                  }
                  else if (state is AddressLoaded) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.addressData.length,
                      itemBuilder: (context, index) => Container(
                        margin:
                            const EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 0),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppStyles.CARD_RADIUS),
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Theme.of(context).primaryColor),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(AppStyles
                                      .CARD_RADIUS) //                 <--- border radius here
                                  ),
                            ),
                            child: ListTile(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => PaymentScreen(
                                //
                                //           widget.cartItems,
                                //           widget.couponData,
                                //           state.addressData[index]
                                //           )),
                                // );
                              },
                              enabled: true,
                              isThreeLine: true,
                              leading: const Icon(Icons.location_pin),
                              title: Text("${state.addressData[index].customer
                                      ?.customerFirstName} ${state.addressData[index].customer
                                      ?.customerLastName}"),
                              // titleMedium: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: <Widget>[
                              //     Text(state.addressData[index].city!),
                              //     Text(state.addressData[index].streetAddress!),
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  else if (state is AddressError) {
                    print("Address error ${AddressError}");
                    print(state);
                   //  ScaffoldMessenger.of(context)
                     //  .showSnackBar(SnackBar(content: Text(state.error)));
                    return Center(child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                    ),);
                  }
                  else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
