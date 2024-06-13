import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/featured_products/featured_products_bloc.dart';
import 'package:flutter_kundol/blocs/filters/filters_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/models/filters_data.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/ui/screens/new_featured_products_all_view.dart';
import 'package:flutter_kundol/ui/search_screen.dart';
import 'package:flutter_kundol/ui/widgets/card_style_10.dart';
import 'package:flutter_kundol/ui/widgets/card_style_11.dart';
import 'package:flutter_kundol/ui/widgets/card_style_12.dart';
import 'package:flutter_kundol/ui/widgets/card_style_13.dart';
import 'package:flutter_kundol/ui/widgets/card_style_14.dart';
import 'package:flutter_kundol/ui/widgets/card_style_15.dart';
import 'package:flutter_kundol/ui/widgets/card_style_16.dart';
import 'package:flutter_kundol/ui/widgets/card_style_17.dart';
import 'package:flutter_kundol/ui/widgets/card_style_18.dart';
import 'package:flutter_kundol/ui/widgets/card_style_19.dart';
import 'package:flutter_kundol/ui/widgets/card_style_2.dart';
import 'package:flutter_kundol/ui/widgets/card_style_20.dart';
import 'package:flutter_kundol/ui/widgets/card_style_21.dart';
import 'package:flutter_kundol/ui/widgets/card_style_22.dart';
import 'package:flutter_kundol/ui/widgets/card_style_23.dart';
import 'package:flutter_kundol/ui/widgets/card_style_24.dart';
import 'package:flutter_kundol/ui/widgets/card_style_25.dart';
import 'package:flutter_kundol/ui/widgets/card_style_26.dart';
import 'package:flutter_kundol/ui/widgets/card_style_27.dart';
import 'package:flutter_kundol/ui/widgets/card_style_3.dart';
import 'package:flutter_kundol/ui/widgets/card_style_4.dart';
import 'package:flutter_kundol/ui/widgets/card_style_5.dart';
import 'package:flutter_kundol/ui/widgets/card_style_6.dart';
import 'package:flutter_kundol/ui/widgets/card_style_7.dart';
import 'package:flutter_kundol/ui/widgets/card_style_8.dart';
import 'package:flutter_kundol/ui/widgets/card_style_9.dart';
import 'package:flutter_kundol/ui/widgets/card_style_new_1.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';
import '../api/api_provider.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/detail_screen/detail_screen_bloc.dart';
import '../constants/app_config.dart';
import '../constants/app_constants.dart';
import '../models/user.dart';
import '../repos/cart_repo.dart';
import '../repos/products_repo.dart';
import '../tweaks/app_localization.dart';
import '../tweaks/shared_pref_service.dart';
import 'detail_screen.dart';
import 'main_screen.dart';

class ShopScreen extends StatefulWidget {
  final Category category;
  final Function(Widget widget) navigateToNext;

  const ShopScreen(this.category, this.navigateToNext);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  bool isLoadingMore = false;

  Category? category;

  // String sortBy = "id";
  // String sortType = "ASC";

  var sortType;
  var sortBy;

  @override
  void initState() {
    super.initState();
    category = widget.category;
    _scrollController.addListener(_onScroll);
    getProduct(context);
    BlocProvider.of<FiltersBloc>(context).add(const GetFilters());
  }

