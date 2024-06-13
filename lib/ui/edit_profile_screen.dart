import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/profile/update_profile_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';

import '../constants/app_config.dart';
import '../tweaks/app_localization.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _firstNameController =
  TextEditingController();
  final TextEditingController _lastNameController =
  TextEditingController();
  final TextEditingController _passwordController =
  TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameController.text = AppData.user!.firstName!;
    _lastNameController.text = AppData.user!.lastName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
      appBar: AppConfig.APP_BAR_COLOR == 2 ?
      AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color:AppConfig.APP_BAR_COLOR == 2 ?
          Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
          Colors.white,
        ),
        backgroundColor:Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
        title: Text(
          AppLocalizations.of(context)!.translate("Edit Profile")!,
          style: TextStyle(
            color:AppConfig.APP_BAR_COLOR == 2 ?
            Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
            Colors.white,
          ),),
        //style: Theme.of(context).textTheme.titleLarge),

        elevation: 0.0,
      ):
      AppConfig.APP_BAR_COLOR == 1 ?
      AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color:AppConfig.APP_BAR_COLOR == 1 ?
          Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
          Colors.white,
        ),
        backgroundColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of(context)!.translate("Edit Profile")!,
          style: TextStyle(
            color:AppConfig.APP_BAR_COLOR == 1 ?
            Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
            Colors.white,
          ),),
        //style: Theme.of(context).textTheme.titleLarge),

        elevation: 0.0,
      ):AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).brightness ==
              Brightness.dark
              ? Colors.white
              : Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text("Edit Profile", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: TextField(
                autofocus: false,
                controller: _firstNameController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness ==
                        Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.translate("First Name"),
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness ==
                            Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                    )),
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                autofocus: false,
                controller: _lastNameController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness ==
                        Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.translate("Last Name"),
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness ==
                            Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                    )),
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                autofocus: false,
                controller: _passwordController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness ==
                        Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.translate("Password"),
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness ==
                            Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    )),
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                autofocus: false,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness ==
                        Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText:
                    AppLocalizations.of(context)!.translate("Confirm Password"),
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness ==
                            Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    )),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            BlocConsumer<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if(state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                  ),);
                } else {
                  return SizedBox(
                    height: 40.0,
                    width: double.maxFinite,
                    child: AppConfig.APP_BAR_COLOR == 2 ?
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all( Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColor : Theme.of(context).primaryColor,),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              )
                          )
                      ),
                      onPressed: () {
                        if(
                        _firstNameController.text.isNotEmpty &&
                            _lastNameController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty
                        ) {
                          BlocProvider.of<ProfileBloc>(context).add(UpdateProfile(
                              _firstNameController.text,
                              _lastNameController.text,
                              _passwordController.text,
                              _confirmPasswordController.text
                          ));
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate("Update",)!
                        ,style: TextStyle(
                        color:AppConfig.APP_BAR_COLOR == 1 ?
                        Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
                        Colors.white,
                      ),
                      ),
                    ):
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColor : Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              )
                          )
                      ),
                      onPressed: () {
                        if(
                        _firstNameController.text.isNotEmpty &&
                            _lastNameController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty
                        ) {
                          BlocProvider.of<ProfileBloc>(context).add(UpdateProfile(
                              _firstNameController.text,
                              _lastNameController.text,
                              _passwordController.text,
                              _confirmPasswordController.text
                          ));
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate("Update",)!
                        ,style: TextStyle(
                        color:AppConfig.APP_BAR_COLOR == 1 ?
                        Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
                        Colors.white,
                      ),
                      ),
                    ),
                  );
                }
              },
              listener: (context, state) async {
                if(state is ProfileUpdated) {

                  setState(() {
                    AppData.user?.firstName = state.updateProfileResponse.data?.customerFirstName;
                    AppData.user?.lastName = state.updateProfileResponse.data?.customerLastName;
                  });

                  final sharedPrefService = await SharedPreferencesService.instance;
                  await sharedPrefService.setUserFirstName(state.updateProfileResponse.data!.customerFirstName!);
                  await sharedPrefService.setUserLastName(state.updateProfileResponse.data!.customerLastName!);
                  AppConstants.showMessage(context, state.updateProfileResponse.message!, Colors.green);

                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.updateProfileResponse.message!)));
                } else if (state is ProfileError) {

                  AppConstants.showMessage(context, state.error,Colors.red);

                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
