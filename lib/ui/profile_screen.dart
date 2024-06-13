import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/add_addressbook/add_addressbook_bloc.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/update_profile_address/update_profile_address_bloc.dart';
import 'package:flutter_kundol/blocs/update_profile_address/update_profile_address_event.dart';
import 'package:flutter_kundol/blocs/update_profile_address/update_profile_address_state.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../blocs/profile/update_profile_bloc.dart';
// import '../blocs/user/user_bloc.dart';
// import '../blocs/user/user_event.dart';
// import '../blocs/user/user_state.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../constants/app_constants.dart';
import '../constants/app_styles.dart';
import '../repos/address_repo.dart';
import '../tweaks/app_localization.dart';
import '../tweaks/shared_pref_service.dart';
import 'my_address_screen.dart';

// class MyProfile extends StatelessWidget {
//   const MyProfile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController signInEmailController = TextEditingController();
//     TextEditingController signInPasswordController = TextEditingController();
//
//     return Scaffold(
//       body: Column(
//         children: [
//           Text("${AppData.user?.firstName} ${AppData.user?.lastName}"),
//           ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(40.0),
//                       )
//                   )
//               ),
//               onPressed: () {}, child: Text(
//               AppLocalizations.of(context)!.translate( "Logout")!
//           )),
//         ],
//       ),
//     );
//   }
// }

