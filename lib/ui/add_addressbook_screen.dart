import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/add_addressbook/add_addressbook_bloc.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_kundol/models/country.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/ui/my_address_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:flutter/scheduler.dart';
import '../blocs/cityy/city_bloc.dart';
import '../blocs/cityy/city_event.dart';
import '../blocs/cityy/city_state.dart';
import '../blocs/countries/countries_event.dart';
import '../blocs/countryy/country_bloc.dart';
import '../blocs/countryy/country_event.dart';
import '../blocs/countryy/country_state.dart';
import '../blocs/statee/statee_bloc.dart';
import '../blocs/statee/statee_event.dart';
import '../blocs/statee/statee_state.dart';
import '../constants/app_constants.dart';
import '../models/cityy.dart';
import '../models/countryy.dart';
import '../models/statee.dart';
import '../tweaks/app_localization.dart';

class AddAddressBookScreen extends StatefulWidget {
  final AddressData? addressData;

  const AddAddressBookScreen(this.addressData);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressBookScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
//  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  double latitude = 0.0, longitude = 0.0;
  Countryy? selectedCountry;
  Statee? selectedState;
  Cityy? selectedCity;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryyBloc>(context).add(GetCountryy());
    if (widget.addressData != null) {
      _firstNameController.text =
          widget.addressData!.customer!.customerFirstName!;
      _lastNameController.text =
          widget.addressData!.customer!.customerLastName!;
      _addressController.text = widget.addressData!.streetAddress!;
      //   _cityController.text = widget.addressData!.city!;
      _postCodeController.text = widget.addressData!.postcode!;
      _phoneController.text = widget.addressData!.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
      // appBar:AppConfig.APP_BAR_COLOR == 2 ?
      // AppBar(
      //   centerTitle: true,
      //   iconTheme: Theme.of(context).iconTheme,
      //   backgroundColor: Theme.of(context).cardColor,
      //   title:
      //   Text(
      //       AppLocalizations.of(context)!.translate("Add Address")!,
      //       style: Theme.of(context).textTheme.titleLarge),
      //   elevation: 0.0,
      // ):
      //     AppConfig.APP_BAR_COLOR == 1 ?
      // AppBar(
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
      //   backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
      //   title:
      //   Text(
      //       AppLocalizations.of(context)!.translate("Add Address")!,
      //       style: TextStyle(
      //         color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white
      //       )),
      //   elevation: 0.0,
      // ):
      //     AppBar(
      //       iconTheme: Theme.of(context).iconTheme,
      //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //       title:
      //       Text("Add Address", style: Theme.of(context).textTheme.titleLarge),
      //       elevation: 0.0,
      //     ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(18, 18, 18, 1)
              : Color.fromRGBO(255, 255, 255, 1),
          title: Text(
            "Add New Address",
            style: GoogleFonts.gothicA1(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromRGBO(18, 18, 18, 1),
                fontSize: 18,
                fontWeight: FontWeight.w900),
          )),
      body: BlocListener<AddAddressBookBloc, AddAddressBookState>(
        listener: (context, state) {
          if (state is AddAddressBookLoaded) {
            AddressData addressData = AddressData();
            addressData.customer = AddressCustomer();
            addressData.customer?.customerFirstName = _firstNameController.text;
            addressData.customer?.customerLastName = _lastNameController.text;
            addressData.streetAddress = _addressController.text;
            //   addressData.city = _cityController.text;
            addressData.phone = _phoneController.text;
            addressData.postcode = _postCodeController.text;

            CountryId countryId = CountryId();
            countryId.countryName = selectedCountry?.countryName;
            countryId.countryId = selectedCountry?.countryId;
            addressData.countryId = countryId;

            StateId stateId = StateId();
            stateId.name = selectedState?.name;
            stateId.id = selectedState?.id;
            addressData.stateId = stateId;

            Cityy city = Cityy();
            city.name = selectedCity?.name;
            city.id = selectedCity?.id;
            addressData.city = city.name;

            AppConstants.showMessage(context,state.addAddressResponse.message!,Colors.green);

            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.addAddressResponse.message!)));

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (c) => BlocProvider(
                    create: (BuildContext context) {
                      return AddressBloc(RealAddressRepo())..add(GetAddress());
                    },
                    child: MyAddressScreen())));
          } else if (state is AddAddressBookError) {
            AppConstants.showMessage(context,state.error,Colors.red);
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.only(left: 15, right: 15),
                    //         child: TextFormField(
                    //           controller: _firstNameController,
                    //           decoration: InputDecoration(
                    //             hintText: "First Name",
                    //             hintStyle: TextStyle(
                    //                 color: Colors.grey[400], fontSize: 12),
                    //             border: InputBorder.none,
                    //           ),
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return 'Please enter Your First name';
                    //             }
                    //             return null;
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.only(left: 15, right: 15),
                    //         child: TextFormField(
                    //           controller: _lastNameController,
                    //           decoration: InputDecoration(
                    //             hintText: "Last Name",
                    //             hintStyle: TextStyle(
                    //                 color: Colors.grey[400], fontSize: 12),
                    //             border: InputBorder.none,
                    //           ),
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return 'Please enter Your Last Name';
                    //             }
                    //             return null;
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: AppConfig.PLACE_PICKER_API_KEY,
                                      onPlacePicked: (result) {
                                        print(
                                            "${result.geometry?.location.lat}---${result.geometry?.location.lng}");
                                        setState(() {
                                          latitude =
                                              result.geometry!.location.lat;
                                          longitude =
                                              result.geometry!.location.lng;

                                          _addressController.text =
                                              result.formattedAddress!;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      initialPosition: const LatLng(0.0, 0.0),
                                      useCurrentLocation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset(
                                "assets/images/map image.jpg",
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 8, top: 8),
                        child: Row(
                          children: [
                            Text(
                              "*",
                              style: GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            Text(
                              "FIRST NAME",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(29, 29, 29, 1)
                              : Color.fromRGBO(240, 240, 240, 1),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              width: 1.0), // set border width
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          style: GoogleFonts.gothicA1(
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                          ),
                          cursorColor: Color.fromRGBO(255, 76, 59, 1),
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(29, 29, 29, 1)
                                    : Color.fromRGBO(240, 240, 240, 1),
                            hintText: AppLocalizations.of(context)!
                                .translate("First Name")
                                .toString(),
                            hintStyle:  GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 16),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('Please enter Your First name')
                                  .toString();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 8, top: 8),
                        child: Row(
                          children: [
                            Text(
                              "*",
                              style:  GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            Text(
                              "LAST NAME",
                              style:  GoogleFonts.gothicA1(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(29, 29, 29, 1)
                              : Color.fromRGBO(240, 240, 240, 1),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              width: 1.0), // set border width
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          cursorColor: Color.fromRGBO(255, 76, 59, 1),
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(29, 29, 29, 1)
                                    : Color.fromRGBO(240, 240, 240, 1),
                            hintText: AppLocalizations.of(context)!
                                .translate("Last Name")
                                .toString(),
                            hintStyle: GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('Please enter Your Last Name')
                                  .toString();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 8, top: 8),
                        child: Row(
                          children: [
                            Text(
                              "*",
                              style: GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            Text(
                              "COUNTRY",
                              style:  GoogleFonts.gothicA1(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        )),
                    BlocBuilder<CountryyBloc, CountryyState>(
                      builder: (context, country) {
                        if (country is CountryyLoaded) {
                          List<Countryy> countryDataList = country.countryyData.where((country) => country.countryName == 'India').toList();
                          // Countryy otherCountryData = Countryy();
                          // otherCountryData.countryName =
                          //     AppLocalizations.of(context)!
                          //         .translate("Other")
                          //         .toString();
                          // otherCountryData.countryId = 0;
                          // // otherCountryData.states = [];
                          // countryDataList.add(otherCountryData);
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(29, 29, 29, 1)
                                        : Color.fromRGBO(240, 240, 240, 1),
                                    border: Border.all(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color.fromRGBO(29, 29, 29, 1)
                                            : Color.fromRGBO(240, 240, 240, 1),
                                        width: 1.0), // set border width
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            10.0)), // set rounded corner radius
                                  ),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromRGBO(29, 29, 29, 1)
                                          : Color.fromRGBO(240, 240, 240, 1),
                                    ),
                                    child:
                                    DropdownSearch<Countryy>(

                                      // mode: Mode.DIALOG,
                                      // dropDownButton: const Text(""),

                                      popupProps:  PopupProps.dialog(
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          style:GoogleFonts.gothicA1(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(255, 76, 59, 1), // Change this color
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(255, 76, 59, 1), // Change this color
                                              ),
                                            ),
                                          ),
                                          cursorColor: Color.fromRGBO(255, 76, 59, 1)
                                        )
                                      ),
                                      items: countryDataList,

                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              baseStyle:GoogleFonts.gothicA1(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                              ),
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                        // border: OutlineInputBorder(
                                        //   borderSide: BorderSide(color: Color.fromRGBO(255, 76, 59, 1)),
                                        // ),
                                        fillColor: Theme.of(context)
                                                    .brightness ==
                                                Brightness.dark
                                            ? Color.fromRGBO(29, 29, 29, 1)
                                            : Color.fromRGBO(240, 240, 240, 1),
                                        hintText: AppLocalizations.of(context)!
                                            .translate("Country")
                                            .toString(),
                                        contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                                        hintStyle:  GoogleFonts.gothicA1(
                                            color: Theme.of(context).brightness == Brightness.dark
                                                ? Color.fromRGBO(255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        border: InputBorder.none,
                                      )),
                                      itemAsString: (Countryy? u) =>
                                          u!.countryName!,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCountry = value!;
                                          BlocProvider.of<StateeBloc>(context)
                                              .add(GetStatee(selectedCountry!.countryId));
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          );
                        } else if (country is CountryyLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(255, 76, 59, 1),
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(255, 76, 59, 1),
                          ),
                        );
                        // else {
                        //   return Center(child: Text(
                        //       AppLocalizations.of(context)!.translate("Something went wrong")!
                        //   ));
                        // }
                      },
                    ),
                    if (selectedCountry != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "*",
                                    style:  GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1)),
                                  ),
                                  Text(
                                    "STATE",
                                    style:  GoogleFonts.gothicA1(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1)),
                                  ),
                                ],
                              )),
                          BlocBuilder<StateeBloc, StateeState>(
                              builder: (context, state) {
                            if (state is StateeLoaded) {
                              List<Statee> stateDataList = state.stateeData;
                              Statee otherstateData = Statee();
                              otherstateData.name =
                                  AppLocalizations.of(context)!
                                      .translate("Other")
                                      .toString();
                              otherstateData.countryId = 0;
                              // otherCountryData.states = [];
                              stateDataList.add(otherstateData);
                              return (Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Color.fromRGBO(29, 29, 29, 1)
                                                : Color.fromRGBO(
                                                    240, 240, 240, 1),
                                            width: 1.0), // set border width
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                10.0)), // set rounded corner radius
                                      ),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Color.fromRGBO(29, 29, 29, 1)
                                              : Color.fromRGBO(
                                                  240, 240, 240, 1),
                                        ),
                                        child: DropdownSearch<Statee>(
                                          // mode: Mode.DIALOG,
                                          // dropDownButton: const Text(""),
                                          popupProps: PopupProps.dialog(
                                            showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                  style:GoogleFonts.gothicA1(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(255, 76, 59, 1), // Change this color
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(255, 76, 59, 1), // Change this color
                                                      ),
                                                    ),
                                                  ),
                                                  cursorColor: Color.fromRGBO(255, 76, 59, 1)
                                              ),

                                          ),
                                          items: state.stateeData,
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                                  baseStyle:GoogleFonts.gothicA1(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  dropdownSearchDecoration:
                                                      InputDecoration(fillColor: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Color.fromRGBO(29, 29, 29, 1)
                                                : Color.fromRGBO(
                                                    240, 240, 240, 1),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .translate("State")
                                                    .toString(),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    12, 12, 0, 0),
                                            hintStyle:  GoogleFonts.gothicA1(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Color.fromRGBO(
                                                        255, 255, 255, 1)
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            border: InputBorder.none,
                                          )),
                                          itemAsString: (Statee? u) => u!.name!,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedState = value!;
                                              BlocProvider.of<CityyBloc>(
                                                      context)
                                                  .add(GetCityy(
                                                      (selectedState?.id)));

                                              // States otherState = States();
                                              // otherState.id = 0;
                                              //  otherState.name =
                                              // AppLocalizations.of(context)!.translate('Other')!;
                                              //   selectedCountry?.states?.add(otherState);
                                            });
                                            print("city value ${value?.id}");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(255, 76, 59, 1),
                              ),
                            );
                          }),
                        ],
                      ),
                    if (selectedState != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "*",
                                    style:  GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1)),
                                  ),
                                  Text(
                                    "CITY",
                                    style:  GoogleFonts.gothicA1(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1)),
                                  ),
                                ],
                              )),
                          BlocBuilder<CityyBloc, CityyState>(
                              builder: (context, city) {
                            if (city is CityyLoaded) {
                              List<Cityy> cityyDataList = city.cityyData;
                              Cityy othercityData = Cityy();
                              othercityData.name = AppLocalizations.of(context)!
                                  .translate("Other")
                                  .toString();
                              othercityData.countryId = 0;
                              // otherCountryData.states = [];
                              cityyDataList.add(othercityData);
                              return (Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Color.fromRGBO(29, 29, 29, 1)
                                                : Color.fromRGBO(
                                                    240, 240, 240, 1),
                                            width: 1.0), // set border width
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                10.0)), // set rounded corner radius
                                      ),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Color.fromRGBO(29, 29, 29, 1)
                                              : Color.fromRGBO(
                                                  240, 240, 240, 1),
                                        ),
                                        child: DropdownSearch<Cityy>(
                                          // mode: Mode.DIALOG,
                                          // dropDownButton: const Text(""),
                                          popupProps: PopupProps.dialog(
                                            showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                  style:GoogleFonts.gothicA1(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(255, 76, 59, 1), // Change this color
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(255, 76, 59, 1), // Change this color
                                                      ),
                                                    ),
                                                  ),
                                                  cursorColor: Color.fromRGBO(255, 76, 59, 1)
                                              )
                                          ),
                                          items: city.cityyData,
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                                  baseStyle:GoogleFonts.gothicA1(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                            fillColor: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Color.fromRGBO(29, 29, 29, 1)
                                                : Color.fromRGBO(
                                                    240, 240, 240, 1),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .translate("City")
                                                    .toString(),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    12, 12, 0, 0),
                                            hintStyle: GoogleFonts.gothicA1(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Color.fromRGBO(
                                                        255, 255, 255, 1)
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            border: InputBorder.none,
                                          )),
                                          itemAsString: (Cityy? u) => u!.name!,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCity = value!;
                                              //  States otherState = States();
                                              //  otherState.id = 0;
                                              //  otherState.name =
                                              //  AppLocalizations.of(context)!.translate('Other')!;
                                              //   selectedCountry?.states?.add(otherState);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(255, 76, 59, 1),
                              ),
                            );
                          }),
                        ],
                      ),
