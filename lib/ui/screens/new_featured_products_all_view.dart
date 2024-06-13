import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/filters/filters_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/models/filters_data.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

import '../../api/api_provider.dart';
import '../../blocs/detail_screen/detail_screen_bloc.dart';
import '../../blocs/featured_products/featured_products_bloc.dart';
import '../../blocs/new_arrival_blocs/new_arrival_product_bloc.dart';
import '../../constants/app_config.dart';
import '../../repos/cart_repo.dart';
import '../../repos/products_repo.dart';
import '../../tweaks/app_localization.dart';
import '../detail_screen.dart';

class ViewAllScreen extends StatefulWidget {
  final String type;
  final Function(Widget widget) navigateToNext;

  const ViewAllScreen(this.type, this.navigateToNext, {super.key});

  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
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
    _scrollController.addListener(_onScroll);
    getProduct(context, widget.type);
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

    return
      Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      key: _scaffoldKey,
      //endDrawer: const FilterDrawer(),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.type.toString(),
          style:GoogleFonts.gothicA1(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(18, 18, 18, 1),
              fontSize: 18,
              fontWeight: FontWeight.w800),
          // style: GoogleFonts.spaceGrotesk(
          //     color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        leading: InkWell(
          child:  Icon(Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).brightness == Brightness.dark
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromRGBO(18, 18, 18, 1),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
        elevation: 0.0,
      ),
      body: ListView(
        //mainAxisSize: MainAxisSize.min,
        physics: const BouncingScrollPhysics(),
        children: [
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Return the FilterDrawer widget
                        return FilterDrawer(
                          navigateToNext: widget.navigateToNext,
                        );
                      },
                    );
                  },
                  icon: Transform.rotate(
                    angle: 3.14 / 2,
                    child:Icon(Icons.tune,color:Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                    Color.fromRGBO(112,112, 112, 1),),
                  ),
                  label: Text(
                    "Filter",
                    style: GoogleFonts.gothicA1(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color:Theme.of(context).brightness ==
                          Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                      Color.fromRGBO(112,112, 112, 1),
                    ),
                  ),
                ),
              ),
              // Directionality(
              //   textDirection: TextDirection.rtl,
              //   child: TextButton.icon(
              //     onPressed: () {
              //       showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return Dialog(
              //               surfaceTintColor: Colors.white,
              //               backgroundColor: Colors.white,
              //               insetPadding:
              //                   const EdgeInsets.symmetric(horizontal: 35),
              //               child: Container(
              //                 padding: const EdgeInsets.symmetric(
              //                     horizontal: 30, vertical: 20),
              //                 child: Wrap(
              //                   children: [
              //                     sorByItemWidget(1, "Best match"),
              //                     const Divider(
              //                       height: 1,
              //                     ),
              //                     sorByItemWidget(2, "Price: low to high"),
              //                     const Divider(
              //                       height: 1,
              //                     ),
              //                     sorByItemWidget(3, "Price: high to low"),
              //                     const Divider(
              //                       height: 1,
              //                     ),
              //                     sorByItemWidget(4, "Newest"),
              //                     const Divider(
              //                       height: 1,
              //                     ),
              //                     sorByItemWidget(5, "Customer rating"),
              //                     const Divider(
              //                       height: 1,
              //                     ),
              //                     sorByItemWidget(6, "Most popular"),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           });
              //     },
              //     label: Text(
              //       "Sorting By",
              //       style: GoogleFonts.lato(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w600,
              //         color: const Color(0xFF707070),
              //       ),
              //     ),
              //     icon: const Icon(Icons.keyboard_arrow_down_rounded),
              //   ),
              // )
            ],
          ),
          SizedBox(height: 10,),
          // widget.type == "New Arrival" ? chipList() : const SizedBox.shrink(),
          widget.type == "New Arrival"
              ? BlocBuilder<NewArrivalProductBloc, NewArrivalProductsState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case NewArrivalProductsStatus.success:
                        isLoadingMore = false;
                        if (state.products!.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context).translate("Empty"),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemCount: state.products!.length,
                                  itemBuilder: (context, index) {
                                    return productCard(state.products![index]);
                                  },
                                ),
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
                                      color: Color.fromRGBO(255, 76, 55, 1),
                                      // color: Theme.of(context).brightness ==
                                      //         Brightness.dark
                                      //     ? Colors.white
                                      //     : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }
                      case NewArrivalProductsStatus.failure:
                        return Text(
                            AppLocalizations.of(context).translate("Error"));
                      default:
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(255, 76, 55, 1),
                            // color: Theme.of(context).brightness ==
                            //         Brightness.dark
                            //     ? Colors.white
                            //     : Theme.of(context).primaryColor,
                            //  backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                          ),
                        );
                    }
                  },
                )
              :
          BlocBuilder<FeaturedProductsBloc, FeaturedProductsState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case FeaturedProductsStatus.success:
                        isLoadingMore = false;
                        if (state.products!.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context).translate("Empty"),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemCount: state.products!.length,
                                  itemBuilder: (context, index) {
                                    return productCard(state.products![index]);
                                  },
                                ),
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
                                      color: Color.fromRGBO(255, 76, 55, 1),
                                      // color: Theme.of(context).brightness ==
                                      //         Brightness.dark
                                      //     ? Colors.white
                                      //     : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }
                      case FeaturedProductsStatus.failure:
                        return Text(
                            AppLocalizations.of(context).translate("Error"));
                      default:
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(255, 76, 55, 1),
                            // color: Theme.of(context).brightness ==
                            //         Brightness.dark
                            //     ? Colors.white
                            //     : Theme.of(context).primaryColor,
                            //  backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                          ),
                        );
                    }
                  },
                )
        ],
      ),
    );
  }

  int selectedSortId = 1;

  Widget sorByItemWidget(int id, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSortId = id;
        });
        debugPrint("sorting $title");
        // getProductBySorting(context, title);
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
              style: GoogleFonts.gothicA1(
                  color: Theme.of(context).brightness ==
                      Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                  fontSize: 14, fontWeight: FontWeight.w500),
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
                      // style: GoogleFonts.lato(
                      //     color: Theme.of(context).brightness ==
                      //         Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                      //     fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 6,),
                    Text(
                      "${AppData.currency!.code}${product.productPrice}",
                      style:GoogleFonts.gothicA1(
                        color: Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                        fontSize: 12, fontWeight: FontWeight.w600, decoration: TextDecoration
                          .lineThrough,),
                    ),
                  ],
                ),
                // Text(
                //   "${AppData.currency!.code}${product.productPrice}",
                //   style: GoogleFonts.lato(
                //       color: Theme.of(context).brightness ==
                //           Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                //       fontSize: 12, fontWeight: FontWeight.w500),
                // ),
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
                      style:GoogleFonts.gothicA1(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:Theme.of(context).brightness ==
                              Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                          Color.fromRGBO(112,112, 112, 1)),
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
      getProduct(context, widget.type);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  getProduct(context, type) {
    if (type == "New Arrival") {
      BlocProvider.of<NewArrivalProductBloc>(context)
          .add(const GetNewArrivalProducts(0));
    } else {
      BlocProvider.of<FeaturedProductsBloc>(context)
          .add(const GetFeaturedProducts());
    }
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

  chipList() {
    return SizedBox(
      height: 50,
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
        if (state is CategoriesLoaded) {
          final List<Category> parentCategories =
              getParentCategories(state.categoriesResponse.data!);
          return ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 16),
            children: parentCategories
                .map((category) => _buildChip(category))
                .toList(),
          );
        } else if (state is CategoriesError) {
          return Text(state.error);
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).primaryColor,
            ),
          );
        }
      }),
    );
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

  int selectedId = 1;

  Widget _buildChip(Category category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedId = category.id!;
            BlocProvider.of<NewArrivalProductBloc>(context)
                .add(CategoryChanged(category.id!));
          });
        },
        child: Chip(
          side: const BorderSide(width: 2, color: Colors.black),
          backgroundColor:
              selectedId == category.id ? Colors.black : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          label: Text(
            category.name!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selectedId == category.id ? Colors.white : Colors.black,
            ),
          ),
          padding: const EdgeInsets.all(5.0),
        ),
      ),
    );
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