  @override
  Widget build(BuildContext context) {
    List<String> sorty = [
      "A-Z",
      "Z-A",
      "product_type",
      "product_status",
      "seo_desc",
      "created_at",
      "product_view"
    ];

    List<String> sortx = ["ASC", "DESC"];

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      key: _scaffoldKey,

      // drawer: Drawer(
      //   child: Column(children: [
      //     SafeArea(
      //       child: Container(
      //           color: Theme.of(context).brightness == Brightness.dark
      //               ? Color.fromRGBO(0, 0, 0, 1)
      //               : Color.fromRGBO(255, 255, 255, 1),
      //           padding:
      //               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      //           alignment: Alignment.centerLeft,
      //           width: double.maxFinite,
      //           child: Text(
      //             AppData.user != null
      //                 ? "Hey " +
      //                     AppData.user!.firstName! +
      //                     AppData.user!.lastName! +
      //                     " !"
      //                 : "Hey Guest !",
      //             style:GoogleFonts.gothicA1(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.w600,
      //                 color: Theme.of(context).brightness == Brightness.dark
      //                     ? Color.fromRGBO(255, 255, 255, 1)
      //                     : Color.fromRGBO(18, 18, 18, 1)),
      //           )),
      //     ),
      //     BlocBuilder<CategoriesBloc, CategoriesState>(
      //       builder: (context, state) {
      //         if (state is CategoriesLoaded) {
      //           List<Category> parentCategories =
      //               getParentCategories(state.categoriesResponse.data!);
      //           return Container(
      //             color: Theme.of(context).brightness == Brightness.dark
      //                 ? Color.fromRGBO(0, 0, 0, 1)
      //                 : Color.fromRGBO(255, 255, 255, 1),
      //             child: Column(
      //               children: [
      //                 Container(
      //                   width: MediaQuery.of(context).size.width,
      //                   height: MediaQuery.of(context).size.height * 0.75,
      //                   child: ListView.builder(
      //                     shrinkWrap: true,
      //                     itemCount: parentCategories.length,
      //                     itemBuilder: (context, i) {
      //                       List<Category> childData = getChildCategories(
      //                           state.categoriesResponse.data!,
      //                           parentCategories[i].id!);
      //                       return (childData.isNotEmpty)
      //                           ? ExpansionTile(
      //                               title: Text(
      //                                 parentCategories[i].name!,
      //                                 style: GoogleFonts.gothicA1(
      //                                     fontSize: 14,
      //                                     fontWeight: FontWeight.w500,
      //                                     color: Colors.black),
      //                               ),
      //                               children: <Widget>[
      //                                 Column(
      //                                   children:
      //                                       _buildExpandableContent(childData),
      //                                 ),
      //                               ],
      //                             )
      //                           : Column(
      //                               children: [
      //                                 ListTile(
      //                                   onTap: () => _navigateToNext(
      //                                       BlocProvider(
      //                                           create: (BuildContext context) {
      //                                             return ProductsByCatBloc(
      //                                                 RealProductsRepo(),
      //                                                 BlocProvider.of<
      //                                                         CategoriesBloc>(
      //                                                     context),
      //                                                 parentCategories[i].id,
      //                                                 "id",
      //                                                 "ASC",
      //                                                 "");
      //                                           },
      //                                           child: ShopScreen(
      //                                               parentCategories[i],
      //                                               _navigateToNext))),
      //                                   title: Text(
      //                                     parentCategories[i].name!,
      //                                     style: GoogleFonts.gothicA1(
      //                                         fontSize: 14,
      //                                         fontWeight: FontWeight.w600,
      //                                         color: Theme.of(context)
      //                                                     .brightness ==
      //                                                 Brightness.dark
      //                                             ? Color.fromRGBO(
      //                                                 255, 255, 255, 1)
      //                                             : Color.fromRGBO(
      //                                                 18, 18, 18, 1)),
      //                                   ),
      //                                   leading: ClipRRect(
      //                                     borderRadius: BorderRadius.circular(
      //                                         AppStyles.CARD_RADIUS),
      //                                     child: Container(
      //                                       width: MediaQuery.of(context)
      //                                               .size
      //                                               .width *
      //                                           0.18,
      //                                       height: MediaQuery.of(context)
      //                                               .size
      //                                               .height *
      //                                           0.07,
      //                                       child: CachedNetworkImage(
      //                                         imageUrl: ApiProvider
      //                                                 .imgMediumUrlString +
      //                                             parentCategories[i].gallary!,
      //                                         fit: BoxFit.fill,
      //                                         progressIndicatorBuilder: (context,
      //                                                 url, downloadProgress) =>
      //                                             Center(
      //                                                 child:
      //                                                     CircularProgressIndicator(
      //                                           value:
      //                                               downloadProgress.progress,
      //                                           color: Color.fromRGBO(
      //                                               255, 76, 59, 1),
      //                                         )),
      //                                         errorWidget:
      //                                             (context, url, error) =>
      //                                                 const Icon(Icons.error),
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 SizedBox(
      //                                   height: 5,
      //                                 ),
      //                                 Divider(
      //                                   color: Theme.of(context).brightness ==
      //                                           Brightness.dark
      //                                       ? Color.fromRGBO(160, 160, 160, 1)
      //                                       : Color.fromRGBO(112, 112, 112, 1),
      //                                 ),
      //                                 SizedBox(
      //                                   height: 5,
      //                                 ),
      //                               ],
      //                             );
      //                     },
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //                   child: Container(
      //                     height: 40,
      //                     width: double.maxFinite,
      //                     child: ElevatedButton(
      //                       style: ButtonStyle(
      //                         backgroundColor: MaterialStatePropertyAll(
      //                           Theme.of(context).brightness == Brightness.dark
      //                               ? Color.fromRGBO(0, 0, 0, 1)
      //                               : Color.fromRGBO(255, 255, 255, 1),
      //                         ),
      //                         side: const MaterialStatePropertyAll(BorderSide(
      //                             color: Color.fromRGBO(255, 76, 59, 1))),
      //                         shape: MaterialStateProperty.all<
      //                             RoundedRectangleBorder>(
      //                           RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(10.0),
      //                           ),
      //                         ),
      //                       ),
      //                       child: Text(
      //                         "Home",
      //                         style: GoogleFonts.gothicA1(
      //                           fontSize: 16,
      //                           fontWeight: FontWeight.w700,
      //                           color: Color.fromRGBO(255, 76, 59, 1),
      //                         ),
      //                       ),
      //                       onPressed: () {
      //                         Navigator.of(context).push(MaterialPageRoute(
      //                             builder: (c) => MainScreen()));
      //                       },
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 BlocConsumer<AuthBloc, AuthState>(
      //                   builder: (cotext, state) {
      //                     return Padding(
      //                       padding:
      //                           const EdgeInsets.symmetric(horizontal: 10.0),
      //                       child: Container(
      //                         height: 40,
      //                         width: double.maxFinite,
      //                         child: ElevatedButton(
      //                           style: ButtonStyle(
      //                             backgroundColor: MaterialStatePropertyAll(
      //                               Theme.of(context).brightness ==
      //                                       Brightness.dark
      //                                   ? Color.fromRGBO(0, 0, 0, 1)
      //                                   : Color.fromRGBO(255, 255, 255, 1),
      //                             ),
      //                             side: const MaterialStatePropertyAll(
      //                                 BorderSide(
      //                                     color:
      //                                         Color.fromRGBO(255, 76, 59, 1))),
      //                             shape: MaterialStateProperty.all<
      //                                 RoundedRectangleBorder>(
      //                               RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(10.0),
      //                               ),
      //                             ),
      //                           ),
      //                           child: Text(
      //                             "Logout",
      //                             style: GoogleFonts.gothicA1(
      //                               fontSize: 16,
      //                               fontWeight: FontWeight.w700,
      //                               color: Color.fromRGBO(255, 76, 59, 1),
      //                             ),
      //                           ),
      //                           onPressed: () {
      //                             BlocProvider.of<AuthBloc>(context)
      //                                 .add(PerformLogout());
      //                           },
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                   listener: (context, state) async {
      //                     if (state is UnAuthenticated) {
      //                       final sharedPrefService =
      //                           await SharedPreferencesService.instance;
      //                       await sharedPrefService.logoutUser();
      //                       AppConstants.showMessage(context,"Logout successfully",Colors.green);
      //
      //                       // ScaffoldMessenger.of(context).showSnackBar(
      //                       //   SnackBar(
      //                       //     content: Text(
      //                       //       "Logout Successfully",
      //                       //       style: GoogleFonts.gothicA1(
      //                       //           color: Color.fromRGBO(
      //                       //             255,
      //                       //             255,
      //                       //             255,
      //                       //             1,
      //                       //           ),
      //                       //           fontSize: 14,
      //                       //           fontWeight: FontWeight.w600),
      //                       //     ),
      //                       //     backgroundColor: Colors.green,
      //                       //   ),
      //                       // );
      //                       Navigator.of(context).pushAndRemoveUntil(
      //                           MaterialPageRoute(
      //                               builder: (c) => SignInScreen()),
      //                           (route) => false);
      //                     }
      //                   },
      //                 ),
      //                 SizedBox(
      //                   height: 20,
      //                 ),
      //               ],
      //             ),
      //           );
      //         } else if (state is CategoriesError) {
      //           return Text(state.error);
      //         } else {
      //           return Center(
      //             child: CircularProgressIndicator(
      //               color: Color.fromRGBO(255, 76, 59, 1),
      //               // color: Colors.white,
      //               // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
      //             ),
      //           );
      //         }
      //       },
      //     ),
      //   ]),
      // ),
      endDrawer: Drawer(
        child: Column(children: [
          SafeArea(
            child: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color.fromRGBO(0, 0, 0, 1)
                    : Color.fromRGBO(255, 255, 255, 1),
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                child: Text(
                  AppData.user != null
                      ? "Hey ! " +
                      AppData.user!.firstName!

                      : "Hey ! Guest ",
                  style:GoogleFonts.gothicA1(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(18, 18, 18, 1)),
                )),
          ),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                List<Category> parentCategories =
                getParentCategories(state.categoriesResponse.data!);
                return Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(0, 0, 0, 1)
                      : Color.fromRGBO(255, 255, 255, 1),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: parentCategories.length,
                          itemBuilder: (context, i) {
                            List<Category> childData = getChildCategories(
                                state.categoriesResponse.data!,
                                parentCategories[i].id!);
                            return (childData.isNotEmpty)
                                ? ExpansionTile(
                              title: Text(
                                parentCategories[i].name!,
                                style: GoogleFonts.gothicA1(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              children: <Widget>[
                                Column(
                                  children:
                                  _buildExpandableContent(childData),
                                ),
                              ],
                            )
                                : Column(
                              children: [
                                ListTile(
                                  onTap: () => _navigateToNext(
                                      BlocProvider(
                                          create: (BuildContext context) {
                                            return ProductsByCatBloc(
                                                RealProductsRepo(),
                                                BlocProvider.of<
                                                    CategoriesBloc>(
                                                    context),
                                                parentCategories[i].id,
                                                "id",
                                                "ASC",
                                                "");
                                          },
                                          child: ShopScreen(
                                              parentCategories[i],
                                              _navigateToNext))),
                                  title: Text(
                                    parentCategories[i].name!,
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? Color.fromRGBO(
                                            255, 255, 255, 1)
                                            : Color.fromRGBO(
                                            18, 18, 18, 1)),
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        AppStyles.CARD_RADIUS),
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.18,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.07,
                                      child: CachedNetworkImage(
                                        imageUrl: ApiProvider
                                            .imgMediumUrlString +
                                            parentCategories[i].gallary!,
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder: (context,
                                            url, downloadProgress) =>
                                            Center(
                                                child:
                                                CircularProgressIndicator(
                                                  value:
                                                  downloadProgress.progress,
                                                  color: Color.fromRGBO(
                                                      255, 76, 59, 1),
                                                )),
                                        errorWidget:
                                            (context, url, error) =>
                                        const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? Color.fromRGBO(160, 160, 160, 1)
                                      : Color.fromRGBO(112, 112, 112, 1),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 40,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(255, 255, 255, 1),
                              ),
                              side: const MaterialStatePropertyAll(BorderSide(
                                  color: Color.fromRGBO(255, 76, 59, 1))),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "Go to Home",
                              style: GoogleFonts.gothicA1(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(255, 76, 59, 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => MainScreen()));
                            },
                          ),
                        ),
                      ),

                      // BlocConsumer<AuthBloc, AuthState>(
                      //   builder: (cotext, state) {
                      //     return Padding(
                      //       padding:
                      //       const EdgeInsets.symmetric(horizontal: 10.0),
                      //       child: Container(
                      //         height: 40,
                      //         width: double.maxFinite,
                      //         child: ElevatedButton(
                      //           style: ButtonStyle(
                      //             backgroundColor: MaterialStatePropertyAll(
                      //               Theme.of(context).brightness ==
                      //                   Brightness.dark
                      //                   ? Color.fromRGBO(0, 0, 0, 1)
                      //                   : Color.fromRGBO(255, 255, 255, 1),
                      //             ),
                      //             side: const MaterialStatePropertyAll(
                      //                 BorderSide(
                      //                     color:
                      //                     Color.fromRGBO(255, 76, 59, 1))),
                      //             shape: MaterialStateProperty.all<
                      //                 RoundedRectangleBorder>(
                      //               RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(10.0),
                      //               ),
                      //             ),
                      //           ),
                      //           child: Text(
                      //             "Logout",
                      //             style: GoogleFonts.gothicA1(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w700,
                      //               color: Color.fromRGBO(255, 76, 59, 1),
                      //             ),
                      //           ),
                      //           onPressed: () {
                      //             BlocProvider.of<AuthBloc>(context)
                      //                 .add(PerformLogout());
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   listener: (context, state) async {
                      //     if (state is UnAuthenticated) {
                      //       final sharedPrefService =
                      //       await SharedPreferencesService.instance;
                      //       await sharedPrefService.logoutUser();
                      //       AppConstants.showMessage(context,"Logout successfully",Colors.green);
                      //
                      //       // ScaffoldMessenger.of(context).showSnackBar(
                      //       //   SnackBar(
                      //       //     content: Text(
                      //       //       "Logout Successfully",
                      //       //       style: GoogleFonts.gothicA1(
                      //       //           color: Color.fromRGBO(
                      //       //             255,
                      //       //             255,
                      //       //             255,
                      //       //             1,
                      //       //           ),
                      //       //           fontSize: 14,
                      //       //           fontWeight: FontWeight.w600),
                      //       //     ),
                      //       //     backgroundColor: Colors.green,
                      //       //   ),
                      //       // );
                      //       Navigator.of(context).pushAndRemoveUntil(
                      //           MaterialPageRoute(
                      //               builder: (c) => SignInScreen()),
                      //               (route) => false);
                      //     }
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                );
              } else if (state is CategoriesError) {
                return Text(state.error);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(255, 76, 59, 1),
                    // color: Colors.white,
                    // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                  ),
                );
              }
            },
          ),
        ]),
      ),
      // endDrawer: const FilterDrawer(),
      // appBar: AppConfig.APP_BAR_COLOR == 2 ?
      // AppBar(
      //   centerTitle: true,
      //   leading: const BackButton(),
      //   iconTheme: IconThemeData(
      //     color:AppConfig.APP_BAR_COLOR == 2 ?
      //     Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
      //     Colors.white,
      //   ),
      //   backgroundColor:AppConfig.APP_BAR_COLOR == 2 ?
      //   Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
      //   Colors.white,
      //   title: Text(AppLocalizations.of(context).translate("Shop"),
      //     style: TextStyle(
      //       color:AppConfig.APP_BAR_COLOR == 2 ?
      //       Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
      //       Colors.white,
      //     ),
      //   ),
      //   //style: Theme.of(context).textTheme.titleLarge),
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     Container(),
      //   ],
      // ):
      // AppConfig.APP_BAR_COLOR == 1 ?
      // AppBar(
      //   centerTitle: true,
      //   leading:  BackButton(),
      //   iconTheme: IconThemeData(
      //     color:AppConfig.APP_BAR_COLOR == 1 ?
      //     Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
      //     Colors.white,
      //   ),
      //   backgroundColor:AppConfig.APP_BAR_COLOR == 1 ?
      //   Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor:Colors.black,
      //   title: Text(AppLocalizations.of(context).translate("Shop"),
      //     style: TextStyle(
      //       color:AppConfig.APP_BAR_COLOR == 1 ?
      //       Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
      //       Colors.white,
      //     ),
      //   ),
      //   //style: Theme.of(context).textTheme.titleLarge),
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     Container(),
      //   ],
      // ):
      // AppBar(
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).brightness ==
      //         Brightness.dark
      //         ? Colors.white
      //         : Colors.black,),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   iconTheme: Theme.of(context).iconTheme,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   title: Text("Shop", style: Theme.of(context).textTheme.titleLarge),
      //   elevation: 0.0,
      //   actions: <Widget>[
      //      Container(),
      //   ],
      // ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(18, 18, 18, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        automaticallyImplyLeading: false,
        title: Text(
          widget.category.name.toString(),
          textAlign: TextAlign.center,
          style:GoogleFonts.gothicA1(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(18, 18, 18, 1),
              fontSize: 18,
              fontWeight: FontWeight.w800),
          // style: GoogleFonts.spaceGrotesk(
          //     color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        // Builder(
        //   builder: (context) {
        //     return IconButton(
        //       icon: Icon(
        //         Icons.menu,
        //         color: Theme.of(context).brightness == Brightness.dark
        //             ? Color.fromRGBO(255, 255, 255, 1)
        //             : Color.fromRGBO(18, 18, 18, 1),
        //       ), // Menu icon
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer(); // Open the drawer
        //       },
        //     );
        //   }
        // ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(255, 255, 255, 1)
              : Color.fromRGBO(18, 18, 18, 1),),
        ),
        elevation: 0.0,
        actions: [
          Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(18, 18, 18, 1),
                  ), // Menu icon
                  onPressed: () {
                    if (_scaffoldKey.currentState != null) {
                      _scaffoldKey.currentState!.openEndDrawer(); // Open the end drawer
                    } // Open the drawer
                  },
                );
              }
          ),

          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           // Return the FilterDrawer widget
          //           return FilterDrawer(
          //             navigateToNext: widget.navigateToNext,
          //             isProductFromCateogory: true,
          //             cateogory: widget.category,
          //           );
          //         },
          //       );
          //     },
          //     child: Transform.rotate(
          //         angle: 3.14 / 2,
          //         child: Icon(
          //           Icons.tune,
          //           color: Color.fromRGBO(255, 76, 59, 1),
          //         )),
          //   ),
          // )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Divider(height: 1),
          // Container(
          //   color: Theme.of(context).cardColor,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Container(
          //         constraints: const BoxConstraints(maxWidth: 80),
          //         child: BlocBuilder<CategoriesBloc, CategoriesState>(
          //           builder: (context, state) {
          //             if (state is CategoriesLoaded) {
          //               return DropdownButtonHideUnderline(
          //                   child: DropdownButton<Category>(
          //                     isExpanded: true,
          //                     value: category,
          //                     items: state.categoriesResponse.data
          //                         ?.map<DropdownMenuItem<Category>>((Category value) {
          //                       return DropdownMenuItem<Category>(
          //                           value: value,
          //                           child: Text(
          //                             value.name!,
          //                             overflow: TextOverflow.ellipsis,
          //                             // maxLines: 1,
          //                           ));
          //                     }).toList(),
          //                     onChanged: (Category? value) {
          //                       setState(() {
          //                         category = value!;
          //                       });
          //                       BlocProvider.of<ProductsByCatBloc>(context)
          //                           .add(CategoryChanged(value!.id!));
          //                     },
          //                   ));
          //             }
          //
          //             return Container();
          //           },
          //         ),
          //       ),
          //
          //
          //       Container(
          //         constraints:const BoxConstraints(maxWidth: 110),
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton<String>(
          //             hint: Text(AppLocalizations.of(context).translate("Sort By")),
          //             isExpanded: true,
          //             value: sortBy,
          //             items:
          //               sorty
          //             .map((String value) {
          //               return DropdownMenuItem<String>(
          //                 value:value,
          //                 child:Text(
          //                   AppLocalizations.of(context).translate(value),
          //                   // maxLines: 2,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               );
          //             }).toList(),
          //             onChanged: (value) {
          //               setState(() {
          //                 sortBy = value.toString();
          //               });
          //               BlocProvider.of<ProductsByCatBloc>(context)
          //                   .add(SortByChanged(value));
          //             },
          //           ),
          //         ),
          //       ),
          //
          //
          //
          //       // Container(
          //       //   constraints: const BoxConstraints(maxWidth: 130),
          //       //   child: DropdownButtonHideUnderline(
          //       //     child: DropdownButton<KeyValueRecordTypes>(
          //       //       // hint: Text(
          //       //       //     AppLocalizations.of(context)!.translate("id")!
          //       //       // ),
          //       //       isExpanded: true,
          //       //       // value: sortTypess,
          //       //       value: KeyValueRecordTypes(key: sortBy, value: sortBy),
          //       //       onChanged: (KeyValueRecordTypes? key) {
          //       //         setState(() {
          //       //           //   sortBy = value.toString();
          //       //           sortBy = key?.value.toString();
          //       //           print(sortBy);
          //       //         });
          //       //         BlocProvider.of<ProductsByCatBloc>(context)
          //       //             .add(SortByChanged(key?.key.toString()));
          //       //         // print(key?.key.toString());
          //       //       },
          //       //       items: recordTyp
          //       //           .map<DropdownMenuItem<KeyValueRecordTypes>>(
          //       //               (sortBy) =>
          //       //               DropdownMenuItem<KeyValueRecordTypes>(
          //       //                 value: sortBy,
          //       //                 child: Text(
          //       //                     sortBy.value!
          //       //                 ),
          //       //               ))
          //       //           .toList(),
          //       //     ),
          //       //   ),
          //       // ),
          //
          //
          //       Container(
          //         constraints:const BoxConstraints(maxWidth: 110),
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton<String>(
          //             hint: Text(AppLocalizations.of(context).translate("Sort Type")),
          //             isExpanded: true,
          //             value: sortType,
          //             items:
          //               sortx
          //             .map((String value) {
          //               return DropdownMenuItem<String>(
          //                 value:value,
          //                 child:Text(
          //                   AppLocalizations.of(context).translate(value),
          //                   // maxLines: 2,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               );
          //             }).toList(),
          //             onChanged: (value) {
          //               setState(() {
          //                 sortType = value.toString();
          //               });
          //               BlocProvider.of<ProductsByCatBloc>(context)
          //                   .add(SortByChanged(value));
          //             },
          //           ),
          //         ),
          //       ),
          //
          //
          //       // Container(
          //       //   constraints: const BoxConstraints(maxWidth: 100),
          //       //   child: DropdownButtonHideUnderline(
          //       //     child:DropdownButton<KeyValueRecordType>(
          //       //       hint: Text(
          //       //           AppLocalizations.of(context)!.translate("ASC")!
          //       //       ),
          //       //       isExpanded: true,
          //       //       value: recordType,
          //       //       onChanged: (KeyValueRecordType? value) {
          //       //         setState(() {
          //       //           sortBy = value.toString(); //show selected value
          //       //         });
          //       //         BlocProvider.of<ProductsByCatBloc>(context)
          //       //             .add(SortTypeChanged(value.toString()));
          //       //       },
          //       //       items: recordTypes
          //       //           .map<DropdownMenuItem<KeyValueRecordType>>(
          //       //               (recordType) =>
          //       //           DropdownMenuItem<KeyValueRecordType>(
          //       //             value: recordType,
          //       //             child: Text(recordType.value!),
          //       //           ))
          //       //           .toList(),
          //       //     ),
          //       //   ),
          //       // ),
          //
          //       InkWell(
          //         onTap: () {
          //           _scaffoldKey.currentState?.openEndDrawer();
          //         },
          //         child: Container(
          //           padding: const EdgeInsets.all(6.0),
          //           child: Row(
          //             children: [
          //               Text(AppLocalizations.of(context).translate("Filter")),
          //               const Icon(
          //                 Icons.filter_alt_outlined,
          //                 size: 16,
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Return the FilterDrawer widget
                      return FilterDrawer(
                        navigateToNext: widget.navigateToNext,
                        isProductFromCateogory: true,
                        cateogory: widget.category,
                      );
                    },
                  );
                },
                icon: Transform.rotate(
                  angle: 3.14 / 2,
                  child: Icon(
                    Icons.tune,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(160, 160, 160, 1)
                        : Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                label: Text(
                  "Filter",
                  style: GoogleFonts.gothicA1(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(160, 160, 160, 1)
                        : Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
              ),
            ),
          ]),
          //     // Directionality(
          //     //   textDirection: TextDirection.rtl,
          //     //   child: TextButton.icon(
          //     //     onPressed: () {
          //     //       showDialog(
          //     //           context: context,
          //     //           builder: (BuildContext context) {
          //     //             return Dialog(
          //     //               surfaceTintColor: Colors.white,
          //     //               backgroundColor: Colors.white,
          //     //               insetPadding:
          //     //                   const EdgeInsets.symmetric(horizontal: 35),
          //     //               child: Container(
          //     //                 padding: const EdgeInsets.symmetric(
          //     //                     horizontal: 30, vertical: 20),
          //     //                 child: Wrap(
          //     //                   children: [
          //     //                     sorByItemWidget(1, "Best match"),
          //     //                     const Divider(
          //     //                       height: 1,
          //     //                     ),
          //     //                     sorByItemWidget(2, "Price: low to high"),
          //     //                     const Divider(
          //     //                       height: 1,
          //     //                     ),
          //     //                     sorByItemWidget(3, "Price: high to low"),
          //     //                     const Divider(
          //     //                       height: 1,
          //     //                     ),
          //     //                     sorByItemWidget(4, "Newest"),
          //     //                     const Divider(
          //     //                       height: 1,
          //     //                     ),
          //     //                     sorByItemWidget(5, "Customer rating"),
          //     //                     const Divider(
          //     //                       height: 1,
          //     //                     ),
          //     //                     sorByItemWidget(6, "Most popular"),
          //     //                   ],
          //     //                 ),
          //     //               ),
          //     //             );
          //     //           });
          //     //     },
          //     //     label: Text(
          //     //       "Sorting By",
          //     //       style: GoogleFonts.lato(
          //     //         fontSize: 14,
          //     //         fontWeight: FontWeight.w600,
          //     //         color: const Color(0xFF707070),
          //     //       ),
          //     //     ),
          //     //     icon: const Icon(Icons.keyboard_arrow_down_rounded),
          //     //   ),
          //     // )
          //   ],
          // ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
                    vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<ProductsByCatBloc, ProductsByCatState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case ProductsStatus.success:
                            isLoadingMore = false;
                            if (state.products!.isEmpty) {
                              return  Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 45,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.95,
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      child: Image.asset(
                                        "assets/images/product-not-found image shop screen.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        "Product not available",
                                        style: GoogleFonts.gothicA1(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).brightness == Brightness.dark
                                                ? Color.fromRGBO(255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 0.75,
                                    ),
                                    itemCount: state.products!.length,
                                    itemBuilder: (context, index) {
                                      return productCard(
                                          state.products![index]);
                                    },
                                  ),
                                  if (!state.hasReachedMax! &&
                                      state.products!.isNotEmpty &&
                                      state.products!.length % 10 == 0)
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.all(16.0),
                                        width: 24.0,
                                        height: 24.0,
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(255, 76, 59, 1),
                                          // color:
                                          //     Theme.of(context).brightness ==
                                          //             Brightness.dark
                                          //         ? Colors.white
                                          //         : Theme.of(context)
                                          //             .primaryColor,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }
                          case ProductsStatus.failure:
                            return Text(AppLocalizations.of(context)
                                .translate("Error"));
                          default:
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(255, 76, 59, 1),
                                // color: Theme.of(context).brightness ==
                                //         Brightness.dark
                                //     ? Colors.white
                                //     : Theme.of(context).primaryColor,
                                //  backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  int selectedSortId = 1;
  List<Category> getParentCategories(List<Category> data) {
    List<Category> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == null) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

  List<Category> getChildCategories(List<Category> data, int id) {
    List<Category> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == id) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

  _buildExpandableContent(List<Category> data) {
    List<Widget> columnContent = [];

    for (Category category in data) {
      columnContent.add(
        ListTile(
          onTap: () => _navigateToNext(BlocProvider(
              create: (BuildContext context) {
                return ProductsByCatBloc(
                    RealProductsRepo(),
                    BlocProvider.of<CategoriesBloc>(context),
                    category.id,
                    "id",
                    "ASC",
                    "");
              },
              child: ShopScreen(category, _navigateToNext))),
          title: Text(
            category.name!,
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
      );
    }

    return columnContent;
  }

  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        )).then((val) => setState(() {}));
  }

  Widget sorByItemWidget(int id, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSortId = id;
        });
        debugPrint("sorting $title");
        getProductBySorting(context, title);
      },
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Container(
              height: 20,
              width: 20,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2)),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedSortId == id
                        ? Colors.black
                        : Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productCard(Product product) {
    return InkWell(
      onTap: () {
        widget.navigateToNext(
          BlocProvider(
              create: (context) =>
                  DetailScreenBloc(RealCartRepo(), RealProductsRepo()),
              child: ProductDetailScreen(product, widget.navigateToNext)),
        );
      },
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                    "${ApiProvider.imgMediumUrlString}${product.productGallary!.gallaryName!}"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
            ),
            child: Text(
              "${product.detail!.first.title}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.gothicA1(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${AppData.currency!.code}${product.productDiscountPrice}",
                      style: GoogleFonts.gothicA1(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF4C3B),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(width: 6,),
                    Text(
                      "${AppData.currency!.code}${product.productPrice}",
                      style: GoogleFonts.gothicA1(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500, decoration: TextDecoration
                          .lineThrough,),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.deepOrange,
                      size: 20,
                    ),
                    Text(
                      product.productRating != null
                          ? " ${product.productRating!.toStringAsFixed(1)}"
                          : "0",
                      style: GoogleFonts.gothicA1(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromRGBO(160, 160, 160, 1)
                              : Color.fromRGBO(112, 112, 112, 1)),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool checkForWishlist(int productId) {
    for (int i = 0; i < AppData.wishlistData.length; i++) {
      if (productId == AppData.wishlistData[i].productId) {
        return true;
      }
    }
    return false;
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getProduct(context);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void getProduct(context) {
    BlocProvider.of<ProductsByCatBloc>(context)
        .add(GetProductsByCat(widget.category.id!, sortBy));
  }

  void getProductBySorting(context, sortBy) {
    BlocProvider.of<ProductsByCatBloc>(context).add(SortByChanged(sortBy));
    Navigator.pop(context);
  }

  int getCategoryId(String value, List<Category> data) {
    for (int i = 0; i < data.length; i++) {
      if (value == data[i].name) return data[i].id!;
    }
    return 0;
  }

  Category? getCategory(String value, List<Category> data) {
    for (int i = 0; i < data.length; i++) {
      if (value == data[i].name) return data[i];
    }
    return null;
  }

  Widget getDefaultCard(Product product, int index) {
    switch (int.parse(
        AppData.settingsResponse!.getKeyValue(SettingsResponse.CARD_STYLE))) {
      case 1:
        return CardStyleNew1(
            widget.navigateToNext, product, getCardBackground(index));
      case 2:
        return CardStyle2(
            widget.navigateToNext, product, getCardBackground(index));
      case 3:
        return CardStyle3(
            widget.navigateToNext, product, getCardBackground(index));
      case 4:
        return CardStyle4(
            widget.navigateToNext, product, getCardBackground(index));
      case 5:
        return CardStyle5(
            widget.navigateToNext, product, getCardBackground(index));
      case 6:
        return CardStyle6(
            widget.navigateToNext, product, getCardBackground(index));
      case 7:
        return CardStyle7(
            widget.navigateToNext, product, getCardBackground(index));
      case 8:
        return CardStyle8(
            widget.navigateToNext, product, getCardBackground(index));
      case 9:
        return CardStyle9(
            widget.navigateToNext, product, getCardBackground(index));
      case 10:
        return CardStyle10(
            widget.navigateToNext, product, getCardBackground(index));
      case 11:
        return CardStyle11(
            widget.navigateToNext, product, getCardBackground(index));
      case 12:
        return CardStyle12(
            widget.navigateToNext, product, getCardBackground(index));
      case 13:
        return CardStyle13(
            widget.navigateToNext, product, getCardBackground(index));
      case 14:
        return CardStyle14(
            widget.navigateToNext, product, getCardBackground(index));
      case 15:
        return CardStyle15(
            widget.navigateToNext, product, getCardBackground(index));
      case 16:
        return CardStyle16(
            widget.navigateToNext, product, getCardBackground(index));
      case 17:
        return CardStyle17(
            widget.navigateToNext, product, getCardBackground(index));
      case 18:
        return CardStyle18(
            widget.navigateToNext, product, getCardBackground(index));
      case 19:
        return CardStyle19(
            widget.navigateToNext, product, getCardBackground(index));
      case 20:
        return CardStyle20(
            widget.navigateToNext, product, getCardBackground(index));
      case 21:
        return CardStyle21(
            widget.navigateToNext, product, getCardBackground(index));
      case 22:
        return CardStyle22(
            widget.navigateToNext, product, getCardBackground(index));
      case 23:
        return CardStyle23(
            widget.navigateToNext, product, getCardBackground(index));
      case 24:
        return CardStyle24(
            widget.navigateToNext, product, getCardBackground(index));
      case 25:
        return CardStyle25(
            widget.navigateToNext, product, getCardBackground(index));
      case 26:
        return CardStyle26(
            widget.navigateToNext, product, getCardBackground(index));
      case 27:
        return CardStyle27(
            widget.navigateToNext, product, getCardBackground(index));
      default:
        return CardStyleNew1(
            widget.navigateToNext, product, getCardBackground(index));
    }
  }
}

int cardColorindex = 0;

Color getCardBackground(int index) {
  Color tempColor = AppStyles.cardColors[cardColorindex];
  cardColorindex++;
  if (cardColorindex == 4) cardColorindex = 0;
  return tempColor;
}

typedef ChoiceChipsCallback = void Function(List<Variations> variations);

class ChoiceChips extends StatefulWidget {
  final List<Variations>? chipName;
  final ChoiceChipsCallback? choiceChipsCallback;
  Variations? selectedVariation;

  ChoiceChips(
      {Key? key,
      this.chipName,
      this.choiceChipsCallback,
      this.selectedVariation})
      : super(key: key);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  List<bool> selections = [];
  List<Variations> selectedVariations = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.chipName!.length; i++) {
      selections.add(false);
    }
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.chipName?.asMap().forEach((index, item) {
      choices.add(Container(
        child: ChoiceChip(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(18, 18, 18, 1)
              : Color.fromRGBO(240, 240, 240, 1),
          label: Text(
            item.detail!.first.name!,
          ),
          labelStyle: GoogleFonts.gothicA1(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.dark
                ? selections[index]
                    ? Color.fromRGBO(255, 76, 59, 1)
                    : Color.fromRGBO(255, 255, 255, 1)
                : selections[index]
                    ? Color.fromRGBO(255, 76, 59, 1)
                    : Color.fromRGBO(0, 0, 0, 1),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? selections[index]
                        ? Color.fromRGBO(255, 76, 59, 1)
                        : Color.fromRGBO(18, 18, 18, 1)
                    : selections[index]
                        ? Color.fromRGBO(255, 76, 59, 1)
                        : Color.fromRGBO(240, 240, 240, 1),
                width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          selectedColor: Colors.transparent,
          selected: selections[index],
          onSelected: (selected) {
            setState(() {
              selections[index] = !selections[index];
              selectedVariations = [];
              for (int i = 0; i < selections.length; i++) {
                if (selections[i]) {
                  selectedVariations.add(widget.chipName![i]);
                } else {
                  selectedVariations.remove(widget.chipName![i]);
                }
              }
              widget.choiceChipsCallback!(selectedVariations);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 3.0,
      children: _buildChoiceList(),
    );
  }
}

class FilterDrawer extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final bool? isProductFromCateogory;
  final bool? isFromSearch;
  final Category? cateogory;

  const FilterDrawer(
      {Key? key,
      this.navigateToNext,
      this.isProductFromCateogory = false,
      this.cateogory,
      this.isFromSearch = false})
      : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  // RangeValues? values = const RangeValues(1, 1000000);
  // RangeLabels? labels = const RangeLabels('\$1', "\$1000000");
  List<FiltersData>? selectedFilters = [];
  List<int>? selectedIds = [];
  List<int>? selectedattributeids = [];
  List<String>? selectedVariatioName = [];
  double _lowerValue = 1;
  double _upperValue = 100;

//SfRangeValues _values = SfRangeValues(40.0, 80.0);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(0, 0, 0, 1)
            : Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
                height: 50,
                width: double.maxFinite,
                child: Row(children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations.of(context)!.translate(
                            "Filters",
                          )!,
                          style: GoogleFonts.gothicA1(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(0, 0, 0, 1)),
                        )),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(0, 0, 0, 1),
                        size: 24,
                      ))
                ])),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate("Product Price")!,
                          style: GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(0, 0, 0, 1)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Row(
                          children: [
                            Text(
                              "${AppData.currency!.code!}${_lowerValue!.toStringAsFixed(2)}",
                              style: GoogleFonts.gothicA1(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(240, 240, 240, 1)
                                      : Color.fromRGBO(18, 18, 18, 1)),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "${AppData.currency!.code!}${_upperValue!.toStringAsFixed(2)}",
                              style:GoogleFonts.gothicA1(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromRGBO(240, 240, 240, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        ),
                      ),
// SfRangeSlider(
//         min: 0.0,
//         max: 100.0,
//         values: _values,
//         interval: 20,
//         showTicks: true,
//         showLabels: true,
//         enableTooltip: true,
//         minorTicksPerInterval: 1,
//         onChanged: (SfRangeValues values){
//           setState(() {
//             _values = values;
//           });
//         },
//       ),
                      SizedBox(
                        height: 60,
                      ),

                      RangeSliderFlutter(
                        values: [
                          _lowerValue,
                          _upperValue,
                        ],
                        rangeSlider: true,
                        // textColor: Color.fromRGBO(255, 255, 255, 1),
                        tooltip: RangeSliderFlutterTooltip(
                          alwaysShowTooltip: true,
                          textStyle: GoogleFonts.gothicA1(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        max: 10000,
                        textPositionTop: -80,
                        handlerHeight: 20,
                        trackBar: RangeSliderFlutterTrackBar(
                          activeTrackBarHeight: 10,
                          inactiveTrackBarHeight: 10,
                          activeTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 76, 59, 1)),
                          inactiveTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                        min: 1,
                        ignoreSteps: [],
                        fontSize: 14,
                        textBackgroundColor: Color.fromRGBO(255, 76, 59, 1),
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          _lowerValue = lowerValue;
                          _upperValue = upperValue;
                          setState(() {});
                        },
                      ),
                      // color:AppConfig.APP_BAR_COLOR == 2 ?
                      // Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
                      // Colors.white,
                      // RangeSlider(
                      //     activeColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                      //     min: 1,
                      //     max: 1000000,
                      //     divisions: 50,
                      //     values: values!,
                      //     labels: labels,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         values = value;
                      //         labels = RangeLabels(
                      //             "${value.start.round().toString()}\$",
                      //             "${value.end.round.toString()}\$");
                      //       });
                      //     }),
                      BlocBuilder<FiltersBloc, FiltersState>(
                        builder: (context, state) {
                          if (state is FiltersLoaded) {
                            for (var filter in state.filtersResponse!.data!) {
                              debugPrint("filter ${filter.toJson()}");
                            }

                            return Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.filtersResponse?.data?.length,
                                itemBuilder: (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                        state.filtersResponse!.data![index]
                                            .detail!.first.name!,
                                        style:GoogleFonts.gothicA1(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1))),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    ChoiceChips(
                                      selectedVariation: null,
                                      chipName: state.filtersResponse
                                          ?.data![index].variations,
                                      choiceChipsCallback: (variation) {
                                        FiltersData data = FiltersData();
                                        data.attributeId = state.filtersResponse
                                            ?.data![index].attributeId;
                                        data.variations = variation;
                                        if (selectedFilters!.isEmpty) {
                                          selectedFilters!.add(data);
                                        } else {
                                          for (int i = 0;
                                              i < selectedFilters!.length;
                                              i++) {
                                            if (selectedFilters![i]
                                                    .attributeId ==
                                                state
                                                    .filtersResponse
                                                    ?.data![index]
                                                    .attributeId) {
                                              selectedFilters!.removeAt(i);
                                            }
                                          }
                                          selectedFilters!.add(data);
                                        }

                                        selectedIds!.clear();
                                        selectedVariatioName!.clear();
                                        selectedattributeids!.clear();

                                        for (int i = 0;
                                            i < selectedFilters!.length;
                                            i++) {
                                          for (int j = 0;
                                              j <
                                                  selectedFilters![i]
                                                      .variations!
                                                      .length;
                                              j++) {
                                            selectedIds!.add(selectedFilters![i]
                                                .variations![j]
                                                .id!);

                                            selectedVariatioName!.add(
                                                selectedFilters![i]
                                                    .variations![j]
                                                    .detail![0]
                                                    .name!);

                                            selectedattributeids!.add(
                                                selectedFilters![i]
                                                    .attributeId!);
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.only(top: 20),
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                  )),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 2, // 60% of space => (6/(6 + 4))
                      child: SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(255, 76, 59, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context).translate("Reset"),
                            style: GoogleFonts.gothicA1(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    flex: 4, // 40% of space
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(255, 76, 59, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          debugPrint("selectionIDS:  ${selectedIds!.toSet()}");
                          var finalVariation = selectedIds!.toSet().join(',');
                          var finalVariationName =
                              selectedVariatioName!.toSet().join(', ');
                          var finalaAttributeId =
                              selectedattributeids!.toSet().join(',');
                          debugPrint("finalSelectedId:  $finalVariation");
                          if (widget.isProductFromCateogory!) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            widget.navigateToNext!(BlocProvider(
                                create: (BuildContext context) {
                                  return ProductsByCatBloc(
                                      RealProductsRepo(),
                                      BlocProvider.of<CategoriesBloc>(context),
                                      widget.cateogory!.id,
                                      "id",
                                      "ASC",
                                      "")
                                    ..add(FiltersChanged(
                                        variation: finalVariation,
                                        attribute: finalaAttributeId,
                                        variationName: finalVariationName,
                                        pricFrom: _lowerValue.toString(),
                                        priceTo: _upperValue.toString()));
                                },
                                child: ShopScreen(widget.cateogory!,
                                    widget.navigateToNext!)));
                          } else if (widget.isFromSearch!) {
                            Navigator.pop(context);
                            widget.navigateToNext!(
                                BlocProvider(
                                    create: (BuildContext context) {
                                      return ProductsSearchBloc(
                                          RealProductsRepo())
                                        ..add(SearchFiltersChanged(
                                            variation: finalVariation,
                                            attribute: finalaAttributeId,
                                            variationName: finalVariationName,
                                            pricFrom: _lowerValue.toString(),
                                            priceTo: _upperValue.toString()));
                                    },
                                    child: SearchScreen(
                                      widget.navigateToNext
                                    ))
                            );
                            // BlocProvider.of<ProductsSearchBloc>(context).add(
                            //     SearchFiltersChanged(
                            //         variation: finalVariation,
                            //         attribute: finalaAttributeId,
                            //         variationName: finalVariationName,
                            //         pricFrom: _lowerValue.toString(),
                            //         priceTo: _upperValue.toString()));
                          }
                          else {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            widget.navigateToNext!(
                                BlocProvider(
                                create: (BuildContext context) {
                                  return FeaturedProductsBloc(
                                      RealProductsRepo())
                                    ..add(FeaturedFiltersChanged(
                                        variation: finalVariation,
                                        attribute: finalaAttributeId,
                                        variationName: finalVariationName,
                                        pricFrom: _lowerValue.toString(),
                                        priceTo: _upperValue.toString()));
                                },
                                child: ViewAllScreen("Feature Products",
                                    widget.navigateToNext!))
                            );
                          }
                        },
                        child: Text(
                          //  AppLocalizations.of(context)!.translate("Apply"
                          "Apply",
                          style: GoogleFonts.gothicA1(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
// import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
// import 'package:flutter_kundol/blocs/filters/filters_bloc.dart';
// import 'package:flutter_kundol/blocs/products/products_bloc.dart';
// import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
// import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/category.dart';
// import 'package:flutter_kundol/models/filters_data.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_10.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_11.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_12.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_13.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_14.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_15.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_16.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_17.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_18.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_19.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_2.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_20.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_21.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_22.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_23.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_24.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_25.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_26.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_27.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_3.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_4.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_5.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_6.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_7.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_8.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_9.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_new_1.dart';
//
//
// import '../constants/app_config.dart';
// import '../models/user.dart';
// import '../tweaks/app_localization.dart';
//
//
// class KeyValueRecordType extends Equatable {
//   String? key;
//   String? value;
//
//   KeyValueRecordType({required this.key, required this.value});
//
//   @override
//   List<Object> get props => [key!, value!];
// }
//
//
// class KeyValueRecordTypes extends Equatable {
//   String? key;
//   String? value;
//
//   KeyValueRecordTypes({required this.key, required this.value});
//
//   @override
//   List<Object> get props => [key!, value!];
// }
//
//
//
// class ShopScreen extends StatefulWidget {
//   final Category category;
//   final Function(Widget widget) navigateToNext;
//
//   const ShopScreen(this.category, this.navigateToNext);
//
//   @override
//   _ShopScreenState createState() => _ShopScreenState();
// }
//
// class _ShopScreenState extends State<ShopScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _scrollController = ScrollController();
//   bool isLoadingMore = false;
//
//  Category? category;
//   // String sortBy = "id";
//   // String sortType = "ASC";
//
// //  String? recordType = "ASC";
//   String? sortBy = "id";
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     category = widget.category;
//     _scrollController.addListener(_onScroll);
//     getProduct(context);
//     BlocProvider.of<FiltersBloc>(context).add(const GetFilters());
//   }
//  // int? _user;
//
//   // var users = <String>[
//   //   'Bob',
//   //   'Allie',
//   //   'Jason',
//   // ];
//   @override
//   Widget build(BuildContext context) {
//
//     List<KeyValueRecordType> recordTypes = <KeyValueRecordType>[
//       KeyValueRecordType (key: "ASC", value: AppLocalizations.of(context)!.translate("ASC")!),
//       KeyValueRecordType (key: "DESC", value: AppLocalizations.of(context)!.translate("DESC")!),
//     ];
//
//     List<KeyValueRecordTypes> recordTyp = <KeyValueRecordTypes>[
//       KeyValueRecordTypes(key: "id", value: AppLocalizations.of(context)!.translate("id")!),
//       KeyValueRecordTypes(key: "price", value: AppLocalizations.of(context)!.translate("price")!),
//       KeyValueRecordTypes(key: "product_type", value: AppLocalizations.of(context)!.translate("product_type")!),
//       KeyValueRecordTypes(key: "discount_price", value: AppLocalizations.of(context)!.translate("discount_price")!),
//       KeyValueRecordTypes(key: "product_status", value: AppLocalizations.of(context)!.translate("product_status")!),
//       KeyValueRecordTypes(key: "seo_desc", value: AppLocalizations.of(context)!.translate("seo_desc")!),
//       KeyValueRecordTypes(key: "created_at", value: AppLocalizations.of(context)!.translate("created_at")!),
//       KeyValueRecordTypes(key: "product_view", value: AppLocalizations.of(context)!.translate("product_view")!),
//
//     ];
//
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
//       key: _scaffoldKey,
//       endDrawer:  FilterDrawer(),
//       appBar: AppConfig.APP_BAR_COLOR == 2 ?
//       AppBar(
//         centerTitle: true,
//         leading: const BackButton(),
//         iconTheme: IconThemeData(
//           color:AppConfig.APP_BAR_COLOR == 2 ?
//           Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
//           Colors.white,
//         ),
//         backgroundColor:AppConfig.APP_BAR_COLOR == 2 ?
//         Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
//         Colors.white,
//         title: Text(AppLocalizations.of(context)!.translate("Shop")!,
//           style: TextStyle(
//             color:AppConfig.APP_BAR_COLOR == 2 ?
//             Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
//             Colors.white,
//           ),
//         ),
//         //style: Theme.of(context).textTheme.titleLarge),
//         elevation: 0.0,
//         actions: <Widget>[
//           Container(),
//         ],
//       ):
//       AppBar(
//         centerTitle: true,
//         leading:  BackButton(),
//         iconTheme: IconThemeData(
//           color:AppConfig.APP_BAR_COLOR == 1 ?
//           Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
//           Colors.white,
//         ),
//         backgroundColor:AppConfig.APP_BAR_COLOR == 1 ?
//         Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor:Colors.black,
//         title: Text(AppLocalizations.of(context)!.translate("Shop")!,
//           style: TextStyle(
//             color:AppConfig.APP_BAR_COLOR == 1 ?
//             Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
//             Colors.white,
//           ),
//         ),
//         //style: Theme.of(context).textTheme.titleLarge),
//         elevation: 0.0,
//         actions: <Widget>[
//           Container(),
//         ],
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             color: Theme.of(context).cardColor,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   constraints: const BoxConstraints(maxWidth: 80),
//                   child: BlocBuilder<CategoriesBloc, CategoriesState>(
//                     builder: (context, state) {
//                       if (state is CategoriesLoaded) {
//                         return DropdownButtonHideUnderline(
//                             child: DropdownButton<Category>(
//                           isExpanded: true,
//                           value: category,
//                           items: state.categoriesResponse.data
//                               ?.map<DropdownMenuItem<Category>>((Category value) {
//                             return DropdownMenuItem<Category>(
//                                 value: value,
//                                 child: Text(
//                                   value.name!,
//                                   overflow: TextOverflow.ellipsis,
//                                   // maxLines: 1,
//                                 ));
//                           }).toList(),
//                           onChanged: (Category? value) {
//                             setState(() {
//                               category = value!;
//                             });
//                             BlocProvider.of<ProductsByCatBloc>(context)
//                                 .add(CategoryChanged(value!.id!));
//                           },
//                         ));
//                       }
//
//                       return Container();
//                     },
//                   ),
//                 ),
//
//
//                 // Container(
//                 //   constraints: BoxConstraints(maxWidth: 80),
//                 //   child: DropdownButtonHideUnderline(
//                 //     child: DropdownButton<String>(
//                 //       isExpanded: true,
//                 //       value: sortBy,
//                 //       items: <String>[
//                 //         'id',
//                 //         'price',
//                 //         'product_type',
//                 //         'discount_price',
//                 //         'product_status',
//                 //         'product_view',
//                 //         'seo_desc',
//                 //         'created_at'
//                 //       ].map((String value) {
//                 //         return DropdownMenuItem<String>(
//                 //           value: value,
//                 //           child: new Text(
//                 //             value,
//                 //             // AppLocalizations.of(context).translate("array","id"),
//                 //             // maxLines: 2,
//                 //             overflow: TextOverflow.ellipsis,
//                 //           ),
//                 //         );
//                 //       }).toList(),
//                 //       onChanged: (value) {
//                 //         setState(() {
//                 //           sortBy = value.toString();
//                 //         });
//                 //         BlocProvider.of<ProductsByCatBloc>(context)
//                 //             .add(SortByChanged(value));
//                 //       },
//                 //     ),
//                 //   ),
//                 // ),
//
//                 Container(
//                   constraints: const BoxConstraints(maxWidth: 130),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<KeyValueRecordTypes>(
//                       hint: Text(
//                           AppLocalizations.of(context)!.translate("id")!
//                       ),
//                       isExpanded: true,
//                      // value: sortTypess,
//                       value: recordTyp[0],
//                       onChanged: (KeyValueRecordTypes? key) {
//                         setState(() {
//                        //   sortBy = value.toString();
//                           sortBy = key?.key;
//                           print(sortBy);
//                         });
//                         BlocProvider.of<ProductsByCatBloc>(context)
//                             .add(SortByChanged(key?.key.toString()));
//                        // print(key?.key.toString());
//                       },
//                       items: recordTyp
//                           .map<DropdownMenuItem<KeyValueRecordTypes>>(
//                               (sortBy) =>
//                           DropdownMenuItem<KeyValueRecordTypes>(
//                             value: sortBy,
//                             child: Text(
//                                 sortBy.key!
//                             ),
//                           ))
//                           .toList(),
//                     ),
//                   ),
//                 ),
//
//
//
//                 //  DropdownButton<KeyValueRecordType>(
//                 // hint: new Text('Pickup on every'),
//                 // value: sortBy == null ? null : recordTypes[0],
//                 // items: recordTypes.map((KeyValueRecordType value) {
//                 // return new DropdownMenuItem<KeyValueRecordType>(
//                 // value: value,
//                 // child: new Text(value.toString()),
//                 // );
//                 // }).toList(),
//                 // onChanged: (value) {
//                 // setState(() {
//                 //   sortBy = recordTypes.indexOf(value!) as String?;
//                 // print(recordTypes);
//                 // });
//                 // },
//                 // ),
//
//
//
//
//                 // Container(
//                 //   constraints: BoxConstraints(maxWidth: 100),
//                 //   child: DropdownButtonHideUnderline(
//                 //     child: DropdownButton<String>(
//                 //       value: sortType,
//                 //       items: <String>['ASC', 'DESC'].map((String value) {
//                 //         return DropdownMenuItem<String>(
//                 //           value: value,
//                 //           child: new Text(
//                 //             value,
//                 //             overflow: TextOverflow.ellipsis,
//                 //             // maxLines: 1,
//                 //           ),
//                 //         );
//                 //       }).toList(),
//                 //       onChanged: (value) {
//                 //         setState(() {
//                 //           sortType = value;
//                 //         });
//                 //         BlocProvider.of<ProductsByCatBloc>(context)
//                 //             .add(SortTypeChanged(value));
//                 //       },
//                 //     ),
//                 //   ),
//                 // ),
//
//
//                 // Container(
//                 //   constraints: const BoxConstraints(maxWidth: 100),
//                 //   child: DropdownButtonHideUnderline(
//                 //     child:DropdownButton<KeyValueRecordType>(
//                 //       hint: Text(
//                 //           AppLocalizations.of(context)!.translate("ASC")!
//                 //       ),
//                 //       isExpanded: true,
//                 //       value: recordType,
//                 //       onChanged: (KeyValueRecordType? value) {
//                 //         setState(() {
//                 //           sortBy = value.toString(); //show selected value
//                 //         });
//                 //         BlocProvider.of<ProductsByCatBloc>(context)
//                 //             .add(SortTypeChanged(value.toString()));
//                 //       },
//                 //       items: recordTypes
//                 //           .map<DropdownMenuItem<KeyValueRecordType>>(
//                 //               (recordType) =>
//                 //           DropdownMenuItem<KeyValueRecordType>(
//                 //             value: recordType,
//                 //             child: Text(recordType.value!),
//                 //           ))
//                 //           .toList(),
//                 //     ),
//                 //   ),
//                 // ),
//                 InkWell(
//                   onTap: () {
//                     _scaffoldKey.currentState?.openEndDrawer();
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(6.0),
//                     child: Row(
//                       children: [
//                         Text(AppLocalizations.of(context)!.translate("Filter")!),
//                         const Icon(
//                           Icons.filter_alt_outlined,
//                           size: 16,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
//                     vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     BlocBuilder<ProductsByCatBloc, ProductsByCatState>(
//                       builder: (context, state) {
//                         switch (state.status) {
//                           case ProductsStatus.success:
//                             isLoadingMore = false;
//                             if (state.products!.isEmpty) {
//                               return Center(child: Text(AppLocalizations.of(context)!.translate("Empty")!));
//                             } else {
//                               return Column(
//                               children: [
//                                 GridView.builder(
//                                   padding: EdgeInsets.zero,
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: AppStyles.GRID_SPACING,
//                                     mainAxisSpacing: AppStyles.GRID_SPACING,
//                                     childAspectRatio: 0.75,
//                                   ),
//                                   itemCount: state.products!.length,
//                                   itemBuilder: (context, index) {
//                                     return getDefaultCard(state.products![index], index);
//                                   },
//                                 ),
//                                 if (!state.hasReachedMax! &&
//                                     state.products!.isNotEmpty &&
//                                     state.products!.length % 10 == 0)
//                                   Center(
//                                     child: Container(
//                                         margin: const EdgeInsets.all(16.0),
//                                         width: 24.0,
//                                         height: 24.0,
//                                         child: CircularProgressIndicator(
//                                           color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
//                                         )),
//                                   ),
//                               ],
//                             );
//                             }
//                             break;
//                           case ProductsStatus.failure:
//                             return Text(AppLocalizations.of(context)!.translate("Error")!);
//                           default:
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
//                               ),
//                             );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   bool checkForWishlist(int productId) {
//     for (int i = 0; i < AppData.wishlistData!.length; i++) {
//       if (productId == AppData.wishlistData![i].productId) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   void _onScroll() {
//     if (_isBottom && !isLoadingMore) {
//       isLoadingMore = true;
//       getProduct(context);
//     }
//   }
//
//   bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * 0.9);
//   }
//
//   void getProduct(context) {
//     BlocProvider.of<ProductsByCatBloc>(context)
//         .add(GetProductsByCat(widget.category.id!, sortBy));
//   }
//
//   int getCategoryId(String value, List<Category> data) {
//     for (int i = 0; i < data.length; i++) {
//       if (value == data[i].name) return data[i].id!;
//     }
//     return 0;
//   }
//
//   Category? getCategory(String value, List<Category> data) {
//     for (int i = 0; i < data.length; i++) {
//       if (value == data[i].name) return data[i];
//     }
//   }
//
//   Widget getDefaultCard(Product product, int index) {
//     switch (int.parse(
//         AppData.settingsResponse!.getKeyValue(SettingsResponse.CARD_STYLE))) {
//       case 1:
//         return CardStyleNew1(widget.navigateToNext, product, getCardBackground(index));
//       case 2:
//         return CardStyle2(widget.navigateToNext, product, getCardBackground(index));
//       case 3:
//         return CardStyle3(widget.navigateToNext, product, getCardBackground(index));
//       case 4:
//         return CardStyle4(widget.navigateToNext, product, getCardBackground(index));
//       case 5:
//         return CardStyle5(widget.navigateToNext, product, getCardBackground(index));
//       case 6:
//         return CardStyle6(widget.navigateToNext, product, getCardBackground(index));
//       case 7:
//         return CardStyle7(widget.navigateToNext, product, getCardBackground(index));
//       case 8:
//         return CardStyle8(widget.navigateToNext, product, getCardBackground(index));
//       case 9:
//         return CardStyle9(widget.navigateToNext, product, getCardBackground(index));
//       case 10:
//         return CardStyle10(widget.navigateToNext, product, getCardBackground(index));
//       case 11:
//         return CardStyle11(widget.navigateToNext, product, getCardBackground(index));
//       case 12:
//         return CardStyle12(widget.navigateToNext, product, getCardBackground(index));
//       case 13:
//         return CardStyle13(widget.navigateToNext, product, getCardBackground(index));
//       case 14:
//         return CardStyle14(widget.navigateToNext, product, getCardBackground(index));
//       case 15:
//         return CardStyle15(widget.navigateToNext, product, getCardBackground(index));
//       case 16:
//         return CardStyle16(widget.navigateToNext, product, getCardBackground(index));
//       case 17:
//         return CardStyle17(widget.navigateToNext, product, getCardBackground(index));
//       case 18:
//         return CardStyle18(widget.navigateToNext, product, getCardBackground(index));
//       case 19:
//         return CardStyle19(widget.navigateToNext, product, getCardBackground(index));
//       case 20:
//         return CardStyle20(widget.navigateToNext, product, getCardBackground(index));
//       case 21:
//         return CardStyle21(widget.navigateToNext, product, getCardBackground(index));
//       case 22:
//         return CardStyle22(widget.navigateToNext, product, getCardBackground(index));
//       case 23:
//         return CardStyle23(widget.navigateToNext, product, getCardBackground(index));
//       case 24:
//         return CardStyle24(widget.navigateToNext, product, getCardBackground(index));
//       case 25:
//         return CardStyle25(widget.navigateToNext, product, getCardBackground(index));
//       case 26:
//         return CardStyle26(widget.navigateToNext, product, getCardBackground(index));
//       case 27:
//         return CardStyle27(widget.navigateToNext, product, getCardBackground(index));
//       default:
//         return CardStyleNew1(widget.navigateToNext, product, getCardBackground(index));
//     }
//   }
// }
//
// int cardColorindex=0;
//
// Color getCardBackground(int index) {
//   Color tempColor = AppStyles.cardColors[cardColorindex];
//   cardColorindex++;
//   if (cardColorindex == 4) cardColorindex= 0;
//   return tempColor;
// }
//
// typedef ChoiceChipsCallback = void Function(List<Variations> variations);
//
// class ChoiceChips extends StatefulWidget {
//   final List<Variations>? chipName;
//   final ChoiceChipsCallback? choiceChipsCallback;
//   Variations? selectedVariation;
//
//   ChoiceChips(
//       {Key? key,
//       this.chipName,
//       this.choiceChipsCallback,
//       this.selectedVariation})
//       : super(key: key);
//
//   @override
//   _ChoiceChipsState createState() => _ChoiceChipsState();
// }
//
// class _ChoiceChipsState extends State<ChoiceChips> {
//   List<bool> selections = [];
//   List<Variations> selectedVariations = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < widget.chipName!.length; i++) {
//       selections.add(false);
//     }
//   }
//
//   _buildChoiceList() {
//     List<Widget> choices = [];
//     widget.chipName?.asMap().forEach((index, item) {
//       choices.add(Container(
//         child: ChoiceChip(
//           backgroundColor: Colors.transparent,
//           label: Text(item.detail!.first.name!),
//           labelStyle: TextStyle(
//               color: selections[index]
//                   ?  Theme.of(context).primaryColor
//                   : Theme.of(context).brightness == Brightness.dark
//                       ? AppStyles.COLOR_GREY_DARK
//                       : AppStyles.COLOR_GREY_LIGHT),
//           // shape: RoundedRectangleBorder(
//           //   side: BorderSide(
//           //       color: selections[index]
//           //           ? Colors.transparent
//           //           : Theme.of(context).brightness == Brightness.dark
//           //               ? AppStyles.COLOR_GREY_DARK
//           //               : AppStyles.COLOR_GREY_LIGHT,
//           //       width: 1),
//           //   borderRadius: BorderRadius.circular(5),
//           // ),
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//                 color: selections[index] ? Theme.of(context).primaryColor : Colors.grey,
//                 width: 1
//             ),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           selectedColor: Colors.transparent,
//           selected: selections[index],
//           onSelected: (selected) {
//             setState(() {
//               selections[index] = !selections[index];
//               selectedVariations = [];
//               for (int i = 0; i < selections.length; i++) {
//                 if (selections[i]) {
//                   selectedVariations.add(widget.chipName![i]);
//                 } else {
//                   selectedVariations.remove(widget.chipName![i]);
//                 }
//               }
//               widget.choiceChipsCallback!(selectedVariations);
//             });
//           },
//         ),
//       ));
//     });
//     return choices;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 5.0,
//       runSpacing: 3.0,
//       children: _buildChoiceList(),
//     );
//   }
// }
//
// class FilterDrawer extends StatefulWidget {
//   const FilterDrawer({Key? key}) : super(key: key);
//
//   @override
//   _FilterDrawerState createState() => _FilterDrawerState();
// }
//
// class _FilterDrawerState extends State<FilterDrawer> {
//   RangeValues? values = const RangeValues(1, 1000000);
//   RangeLabels? labels = const RangeLabels('\$1', "\$1000000");
//   List<FiltersData>? selectedFilters = [];
//   String? selectedIds;
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           const SizedBox(height: 24,),
//           SizedBox(
//               height: 56,
//               width: double.maxFinite,
//               child: Row(children: [
//                 Expanded(
//                   child: Padding(
//                       padding: const EdgeInsets.all(16.0), child: Text(AppLocalizations.of(context)!.translate( "Filters")!)),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.cancel_outlined))
//               ])),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.all(0),
//                         child: Text(AppLocalizations.of(context)!.translate("Product Price")!)),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 0, right: 0),
//                       child: Row(
//                         children: [
//                           Text(
//                             "\$${values!.start.toStringAsFixed(2)}",
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                           Expanded(child: Container()),
//                           Text(
//                             "\$${values!.end.toStringAsFixed(2)}",
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // color:AppConfig.APP_BAR_COLOR == 2 ?
//                     // Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
//                     // Colors.white,
//                     RangeSlider(
//                         activeColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
//                         min: 1,
//                         max: 1000000,
//                         divisions: 50,
//                         values: values!,
//                         labels: labels,
//                         onChanged: (value) {
//                           setState(() {
//                             values = value;
//                             labels = RangeLabels(
//                                 "${value.start.round().toString()}\$",
//                                 "${value.end.round.toString()}\$");
//                           });
//                         }),
//                     BlocBuilder<FiltersBloc, FiltersState>(
//                       builder: (context, state) {
//                         if (state is FiltersLoaded) {
//                           return Center(
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: state.filtersResponse?.data?.length,
//                               itemBuilder: (context, index) => Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     height: 4.0,
//                                   ),
//                                   Text(state.filtersResponse!.data![index].detail
//                                       !.first.name!),
//                                   const SizedBox(
//                                     height: 12.0,
//                                   ),
//                                   ChoiceChips(
//                                     selectedVariation: null,
//                                     chipName: state
//                                         .filtersResponse?.data![index].variations,
//                                     choiceChipsCallback: (variation) {
//                                       FiltersData data = FiltersData();
//                                       data.attributeId = state
//                                           .filtersResponse?.data![index].attributeId;
//                                       data.variations = variation;
//                                       if (selectedFilters!.isEmpty) {
//                                         selectedFilters!.add(data);
//                                       } else {
//                                         for (int i = 0;
//                                         i < selectedFilters!.length;
//                                         i++) {
//                                           if (selectedFilters![i].attributeId ==
//                                               state.filtersResponse?.data![index]
//                                                   .attributeId) {
//                                             selectedFilters!.removeAt(i);
//                                           }
//                                         }
//                                         selectedFilters!.add(data);
//                                       }
//
//                                       selectedIds = "";
//
//                                       for (int i = 0;
//                                       i < selectedFilters!.length;
//                                       i++) {
//                                         for (int j = 0;
//                                         j <
//                                             selectedFilters![i]
//                                                 .variations
//                                                 !.length;
//                                         j++) {
//                                           selectedIds = "${selectedFilters![i]
//                                               .variations![j]
//                                               .id},";
//                                         }
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         } else {
//                           return Center(
//                             child: Container(
//                                 alignment: Alignment.topCenter,
//                                 margin: EdgeInsets.only(top: 20),
//                                 child: CircularProgressIndicator(
//                                   color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
//                                 )
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 2, // 60% of space => (6/(6 + 4))
//                   child: SizedBox(
//                       height: 35,
//                       child: ElevatedButton(
//                           style: ButtonStyle(
//                             //  backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),
//                                   backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
//                               //  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffCDD2D3)),
//                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(40.0),
//                                   )
//                               )
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text(AppLocalizations.of(context)!.translate("Reset")!))),
//                 ),
//                 const SizedBox(
//                   width: 12.0,
//                 ),
//                 Expanded(
//                     flex: 4, // 40% of space
//                     child: SizedBox(
//                         height: 35,
//                         child: ElevatedButton(
//                             style: ButtonStyle(
//                                // backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),
//                                   backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
//                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(40.0),
//                                     )
//                                 )
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                               print("selectionIDS:  $selectedIds");
//                               BlocProvider.of<ProductsByCatBloc>(context)
//                                   .add(FiltersChanged(selectedIds!));
//                             }, child: Text(
//                           //  AppLocalizations.of(context)!.translate("Apply"
//                           "Apply",style: TextStyle(color:AppConfig.APP_BAR_COLOR == 2 ?
//                         Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white :
//                         Colors.white,),
//                             ))))
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