//  Pick Location commented - Vignesh
                    //  Padding(
                    //     padding: EdgeInsets.only(left: 15, right: 15,bottom: 8,top: 8),
                    //     // child: Text(
                    //        //   AppLocalizations.of(context)!.translate("Pick Location").toString(),
                    //      //   ),),
                    //     child: Row(
                    //       children: [
                    //         Text("*"),
                    //         Text(
                    //            AppLocalizations.of(context).translate("Pick Location").toString(),
                    //           ),
                    //       ],
                    //     ),
                    //       ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => PlacePicker(
                    //           apiKey: AppConfig.PLACE_PICKER_API_KEY,
                    //           onPlacePicked: (result) {
                    //             print("${result.geometry?.location.lat}---${result.geometry?.location.lng}");
                    //             setState(() {
                    //               latitude = result.geometry!.location.lat;
                    //               longitude = result.geometry!.location.lng;
                    //
                    //               _addressController.text =
                    //                   result.formattedAddress!;
                    //             });
                    //             Navigator.of(context).pop();
                    //           },
                    //           initialPosition: const LatLng(0.0, 0.0),
                    //           useCurrentLocation: true,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15, right: 15),
                    //     child: Container(
                    //       padding: const EdgeInsets.only(left:12 ),
                    //       height: 45,
                    //       width: double.maxFinite,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //             color: Colors.grey,
                    //             width: 1.0), // set border width
                    //         borderRadius: const BorderRadius.all(
                    //             Radius.circular(
                    //                 10.0)), // set rounded corner radius
                    //       ),
                    //       child: Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           (latitude == null)
                    //               ? "Location"
                    //               : "$latitude, $longitude",
                    //           style: TextStyle(
                    //               color: Theme.of(context).brightness == Brightness.dark ? Colors.white :  Colors.grey, fontSize: 14),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 8, top: 8),
                        child: Row(
                          children: [
                            Text(
                              "*",
                              style: GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            Text(
                              //  "Address"
                              "ADDRESS",
                              style:  GoogleFonts.gothicA1(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(29, 29, 29, 1)
                              : Color.fromRGBO(240, 240, 240, 1),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              width: 1.0), // set border width
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextFormField(
                          controller: _addressController,
                          style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          cursorColor: Color.fromRGBO(255, 76, 59, 1),
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(29, 29, 29, 1)
                                    : Color.fromRGBO(240, 240, 240, 1),
                            hintText: AppLocalizations.of(context)!
                                .translate("Address")
                                .toString(),
                            hintStyle:  GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('Please enter Your Address')
                                  .toString();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.only(left: 15, right: 15,bottom: 8,top: 8),
                    //     child: Text(
                    //         AppLocalizations.of(context)!.translate("City")!
                    //     )),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15, right: 15),
                    //   child: Container(
                    //     padding: const EdgeInsets.only(bottom: 6,left:12 ),
                    //     height: 45,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //           color: Colors.grey,
                    //           width: 1.0), // set border width
                    //       borderRadius: const BorderRadius.all(
                    //           Radius.circular(
                    //               10.0)), // set rounded corner radius
                    //     ),
                    //     child: TextFormField(
                    //       controller: _cityController,
                    //       decoration: InputDecoration(
                    //         hintText:
                    //         AppLocalizations.of(context)!.translate("City")!,
                    //         hintStyle: TextStyle(color:Theme.of(context).brightness == Brightness.dark ? Colors.white :  Colors.grey, fontSize: 14),
                    //         border: InputBorder.none,
                    //       ),
                    //       validator: (value) {
                    //         if (value == null || value.isEmpty) {
                    //           return
                    //             AppLocalizations.of(context)!.translate('Please select Your City')!;
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //   ),
                    // ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 8, top: 8),
                        child: Row(
                          children: [
                            Text(
                              "*",
                              style:  GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            Text(
                              "PHONE",
                              style:  GoogleFonts.gothicA1(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(29, 29, 29, 1)
                              : Color.fromRGBO(240, 240, 240, 1),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              width: 1.0), // set border width
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextFormField(
                          controller: _phoneController,
                          style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          cursorColor: Color.fromRGBO(255, 76, 59, 1),
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(29, 29, 29, 1)
                                    : Color.fromRGBO(240, 240, 240, 1),
                            hintText: AppLocalizations.of(context)!
                                .translate("Phone")
                                .toString(),
                            hintStyle:  GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('Please enter Your Phone')
                                  .toString();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 8, top: 8),
                        child: Row(
                          children: [
                            Text(
                              "*",
                              style:  GoogleFonts.gothicA1(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            Text(
                              "POST CODE",
                              style: GoogleFonts.gothicA1(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(29, 29, 29, 1)
                              : Color.fromRGBO(240, 240, 240, 1),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              width: 1.0), // set border width
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextFormField(
                          controller: _postCodeController,
                          style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          cursorColor: Color.fromRGBO(255, 76, 59, 1),
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(29, 29, 29, 1)
                                    : Color.fromRGBO(240, 240, 240, 1),
                            hintText: AppLocalizations.of(context)!
                                .translate("Post Code")
                                .toString(),
                            hintStyle:  GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('Please enter Your Zip Code')
                                  .toString();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(255, 76, 59, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                    onPressed: () {
                      if(selectedCountry==null){
                        AppConstants.showMessage(context,"Please select country", Colors.red);

                      }else{
                          if(selectedState==null){
                            AppConstants.showMessage(context,"Please select state", Colors.red);
                          }else{
                             if(selectedCity==null){
                               AppConstants.showMessage(context,"Please select city", Colors.red);
                             }else{
                               if (widget.addressData == null) {
                                 BlocProvider.of<AddAddressBookBloc>(context).add(
                                   AddAddressBook(
                                       _firstNameController.text,
                                       _lastNameController.text,
                                       "Male",
                                       "company",
                                       _addressController.text,
                                       "suburb",
                                       _postCodeController.text,
                                       "1994-12-12",
                                       //  _cityController.text,
                                       selectedCountry?.countryId ?? 0,
                                       selectedState?.id ?? 0,
                                       selectedCity?.id ?? 0,
                                       latitude.toString(),
                                       longitude.toString(),
                                       _phoneController.text),
                                 );
                               } else {
                                 BlocProvider.of<AddAddressBookBloc>(context).add(
                                   UpdateAddressBook(
                                       widget.addressData!.id!,
                                       _firstNameController.text,
                                       _lastNameController.text,
                                       "Male",
                                       "company",
                                       _addressController.text,
                                       "suburb",
                                       _postCodeController.text,
                                       "1994-12-12",
                                       //    _cityController.text,
                                       selectedCountry!.countryId!,
                                       selectedState!.id!,
                                       selectedCity!.id!,
                                       "123",
                                       "123",
                                       _phoneController.text),
                                 );
                               }
                             }

                          }

                      }

                    },
                    child:  Text(
                     widget.addressData==null? "Add Address":"Update Address",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gothicA1(
                          color: Color.fromRGBO(255, 255, 255, 1,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
