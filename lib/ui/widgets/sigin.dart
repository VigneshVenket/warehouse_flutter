import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/ui/account_created_screen.dart';
import 'package:flutter_kundol/ui/forgot_screen.dart';
import 'package:flutter_kundol/ui/main_screen.dart';
import 'package:flutter_kundol/ui/widgets/signup.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/app_data.dart';
import '../../constants/app_styles.dart';
import '../../tweaks/app_localization.dart';
import '../../tweaks/shared_pref_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  bool isEnabled = true;
  double tabletWidth = 700.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) =>
          //   NestedScrollView(
          // headerSliverBuilder:
          //     (BuildContext context, bool innerBoxIsScrolled) => [
          //   SliverAppBar(
          //     // leading: IconButton(
          //     //   icon: Icon(Icons.arrow_back_ios),
          //     //   onPressed: (){
          //     //     Navigator.pop(context);},
          //     // ),
          //     automaticallyImplyLeading: false,
          //     expandedHeight: 180,
          //     backgroundColor: Color.fromRGBO(128, 122, 122, 1.0),
          //     flexibleSpace: FlexibleSpaceBar(
          //       title: Text(
          //         "Sign In",
          //         style: GoogleFonts.gothicA1(
          //             color: Colors.white,
          //             fontWeight: FontWeight.w700,
          //             fontSize: 24),
          //       ),
          //       titlePadding: EdgeInsets.fromLTRB(20, 0, 50, 45),
          //       // background: Image(
          //       //   image: AssetImage("assets/images/auth_bg_image-removebg-preview.png")
          //       // ),
          //     ),
          //   )
          // ],
          // body:
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(child: Stack(
                    children:[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.3,
                        child: Image.asset("assets/images/livecart_sigin_bg.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height*0.22,
                        left: MediaQuery.of(context).size.width*0.05,
                        child: Text("Sign In",style: GoogleFonts.gothicA1(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white
                        ),),
                      )
                    ]

                )),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        child: TextField(
                          autofocus: false,
                          style: GoogleFonts.gothicA1(),
                          cursorColor: Color.fromRGBO(255, 76, 59, 1),
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
                              fillColor:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Color.fromRGBO(29, 29, 29, 1)
                                      : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              // border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: GoogleFonts.gothicA1(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppStyles.COLOR_GREY_DARK
                                      : AppStyles.COLOR_GREY_LIGHT,
                                  fontSize: 16),
                              prefixIcon: Icon(Icons.email_outlined,
                                  size: 24,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1))),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          obscureText: isEnabled,
                          style: GoogleFonts.gothicA1(),
                          cursorColor: Color.fromRGBO(255, 76, 59, 1),
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
                              fillColor:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? AppStyles.COLOR_LITE_GREY_DARK
                                      : AppStyles.COLOR_LITE_GREY_LIGHT,
                              filled: true,
                              // border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: GoogleFonts.gothicA1(
                                  color:
                                      Theme.of(context).brightness == Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT,
                                  fontSize: 16),
                              prefixIcon: Icon(Icons.lock_outline,
                                  size: 24,
                                  color:
                                      Theme.of(context).brightness == Brightness.dark
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1)),
                              suffixIcon: isEnabled
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEnabled = !isEnabled;
                                        });
                                      },
                                      icon: Icon(Icons.visibility_off,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEnabled = !isEnabled;
                                        });
                                      },
                                      icon: Icon(Icons.visibility,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)))),
                        ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Row(
                          //   children: [
                          //   Checkbox(value: false, onChanged: (value){})  ,
                          //     Text("Remember Me",style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight:FontWeight.w500,
                          //       color: Theme.of(context).brightness ==
                          //           Brightness.dark
                          //           ? AppStyles.COLOR_GREY_DARK
                          //           : AppStyles.COLOR_GREY_LIGHT,
                          //     ),)
                          //   ],
                          // ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (c) => ForgotScreen()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.gothicA1(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1)),
                              )),
                          // TextButton(
                          //     onPressed: () {
                          //
                          //     },
                          //     child: Text(
                          //       "Welcome Guest!",
                          //       style: GoogleFonts.gothicA1(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w600,
                          //           color: Theme.of(context).brightness ==
                          //                   Brightness.dark
                          //               ? Color.fromRGBO(255, 255, 255, 1)
                          //               : Color.fromRGBO(0, 0, 0, 1)),
                          //     )),
                        ],
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      SizedBox(
                        height: 40,
                        width: double.maxFinite,
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
                          child:Text(
                            "Sign In",
                            style: GoogleFonts.gothicA1(
                                color: Color.fromRGBO(255, 76, 59, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(PerformLogin(
                                signInEmailController.text,
                                signInPasswordController.text));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          "___ or___",
                          style: GoogleFonts.gothicA1(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(160, 160, 160, 1)
                                  : Color.fromRGBO(112, 112, 112, 1)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      // // Theme.of(context).brightness == Brightness.dark
                      // //     ? Row(
                      // //         mainAxisAlignment: MainAxisAlignment.center,
                      // //         children: [
                      // //           // GestureDetector(
                      // //           //     onTap: (){signInFB(context);},
                      // //           //     child: Image.asset("assets/icons/Button - Facebook dark.png")),
                      // //           SizedBox(
                      // //             width: 20,
                      // //           ),
                      // //           GestureDetector(
                      // //               onTap: () async {
                      // //                 doGoogleLogin(context);
                      // //               },
                      // //               child: Image.asset(
                      // //                   "assets/icons/Button - Google dark.png")),
                      // //           SizedBox(
                      // //             width: 20,
                      // //           ),
                      // //           // Image.asset("assets/icons/Button - Apple dark.png"),
                      // //         ],
                      // //       )
                      // //     : Row(
                      // //         mainAxisAlignment: MainAxisAlignment.center,
                      // //         children: [
                      // //           // GestureDetector(
                      // //           //     onTap: (){signInFB(context);},
                      // //           //     child: Image.asset("assets/icons/Button - Facebook.png")),
                      // //           SizedBox(
                      // //             width: 20,
                      // //           ),
                      // //           GestureDetector(
                      // //               onTap: () {
                      // //                 doGoogleLogin(context);
                      // //               },
                      // //               child: Image.asset(
                      // //                   "assets/icons/Button - Google.png")),
                      // //           SizedBox(
                      // //             width: 20,
                      // //           ),
                      // //           // Image.asset("assets/icons/Button - Apple.png"),
                      // //         ],
                      // //       ),
                      // // const SizedBox(
                      // //   height: 10,
                      // // ),
                      SizedBox(
                        height: 40,
                        width: double.maxFinite,
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
                          child:Text(
                            "Sign in with Google",
                            style: GoogleFonts.gothicA1(
                                color: Color.fromRGBO(255, 76, 59, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                             doGoogleLogin(context);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (c) => MainScreen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Theme.of(context).brightness == Brightness.dark
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width <
                                          tabletWidth
                                      ? MediaQuery.of(context).size.width * 0.15
                                      : 250),
                              child: Row(
                                children: [
                                  Text(
                                    "Don’t have an account?",
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(160, 160, 160, 1)),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) => SignUpScreen()));
                                      },
                                      child: Text(
                                        "Sign up",
                                        style: GoogleFonts.gothicA1(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromRGBO(255, 255, 255, 1)),
                                      ))
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width <
                                          tabletWidth
                                      ? MediaQuery.of(context).size.width * 0.15
                                      : 250),
                              child: Row(children: [
                                 Text(
                                  "Don’t have an account?",
                                  style: GoogleFonts.gothicA1(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(112, 112, 112, 1)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (c) => SignUpScreen()));
                                    },
                                    child: Text(
                                      "Sign up",
                                      style:GoogleFonts.gothicA1(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 1)),
                                    ))
                              ]),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
          listener: (context, state) async {

          // if (state is AuthenticatedRegisterManual) {
          //   Navigator.of(context).push(MaterialPageRoute(builder: (c) => AccountCreatedScreen()));
          // }

          if (state is AuthenticatedLoginManual) {
            AppData.user = state.user;
            AppData.accessToken = state.user?.token;

            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserID(state.user!.id!);
            await sharedPrefService.setUserFirstName(state.user!.firstName!);
            await sharedPrefService.setUserLastName(state.user!.lastName!);
            await sharedPrefService.setUserEmail(state.user!.email!);
            await sharedPrefService.setUserToken(state.user!.token!);

            // AppConstants.showMessage(context, state.message!,Colors.green);

            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(
            //     state.message!,
            //     style: GoogleFonts.gothicA1(
            //         color: Color.fromRGBO(
            //           255,
            //           255,
            //           255,
            //           1,
            //         ),
            //         fontSize: 14,
            //         fontWeight: FontWeight.w600),
            //   ),
            //   backgroundColor: Colors.green,
            // ));

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
          }

            else if (state is Authenticated) {

            AppData.user = state.user;
            AppData.accessToken = state.user?.token;

            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserID(state.user!.id!);
            await sharedPrefService.setUserFirstName(state.user!.firstName!);
            await sharedPrefService.setUserLastName(state.user!.lastName!);
            await sharedPrefService.setUserEmail(state.user!.email!);
            await sharedPrefService.setUserToken(state.user!.token!);

            Navigator.of(context).push(MaterialPageRoute(builder: (c) => MainScreen()));
          }
          // else if (state is UnAuthenticated) {
          //   AppData.user = null;
          //   AppData.accessToken = null;
          //
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not Authenticated")));
          // }
          else if (state is AuthLoginFailed) {
            AppConstants.showMessage(context, state.message!,Colors.red);

            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text(
            //       state.message!,
            //       style: GoogleFonts.gothicA1(
            //           color: Color.fromRGBO(
            //             255,
            //             255,
            //             255,
            //             1,
            //           ),
            //           fontSize: 14,
            //           fontWeight: FontWeight.w600),
            //     ),
            //     backgroundColor: Colors.red));
          }
        },
      ),
    );
  }

  void doGoogleLogin(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      signInWithGoogle(context, googleSignIn, auth);
    } on Exception catch (error) {
      print(error);
    }
  }

  Future signInWithGoogle(BuildContext context, GoogleSignIn googleSignIn,
      FirebaseAuth auth) async {
    print("####################");
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    String? accessToken = googleSignInAuthentication.accessToken;
    print("Google AccessToken :  $accessToken");
    BlocProvider.of<AuthBloc>(context).add(PerformGoogleLogin(accessToken!));
  }

  // void signInFB(BuildContext context) async {
  //   final fb = FacebookLogin();
  //   final res = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]
  //   );
  //   switch (res.status) {
  //     case FacebookLoginStatus.success:
  //       final FacebookAccessToken? accessToken = res.accessToken;
  //       print('Access token: ${accessToken?.token}');
  //       final profile = await fb.getUserProfile();
  //       print('Hello, ${profile?.name}! You ID: ${profile?.userId}');
  //       final imageUrl = await fb.getProfileImageUrl(width: 100);
  //       print('Your profile image: $imageUrl');
  //       final email = await fb.getUserEmail();
  //       if (email != null) print('And your email is $email');
  //
  //       BlocProvider.of<AuthBloc>(context)
  //           .add(PerformFacebookLogin(accessToken!.token));
  //
  //       print("ACCESS TOKEN = ${accessToken.token}");
  //
  //       break;
  //     case FacebookLoginStatus.cancel:
  //       break;
  //     case FacebookLoginStatus.error:
  //       print('Error while log in: ${res.error}');
  //       break;
  //   }
  // }


  // Future<User?> doGoogleLogin(BuildContext context) async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   try {
  //     var resp = signInWithGoogle(context, googleSignIn, auth);
  //     return resp;
  //   } on Exception catch (error) {
  //     print(error);
  //   }
  // }
  //
  // Future<User?> signInWithGoogle(BuildContext context, GoogleSignIn googleSignIn, FirebaseAuth auth) async {
  //   final GoogleSignInAccount? googleSignInAccount =
  //   await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount!.authentication;
  //   String? accessToken = googleSignInAuthentication.accessToken;
  //
  //   print("Google AccessToken :  $accessToken");
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   UserCredential authResult = await auth.signInWithCredential(credential);
  //   if (authResult.user!.uid.isNotEmpty) {
  //     var _user = authResult.user;
  //     assert(!_user!.isAnonymous);
  //     assert(await _user!.getIdToken() != null);
  //     User currentUser = auth.currentUser!;
  //     await googleSignIn.signOut();
  //     return currentUser;
  //   }
  // }

  // Future<User?> signInWithGoogle(BuildContext context, GoogleSignIn googleSignIn, FirebaseAuth auth) async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     if (googleSignInAccount == null) {
  //       // User canceled sign-in process
  //       return null;
  //     }
  //
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //     String? accessToken = googleSignInAuthentication.accessToken;
  //
  //     print("Google AccessToken :  $accessToken");
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     UserCredential authResult = await auth.signInWithCredential(credential);
  //     if (authResult.user!.uid.isNotEmpty) {
  //       var _user = authResult.user;
  //       assert(!_user!.isAnonymous);
  //       assert(await _user!.getIdToken() != null);
  //       User currentUser = auth.currentUser!;
  //       await googleSignIn.signOut();
  //       return currentUser;
  //     }
  //   } catch (error) {
  //     print("Error signing in with Google: $error");
  //     // Handle the error appropriately, e.g., show a snackbar with an error message
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Error signing in with Google"),
  //     ));
  //   }
  //   return null;
  // }

}
