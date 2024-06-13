import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/featured_products/featured_products_bloc.dart';
import 'package:flutter_kundol/blocs/get_currencies/get_currency_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/blocs/super_deal_products/super_deal_products_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/get_currency_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/DemoSettingsScreen.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment.dart';
import 'package:flutter_kundol/ui/fav_fragment.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_2.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_3.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_4.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_5.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_6.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_1.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_2.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_5.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_7.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_9.dart';
import 'package:flutter_kundol/ui/me_fragment.dart';
import 'package:flutter_kundol/ui/my_account.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';
import 'package:flutter_kundol/ui/widgets/bottom_navigation.dart';
import 'package:flutter_kundol/blocs/top_selling_products/top_selling_products_bloc.dart';

import '../blocs/get_languages/get_language_bloc.dart';
import '../blocs/products_search/products_search_bloc.dart';
import '../constants/app_cart.dart';
import '../repos/get_language_repo.dart';
import '../tweaks/app_localization.dart';
import 'fragments/home_fragment_3.dart';
import 'fragments/home_fragment_4.dart';
import 'fragments/home_fragment_6.dart';
import 'fragments/home_fragment_8.dart';
import 'search_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];


  @override
  void initState() {
    super.initState();
    AppBadge().init();
    BlocProvider.of<WishlistBloc>(context).add(const GetWishlistOnStart());
  }
  final keyCounter = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // final isFirstRouteInCurrentTab = !await _navigatorKeys[_selectedIndex].currentState!.maybePop();

        if (_selectedIndex != 0) {

          setState(() {
            _selectedIndex = 0;
          });

          return false;
        } else {
          return true;
        }
      },
      child: BlocListener<WishlistBloc, WishlistState>(
        listener: (BuildContext context, state) {
          if (state is WishlistLoaded) {
            setState(() {
              AppData.wishlistData = state.wishlistResponse.data!;
            });
          }
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).brightness ==
                Brightness.dark?const Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
            // key: scaffoldKey1,
            // drawer: Drawer(
            //   child: Column(children: [
            //     SafeArea(
            //       child: Container(
            //
            //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //           alignment: Alignment.centerLeft,
            //           width: double.maxFinite,
            //           child: Text(
            //             AppLocalizations.of(context).translate("Welcome Guest"),
            //           )),
            //     ),
            //     BlocBuilder<CategoriesBloc, CategoriesState>(
            //       builder: (context, state) {
            //         if (state is CategoriesLoaded) {
            //           List<Category> parentCategories =
            //           getParentCategories(state.categoriesResponse.data!);
            //           return Expanded(
            //             child: ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: parentCategories.length,
            //               itemBuilder: (context, i) {
            //                 List<Category> childData = getChildCategories(
            //                     state.categoriesResponse.data!,
            //                     parentCategories[i].id!);
            //                 return (childData.isNotEmpty)
            //                     ? ExpansionTile(
            //                   title: Text(
            //                     parentCategories[i].name!,
            //                     style: const TextStyle(fontSize: 12.0),
            //                   ),
            //                   children: <Widget>[
            //                     Column(
            //                       children:
            //                       _buildExpandableContent(childData),
            //                     ),
            //                   ],
            //                 )
            //                     : ListTile(
            //                     onTap: () => _navigateToNext(BlocProvider(
            //                         create: (BuildContext context) {
            //                           return ProductsByCatBloc(
            //                               RealProductsRepo(),
            //                               BlocProvider.of<CategoriesBloc>(
            //                                   context),
            //                               parentCategories[i].id,
            //                               "id",
            //                               "ASC",
            //                               "");
            //                         },
            //                         child: ShopScreen(parentCategories[i],
            //                             _navigateToNext))),
            //                     title: Text(
            //                       parentCategories[i].name!,
            //                       style: const TextStyle(fontSize: 12.0),
            //                     ));
            //               },
            //             ),
            //           );
            //         } else if (state is CategoriesError) {
            //           return Text(state.error);
            //         } else {
            //           return Center(
            //             child: CircularProgressIndicator(
            //               color: Colors.white,
            //               backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //   ]),
            // ),
            body: Stack(
              children: [
                _buildOffstageNavigator(0),
                _buildOffstageNavigator(1),
                _buildOffstageNavigator(2),
                _buildOffstageNavigator(3),
              ],
            ),
            bottomNavigationBar: MyBottomNavigation(_selectCurrentItem, _selectedIndex),
            floatingActionButton: AppConfig.IS_DEMO_ENABlED
                ? AppConfig.APP_BAR_COLOR == 2 ?FloatingActionButton(
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColor : Theme.of(context).primaryColor,
              onPressed: () => _navigateToNext(
                  MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (BuildContext context) {
                            return GetLanguageBloc(
                                RealGetLanguageRepo()
                            );
                          },
                        ),
                        BlocProvider(
                          create: (BuildContext context) {
                            return GetCurrenciesBloc(
                                RealGetCurrencyRepo()
                            );
                          },
                        ),
                      ],
                      child: DemoSettingsScreen()
                  )
              ),
              child: Icon(Icons.settings,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white),
            ):
            AppConfig.IS_DEMO_ENABlED
                ? AppConfig.APP_BAR_COLOR == 1 ?FloatingActionButton(
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
              onPressed: () => _navigateToNext(
                  MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (BuildContext context) {
                            return GetLanguageBloc(
                                RealGetLanguageRepo()
                            );
                          },
                        ),
                        BlocProvider(
                          create: (BuildContext context) {
                            return GetCurrenciesBloc(
                                RealGetCurrencyRepo()
                            );
                          },
                        ),
                      ],
                      child: DemoSettingsScreen()
                  )
              ),

              child: Icon(Icons.settings,color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
            ):
            AppConfig.IS_DEMO_ENABlED
                ? AppConfig.APP_BAR_COLOR == 3 ?FloatingActionButton(
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
              onPressed: () => _navigateToNext(


                  MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (BuildContext context) {
                            return GetLanguageBloc(
                                RealGetLanguageRepo()
                            );
                          },
                        ),
                        BlocProvider(
                          create: (BuildContext context) {
                            return GetCurrenciesBloc(
                                RealGetCurrencyRepo()
                            );
                          },
                        ),
                      ],
                      child: DemoSettingsScreen()
                  )
              ),
              child: Icon(Icons.settings,color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
            ): null:null:null:null
        ),
      ),
    );
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

  void _selectCurrentItem(int position) {

    if (position == 2) {
      print("api hitted");
      BlocProvider.of<WishlistProductsBloc>(context).add(RefreshWishlistProducts());
    }
    setState(() {
      _selectedIndex = position;
    });

  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _homeScreenRouteBuilder(context, index);
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }

  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        )).then((val)=>setState(() {
    }));
  }

  _openHomeDrawer() {
    scaffoldKey1.currentState?.openDrawer();
  }

  Map<String, WidgetBuilder> _homeScreenRouteBuilder(
      BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          getDefaultHome(),
          MultiBlocProvider(
            providers:[
              BlocProvider(
                  create: (context) => ProductsSearchBloc(RealProductsRepo())),
            ],
            child: SearchScreen(_navigateToNext),
          ),
          // getDefaultCategory(),
          FavFragment(_openHomeDrawer, _navigateToNext),
          // MeFragment(_navigateToNext),
          MyAccount(_navigateToNext)
        ].elementAt(index);
      },
    };
  }

  Widget getDefaultHome() {
    switch (int.parse(
        AppData.settingsResponse!.getKeyValue(SettingsResponse.HOME_STYLE))) {
      case 1:
        return MultiBlocProvider(providers:[
          BlocProvider(
              create: (context) => FeaturedProductsBloc(RealProductsRepo())),
        ],
          child: HomeFragment1(_navigateToNext, _openHomeDrawer),
        );

      case 2:
        return HomeFragment2(_navigateToNext, _openHomeDrawer);
      case 3:
        return BlocProvider(
            create: (BuildContext context) =>
                TopSellingProductsBloc(RealProductsRepo()),
            child: HomeFragment3(_navigateToNext, _openHomeDrawer));
      case 4:
        return BlocProvider(
            create: (BuildContext context) =>
                TopSellingProductsBloc(RealProductsRepo()),
            child: HomeFragment4(_navigateToNext, _openHomeDrawer));
      case 5:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => FeaturedProductsBloc(RealProductsRepo())),
        ], child: HomeFragment5(_navigateToNext, _openHomeDrawer));
      case 6:
        return HomeFragment6(_navigateToNext, _openHomeDrawer);
      case 7:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo()))
        ], child: HomeFragment7(_navigateToNext, _openHomeDrawer));
      case 8:
        return HomeFragment8(_navigateToNext, _openHomeDrawer);
      case 9:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => FeaturedProductsBloc(RealProductsRepo())),
        ], child: HomeFragment9(_navigateToNext, _openHomeDrawer));
      default:
        return HomeFragment1(_navigateToNext, _openHomeDrawer);
    }
  }

  Widget getDefaultCategory() {
    debugPrint("cate ${int.parse(AppData.settingsResponse
    !.getKeyValue(SettingsResponse.CATEGORY_STYLE))}");
    switch (int.parse(AppData.settingsResponse!.getKeyValue(SettingsResponse.CATEGORY_STYLE))) {
      case 1:
        return CategoryFragment(_navigateToNext, _openHomeDrawer);
      case 2:
        return CategoryFragment2(_navigateToNext, _openHomeDrawer);
      case 3:
        return CategoryFragment3(_navigateToNext, _openHomeDrawer);
      case 4:
        return CategoryFragment4(_navigateToNext, _openHomeDrawer);
      case 5:
        return CategoryFragment5(_navigateToNext, _openHomeDrawer);
      case 6:
        return CategoryFragment6(_navigateToNext, _openHomeDrawer);
      default:
        return CategoryFragment(_navigateToNext, _openHomeDrawer);
    }
  }

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
}