// class MyProfile extends StatefulWidget {
//   const MyProfile({Key? key}) : super(key: key);
//
//   @override
//   _MyProfileState createState() => _MyProfileState();
// }
//
// class _MyProfileState extends State<MyProfile> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _genderNameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   TextEditingController _mobileNumberController = TextEditingController();
//
//   bool isEnabledPassword = true;
//   bool isEnabledConfirmPassword = true;
//
//   double tabletWidth = 700;
//
//   late AddressData addressData;
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<AddressBloc>(context).add(GetAddress());
//     loadUserData();
//   }
//
//
//   void loadUserData() {
//     _firstNameController.text = AppData.user!.firstName!;
//     _lastNameController.text = AppData.user!.lastName!;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//             ? Color.fromRGBO(0, 0, 0, 1)
//             : Color.fromRGBO(255, 255, 255, 1),
//         appBar: AppBar(
//             leading: IconButton(
//               onPressed: (){
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
//                   Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ),
//             ),
//             centerTitle: true,
//             elevation: 0.0,
//             backgroundColor: Theme.of(context).brightness == Brightness.dark
//                 ? Color.fromRGBO(18, 18, 18, 1)
//                 : Color.fromRGBO(255, 255, 255, 1),
//             title: Text(
//               "Profile Edit",
//               style: GoogleFonts.gothicA1(
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? Color.fromRGBO(255, 255, 255, 1)
//                       : Color.fromRGBO(18, 18, 18, 1),
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800),
//             )),
//         body: MultiBlocListener(
//             listeners: [
//               BlocListener<UpdateProfileAddressBloc, UpdateProfileAddressState>(
//                   listener: (context, state) {
//                 if (state is UpdateProfileAddressLoaded) {
//                   _dobController.text = addressData.dob!;
//                   _genderNameController.text = addressData.gender!;
//                   _mobileNumberController.text = addressData.phone!;
//
//                   BlocProvider.of<UserBloc>(context).add(UpdateUser(
//                       _firstNameController.text, _lastNameController.text));
//
//                 } else if (state is UpdateProfileAddressError) {
//                   AppConstants.showMessage(context,state.error,Colors.red);
//
//                 }
//               }),
//               BlocListener<UserBloc, UserState>(
//                 listener: (context, state) async {
//                   if (state is UserUpdated) {
//                     setState(() {
//                       AppData.user?.firstName =
//                           state.updateUserResponse.data?.customerFirstName;
//                       AppData.user?.lastName =
//                           state.updateUserResponse.data?.customerLastName;
//                     });
//
//                     final sharedPrefService =
//                         await SharedPreferencesService.instance;
//                     await sharedPrefService.setUserFirstName(
//                         state.updateUserResponse.data!.customerFirstName!);
//                     await sharedPrefService.setUserLastName(
//                         state.updateUserResponse.data!.customerLastName!);
//                     Navigator.of(context).pop();
//
//                     AppConstants.showMessage(context,state.updateUserResponse.message!,Colors.green);
//
//
//                   } else if (state is UserError) {
//                     AppConstants.showMessage(context,state.error,Colors.red);
//                   }
//                 },
//               ),
//             ],
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: BlocBuilder<AddressBloc, AddressState>(
//                     builder: (context, state) {
//                   if (state is AddressLoaded) {
//                     if (state.addressData.isNotEmpty) {
//                       addressData = state.addressData[0];
//                       _dobController.text = addressData.dob!;
//                       _genderNameController.text = addressData.gender!;
//                       _mobileNumberController.text = addressData.phone!;
//                       return Column(
//                         children: [
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           // Stack(
//                           //   children: [
//                           //     Center(
//                           //       child: _imageFile != null
//                           //           ? Container(
//                           //               width: 120,
//                           //               height: 120,
//                           //               decoration: BoxDecoration(
//                           //                   image: DecorationImage(
//                           //                       image: FileImage(_imageFile!),
//                           //                       fit: BoxFit.cover),
//                           //                   shape: BoxShape.circle,
//                           //                   color: Colors.grey),
//                           //             )
//                           //           : Container(
//                           //               width: 120,
//                           //               height: 120,
//                           //               decoration: const BoxDecoration(
//                           //                   shape: BoxShape.circle,
//                           //                   color: Colors.grey),
//                           //             ),
//                           //     ),
//                           //     Positioned(
//                           //         top: 78,
//                           //         left: MediaQuery.of(context).size.width < 700
//                           //             ? 200
//                           //             : 400,
//                           //         child: InkWell(
//                           //           onTap: () {
//                           //             _pickImage();
//                           //           },
//                           //           child: Image.asset(
//                           //               "assets/images/Button - Profile Image Change.png"),
//                           //         ))
//                           //   ],
//                           // ),
//
//                           Container(
//                             width: double.maxFinite,
//                             height: 50,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width*0.44,
//                                   height: 50,
//                                   child: TextField(
//                                     autofocus: false,
//                                     controller: _firstNameController,
//                                     style:
//                                     GoogleFonts.gothicA1(fontWeight: FontWeight.w700),
//                                     decoration: InputDecoration(
//                                         contentPadding: const EdgeInsets.symmetric(
//                                             vertical: 0, horizontal: 0),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(10),
//                                           borderSide: const BorderSide(
//                                             width: 0,
//                                             style: BorderStyle.none,
//                                           ),
//                                         ),
//                                         fillColor: Theme.of(context).brightness ==
//                                                 Brightness.dark
//                                             ? Color.fromRGBO(29, 29, 29, 1)
//                                             : Color.fromRGBO(240, 240, 240, 1),
//                                         filled: true,
//                                         // border: InputBorder.none,
//                                         hintStyle: GoogleFonts.gothicA1(
//                                             color: Theme.of(context).brightness ==
//                                                     Brightness.dark
//                                                 ? AppStyles.COLOR_GREY_DARK
//                                                 : AppStyles.COLOR_GREY_LIGHT,
//                                             fontSize: 16),
//                                         prefixIcon: Icon(Icons.person_2_outlined,
//                                             size: 24,
//                                             color: Theme.of(context).brightness ==
//                                                     Brightness.dark
//                                                 ? Color.fromRGBO(255, 255, 255, 1)
//                                                 : Color.fromRGBO(0, 0, 0, 1))),
//                                   ),
//                                 ),
//
//                                 Container(
//                                   height: 50,
//                                   width: MediaQuery.of(context).size.width*0.44,
//                                   child: TextField(
//                                     autofocus: false,
//                                     controller: _lastNameController,
//                                     style:
//                                     GoogleFonts.gothicA1(fontWeight: FontWeight.w700),
//                                     decoration: InputDecoration(
//                                         contentPadding: const EdgeInsets.symmetric(
//                                             vertical: 0, horizontal: 40),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(10),
//                                           borderSide: const BorderSide(
//                                             width: 0,
//                                             style: BorderStyle.none,
//                                           ),
//                                         ),
//                                         fillColor: Theme.of(context).brightness ==
//                                             Brightness.dark
//                                             ? Color.fromRGBO(29, 29, 29, 1)
//                                             : Color.fromRGBO(240, 240, 240, 1),
//                                         filled: true,
//                                         // border: InputBorder.none,
//                                         hintStyle: GoogleFonts.gothicA1(
//                                             color: Theme.of(context).brightness ==
//                                                 Brightness.dark
//                                                 ? AppStyles.COLOR_GREY_DARK
//                                                 : AppStyles.COLOR_GREY_LIGHT,
//                                             fontSize: 16),
//                                         prefixIcon: Icon(Icons.person_2_outlined,
//                                             size: 24,
//                                             color: Theme.of(context).brightness ==
//                                                 Brightness.dark
//                                                 ? Color.fromRGBO(255, 255, 255, 1)
//                                                 : Color.fromRGBO(0, 0, 0, 1))
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           const SizedBox(
//                             height: 15.0,
//                           ),
//                           Container(
//                             height: 50,
//                             child: TextField(
//                               autofocus: false,
//                               controller: _dobController,
//                               style:
//                               GoogleFonts.gothicA1(fontWeight: FontWeight.w700),
//                               decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 0, horizontal: 0),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 0,
//                                       style: BorderStyle.none,
//                                     ),
//                                   ),
//                                   fillColor: Theme.of(context).brightness ==
//                                           Brightness.dark
//                                       ? Color.fromRGBO(29, 29, 29, 1)
//                                       : Color.fromRGBO(240, 240, 240, 1),
//                                   filled: true,
//                                   // border: InputBorder.none,
//                                   hintStyle: GoogleFonts.gothicA1(
//                                       color: Theme.of(context).brightness ==
//                                               Brightness.dark
//                                           ? AppStyles.COLOR_GREY_DARK
//                                           : AppStyles.COLOR_GREY_LIGHT,
//                                       fontSize: 16),
//                                   prefixIcon: Icon(Icons.calendar_today,
//                                       size: 24,
//                                       color: Theme.of(context).brightness ==
//                                               Brightness.dark
//                                           ? Color.fromRGBO(255, 255, 255, 1)
//                                           : Color.fromRGBO(0, 0, 0, 1))),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15.0,
//                           ),
//                           Container(
//                             height: 50,
//                             child: TextField(
//                               autofocus: false,
//                               controller: _genderNameController,
//                               style:
//                               GoogleFonts.gothicA1(fontWeight: FontWeight.w700),
//                               decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 0, horizontal: 0),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 0,
//                                       style: BorderStyle.none,
//                                     ),
//                                   ),
//                                   fillColor: Theme.of(context).brightness ==
//                                           Brightness.dark
//                                       ? Color.fromRGBO(29, 29, 29, 1)
//                                       : Color.fromRGBO(240, 240, 240, 1),
//                                   filled: true,
//                                   // border: InputBorder.none,
//                                   hintStyle: GoogleFonts.gothicA1(
//                                       color: Theme.of(context).brightness ==
//                                               Brightness.dark
//                                           ? AppStyles.COLOR_GREY_DARK
//                                           : AppStyles.COLOR_GREY_LIGHT,
//                                       fontSize: 16),
//                                   prefixIcon: Icon(Icons.group_outlined,
//                                       size: 24,
//                                       color: Theme.of(context).brightness ==
//                                               Brightness.dark
//                                           ? Color.fromRGBO(255, 255, 255, 1)
//                                           : Color.fromRGBO(0, 0, 0, 1))),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15.0,
//                           ),
//                           Container(
//                             height: 50,
//                             child: TextField(
//                               autofocus: false,
//                               controller: _mobileNumberController,
//                               style:
//                               GoogleFonts.gothicA1(fontWeight: FontWeight.w700),
//                               decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 0, horizontal: 0),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 0,
//                                       style: BorderStyle.none,
//                                     ),
//                                   ),
//                                   fillColor: Theme.of(context).brightness ==
//                                           Brightness.dark
//                                       ? Color.fromRGBO(29, 29, 29, 1)
//                                       : Color.fromRGBO(240, 240, 240, 1),
//                                   filled: true,
//                                   // border: InputBorder.none,
//                                   hintStyle: GoogleFonts.gothicA1(
//                                       color: Theme.of(context).brightness ==
//                                               Brightness.dark
//                                           ? AppStyles.COLOR_GREY_DARK
//                                           : AppStyles.COLOR_GREY_LIGHT,
//                                       fontSize: 16),
//                                   prefixIcon: Icon(Icons.phone,
//                                       size: 24,
//                                       color: Theme.of(context).brightness ==
//                                               Brightness.dark
//                                           ? Color.fromRGBO(255, 255, 255, 1)
//                                           : Color.fromRGBO(0, 0, 0, 1))),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15.0,
//                           ),
//                           SizedBox(
//                             height: 50,
//                             width: double.maxFinite,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         Color.fromRGBO(255, 76, 59, 1),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10))),
//                                 onPressed: () {
//                                   BlocProvider.of<UpdateProfileAddressBloc>(
//                                           context)
//                                       .add(UpdateProfileAddress(
//                                           addressData.id!,
//                                           _firstNameController.text,
//                                           _lastNameController.text,
//                                           _genderNameController.text,
//                                           _dobController.text,
//                                           addressData.lattitude ?? "123",
//                                           addressData.longitude ?? "123",
//                                           _mobileNumberController.text));
//                                 },
//                                 child: Text(
//                                   "Update Changes",
//                                   style: GoogleFonts.gothicA1(
//                                       color: Color.fromRGBO(255, 255, 255, 1),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w700),
//                                 )),
//                           ),
//                         ],
//                       );
//                     } else
//                       return Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             "Profile info is not added,go to address screen to add personal info.",
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.gothicA1(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Theme.of(context).brightness ==
//                                         Brightness.dark
//                                     ? Color.fromRGBO(160, 160, 160, 1)
//                                     : Color.fromRGBO(112, 112, 112, 1)),
//                           ),
//                           SizedBox(
//                             height: 40,
//                           ),
//                           SizedBox(
//                             width: double.maxFinite,
//                             height: 45,
//                             child: ElevatedButton(
//                               style: ButtonStyle(
//                                   backgroundColor: MaterialStatePropertyAll(
//                                       Color.fromRGBO(255, 76, 59, 1)),
//                                   shape: MaterialStateProperty.all<
//                                           RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ))),
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (c) => BlocProvider(
//                                         create: (BuildContext context) {
//                                           return AddressBloc(RealAddressRepo())
//                                             ..add(GetAddress());
//                                         },
//                                         child: MyAddressScreen())));
//                               },
//                               child: Text("Go to Address Screen",
//                                   style: GoogleFonts.gothicA1(
//                                       color: Color.fromRGBO(
//                                         255,
//                                         255,
//                                         255,
//                                         1,
//                                       ),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w700)),
//                             ),
//                           )
//                         ],
//                       );
//                   } else if (state is AddressLoading) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: Color.fromRGBO(255, 76, 59, 1),
//                       ),
//                     );
//                   }
//                   return Center(
//                     child: const CircularProgressIndicator(
//                       color: Color.fromRGBO(255, 76, 59, 1),
//                     ),
//                   );
//                 }),
//               ),
//             )));
//   }
// }



import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  String? _selectedGender;
  List<String> _genders = ['Male', 'Female', 'Other'];

  bool isEnabledPassword = true;
  bool isEnabledConfirmPassword = true;

  double tabletWidth = 700;

  late AddressData addressData;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressBloc>(context).add(GetAddress());
    loadUserData();
  }

  void loadUserData() {
    _firstNameController.text = AppData.user!.firstName!;
    _lastNameController.text = AppData.user!.lastName!;
  }

  @override
  Widget build(BuildContext context) {
    String apiInput;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(18, 18, 18, 1)),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(18, 18, 18, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          "Profile Edit",
          style: GoogleFonts.gothicA1(
            color: Theme.of(context).brightness == Brightness.dark
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromRGBO(18, 18, 18, 1),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateProfileAddressBloc, UpdateProfileAddressState>(
            listener: (context, state) {
              if (state is UpdateProfileAddressLoaded) {
                _dobController.text = addressData.dob!;
                _mobileNumberController.text = addressData.phone!;

                BlocProvider.of<UserBloc>(context).add(UpdateUser(
                  _firstNameController.text,
                  _lastNameController.text,
                ));
              } else if (state is UpdateProfileAddressError) {
                AppConstants.showMessage(context, state.error, Colors.red);
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) async {
              if (state is UserUpdated) {
                setState(() {
                  AppData.user?.firstName =
                      state.updateUserResponse.data?.customerFirstName;
                  AppData.user?.lastName =
                      state.updateUserResponse.data?.customerLastName;
                });

                final sharedPrefService =
                await SharedPreferencesService.instance;
                await sharedPrefService.setUserFirstName(
                  state.updateUserResponse.data!.customerFirstName!,
                );
                await sharedPrefService.setUserLastName(
                  state.updateUserResponse.data!.customerLastName!,
                );
                Navigator.of(context).pop();

                AppConstants.showMessage(
                  context,
                  state.updateUserResponse.message!,
                  Colors.green,
                );
              } else if (state is UserError) {
                AppConstants.showMessage(context, state.error, Colors.red);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoaded) {
                  if (state.addressData.isNotEmpty) {
                    addressData = state.addressData[0];
                    String intialGenderValue=addressData.gender!;
                    String initialdob=addressData.dob!;
                    DateTime parsedDate = DateTime.parse(initialdob);
                    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
                    print(formattedDate);
                    // _dobController.text = addressData.dob!;
                    _mobileNumberController.text = addressData.phone!;
                    return Column(
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: double.maxFinite,
                          height: 50,
                          child: TextField(
                            autofocus: false,
                            controller: _firstNameController,
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              hintStyle: GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                size: 24,
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          child: TextField(
                            autofocus: false,
                            controller: _lastNameController,
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 40,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              hintStyle: GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                size: 24,
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          child: TextField(
                            autofocus: false,
                            controller: _dobController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Transform.scale(

                                    scaleX: 0.8,
                                    scaleY: 0.7,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        datePickerTheme: DatePickerThemeData(
                                          backgroundColor: Colors.white,
                                          headerBackgroundColor: Color.fromRGBO(255, 76, 59, 1),
                                          headerHeadlineStyle: GoogleFonts.gothicA1(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14
                                          ),
                                          dayStyle: GoogleFonts.gothicA1(),
                                          yearStyle: GoogleFonts.gothicA1(),
                                          weekdayStyle: GoogleFonts.gothicA1(),
                                          headerHelpStyle: GoogleFonts.gothicA1(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16
                                          ),
                                          rangePickerHeaderHeadlineStyle: GoogleFonts.gothicA1(),
                                          rangePickerHeaderHelpStyle: GoogleFonts.gothicA1(),
                                          todayBackgroundColor:  MaterialStatePropertyAll(
                                            Color.fromRGBO(255, 76, 59, 1),
                                          ),

                                        ),
                                        // dialogBackgroundColor: Color.fromRGBO(255, 76, 59, 1), // days/years gridview
                                        // textTheme: TextTheme(
                                        //   headline5:GoogleFonts.gothicA1(), // Selected Date landscape
                                        //   titleLarge: GoogleFonts.gothicA1(), // Selected Date portrait
                                        //   overline: GoogleFonts.gothicA1(), // Title - SELECT DATE
                                        //    bodyLarge: GoogleFonts.gothicA1(), // year gridbview picker
                                        //   titleMedium: GoogleFonts.gothicA1(color: Colors.black), // input
                                        //   titleMedium2: GoogleFonts.gothicA1(), // month/year picker
                                        //   bodySmall: GoogleFonts.gothicA1(), // days
                                        // ),
                                        // colorScheme: Theme.of(context).colorScheme.copyWith(
                                        //   // Title, selected date and day selection background (dark and light mode)
                                        //   surface: Color.fromRGBO(255, 76, 59, 0.5),
                                        //   primary: Color.fromRGBO(255, 76, 59, 0.5),
                                        //   // Title, selected date and month/year picker color (dark and light mode)
                                        //   onSurface: Colors.white,
                                        //   onPrimary: Colors.white,
                                        // ),
                                        // Buttons
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Color.fromRGBO(255, 76, 59, 1),
                                            textStyle: GoogleFonts.gothicA1(
                                            ),
                                          ),
                                        ),
                                        // Input
                                        inputDecorationTheme: InputDecorationTheme(
                                          labelStyle: GoogleFonts.gothicA1(), // Input label
                                        ),
                                      ),
                                      child: child!,
                                    )
                                  );

                                },
                              );
                              if (selectedDate != null) {
                                DateFormat outputFormat = DateFormat('dd-MM-yyyy');
                                String outputDate = outputFormat.format(selectedDate);
                                print(outputDate);
                                setState(() {
                                  _dobController.text = outputDate;
                                });
                              }
                            },
                            style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              hintText: formattedDate,
                              hintStyle: GoogleFonts.gothicA1(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,

                              ),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                size: 24,
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          child: DropdownButtonFormField<String>(
                            value: intialGenderValue,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                            items: _genders.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: GoogleFonts.gothicA1(
                                  color:Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              hintStyle: GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.group_outlined,
                                size: 24,
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          child: TextField(
                            autofocus: false,
                            keyboardType: TextInputType.phone,
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            controller: _mobileNumberController,
                            style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              hintStyle: GoogleFonts.gothicA1(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
                                size: 24,
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        SizedBox(
                          height: 50,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(255, 76, 59, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              DateTime apiFormat = DateFormat('dd-MM-yyyy').parse(_dobController.text);
                              String apiInput = DateFormat('yyyy-MM-dd').format(apiFormat);
                              String dob = _dobController.text.isEmpty ? initialdob :apiInput;
                              print(dob);
                              BlocProvider.of<UpdateProfileAddressBloc>(context)
                                  .add(
                                UpdateProfileAddress(
                                  addressData.id!,
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _selectedGender ?? intialGenderValue,
                                  dob,
                                  addressData.lattitude ?? "123",
                                  addressData.longitude ?? "123",
                                  _mobileNumberController.text,
                                ),
                              );
                            },
                            child: Text(
                              "Update Changes",
                              style: GoogleFonts.gothicA1(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Profile info is not added, go to the address screen to add personal info.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.gothicA1(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? Color.fromRGBO(160, 160, 160, 1)
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: double.maxFinite,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(255, 76, 59, 1),
                              ),
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
                                  builder: (c) => BlocProvider(
                                    create: (BuildContext context) {
                                      return AddressBloc(RealAddressRepo())
                                        ..add(GetAddress());
                                    },
                                    child: MyAddressScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Go to Address Screen",
                              style: GoogleFonts.gothicA1(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else if (state is AddressLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(255, 76, 59, 1),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(255, 76, 59, 1),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

