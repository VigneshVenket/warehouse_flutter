
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:flutter_kundol/ui/forgot_screen.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/app_config.dart';
import '../tweaks/app_localization.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController signInEmailController = TextEditingController();
    TextEditingController signInPasswordController =
        TextEditingController();
    TextEditingController signUpFirstNameController =
        TextEditingController();
    TextEditingController signUpLastNameController =
        TextEditingController();
    TextEditingController signUpEmailController = TextEditingController();
    TextEditingController signUpPasswordController =
        TextEditingController();
    TextEditingController signUpConfirmPasswordController =
        TextEditingController();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) => DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
              AppConfig.APP_BAR_COLOR == 2 ?
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 160.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                iconTheme: Theme.of(context).iconTheme,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                        AppLocalizations.of(context)!.translate( "Welcome Back!")!,
                        style: Theme.of(context).textTheme. bodyLarge)),
              ):
              SliverAppBar(
                // leading: IconButton(
                //   onPressed: (){
                //
                //   },
                //   icon: Icon(Icons.arrow_back_ios),
                // ),
                backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                expandedHeight: 160.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
                // flexibleSpace: FlexibleSpaceBar(
                //     centerTitle: true,
                //     title: Text(
                //         AppLocalizations.of(context)!.translate( "Welcome Back!")!,
                //         style: TextStyle(
                //           color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white
                //         ))),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                    TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: 1.0, color: Theme.of(context).primaryColor),
                    insets: const EdgeInsets.symmetric(horizontal: 65.0),
                  ),
                  labelStyle: const TextStyle(),
                  unselectedLabelColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                  labelColor: Theme.of(context).primaryColor,
                  tabs: [
                    Tab(
                      text:
                      AppLocalizations.of(context)!.translate("Sign In"),
                    ),
                    Tab(
                      text:AppLocalizations.of(context)!.translate("Sign Up"),
                    ),
                  ],
                )),
                pinned: true,
              ),
            ],
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            controller: signInEmailController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                AppLocalizations.of(context)!.translate("Email"),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark?Color.fromRGBO(255,255,255,1):
                                      Color.fromRGBO(0, 0, 0, 1)
                                  
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            obscureText: true,
                            autofocus: false,
                            controller: signInPasswordController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                AppLocalizations.of(context)!.translate("Password"),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark?Color.fromRGBO(255,255,255,1):
                                    Color.fromRGBO(0, 0, 0, 1)

                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotScreen(),
                                      ));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.translate("Forgot your password")!,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        SizedBox(
                          height: 40.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: AppConfig.APP_BAR_COLOR == 2 ?
                              ButtonStyle(
                                 backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor,),
                                //color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                                //  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        18.0),
                                  ),
                                ),
                              ):
                              ButtonStyle(
                                //  backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),
                                //color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        18.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  
                                    PerformLogin(signInEmailController.text,
                                        signInPasswordController.text));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.translate("Sign In")!,
                              )),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                width: 50.0,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                AppLocalizations.of(context)!.translate("Or sign in with")!,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppStyles.COLOR_GREY_DARK
                                      : AppStyles.COLOR_GREY_LIGHT,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                width: 50.0,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInFB(context);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_facebook.svg"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Facebook")!,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                doGoogleLogin(context);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_google.svg"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate("Google")!,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          AppLocalizations.of(context)!.translate("We keep your data safe. for further assistance\nplease refer to our privacy policy")!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            controller: signUpFirstNameController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
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
                            controller: signUpLastNameController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
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
                                hintText:AppLocalizations.of(context)!.translate("Last Name"),
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
                            controller: signUpEmailController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
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
                                hintText:AppLocalizations.of(context)!.translate("Email"),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            obscureText: true,
                            autofocus: false,
                            controller: signUpPasswordController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
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
                                hintText:AppLocalizations.of(context)!.translate("Password"),
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
                            obscureText: true,
                            autofocus: false,
                            controller: signUpConfirmPasswordController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
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
                                hintText:AppLocalizations.of(context)!.translate("Confirm Password"),
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
                        SizedBox(
                          height: 40.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: AppConfig.APP_BAR_COLOR == 2 ?
                              ButtonStyle(
                              //  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                //color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Colors.black : Theme.of(context).primaryColor,),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        18.0),
                                  ),
                                ),
                              ):
                               AppConfig.APP_BAR_COLOR == 1 ?
                              ButtonStyle(
                                //  backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),
                                //color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                              //  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                               backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor,),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        18.0),
                                  ),
                                ),
                              ):null,
                              onPressed: () {
                              
                                BlocProvider.of<AuthBloc>(context).add(
                                    PerformRegister(
                                        signUpFirstNameController.text,
                                        signUpLastNameController.text,
                                        signUpEmailController.text,
                                        signUpPasswordController.text,
                                        signUpConfirmPasswordController.text,
                                        " "
                                    ));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.translate("Sign Up")!,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context, state) async {
          if (state is Authenticated) {
            AppData.user = state.user;
            AppData.accessToken = state.user?.token;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome ${state.user!.firstName!}")));

            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserID(state.user!.id!);
            await sharedPrefService.setUserFirstName(state.user!.firstName!);
            await sharedPrefService.setUserLastName(state.user!.lastName!);
            await sharedPrefService.setUserEmail(state.user!.email!);
            await sharedPrefService.setUserToken(state.user!.token!);

            Navigator.pop(context);
          } else if (state is UnAuthenticated) {
            AppData.user = null;
            AppData.accessToken = null;
            Navigator.pop(context);
          }
          else if (state is EmailSent) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
          else if (state is AuthFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
      ),
    );
  }

  void doGoogleLogin(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      signInWithGoogle(context, googleSignIn, auth);
    } on Exception catch (error) {
      print(error);
    }
  }

  void signInWithGoogle(BuildContext context, GoogleSignIn googleSignIn,
      FirebaseAuth auth) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    String? accessToken = googleSignInAuthentication.accessToken;

    print("Google AccessToken :  $accessToken");

    BlocProvider.of<AuthBloc>(context).add(PerformGoogleLogin(accessToken!));

    /*final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult = await _auth.signInWithCredential(credential);

    var _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = _auth.currentUser;
    assert(_user.uid == currentUser.uid);
    //model.state =ViewState.Idle;
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");

    return await FirebaseAuth.instance.signInWithCredential(credential);*/
  }

  void signInFB(BuildContext context) async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]
    );
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');
        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        final email = await fb.getUserEmail();
        if (email != null) print('And your email is $email');

        BlocProvider.of<AuthBloc>(context)
            .add(PerformFacebookLogin(accessToken!.token));

        print("ACCESS TOKEN = ${accessToken.token}");

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 35.0;

  @override
  double get maxExtent => 35.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
