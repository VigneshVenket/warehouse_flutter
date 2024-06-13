import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/ui/settings_new.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';
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
import 'package:flutter_kundol/ui/widgets/category_widget_search_screen.dart';
import 'package:flutter_kundol/ui/widgets/search_featured_products.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/api_provider.dart';
import '../blocs/detail_screen/detail_screen_bloc.dart';
import '../blocs/featured_products/featured_products_bloc.dart';
import '../constants/app_config.dart';
import '../repos/cart_repo.dart';
import '../repos/products_repo.dart';
import '../tweaks/app_localization.dart';
import 'detail_screen.dart';
import 'screens/filter_screen.dart';
import 'screens/new_featured_products_all_view.dart';

class SearchScreen extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;

  const SearchScreen(this.navigateToNext, {super.key});

  @override
  ShippingState createState() => ShippingState();
}

class ShippingState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Theme.of(context).brightness == Brightness.dark
      //       ? Color.fromRGBO(18, 18, 18, 1)
      //       : Color.fromRGBO(255, 255, 255, 1),
      //   title: Text(
      //     AppLocalizations.of(context).translate("Search"),
      //     style: GoogleFonts.gothicA1(
      //         color: Theme.of(context).brightness == Brightness.dark
      //             ? Color.fromRGBO(255, 255, 255, 1)
      //             : Color.fromRGBO(18, 18, 18, 1),
      //         fontSize: 18,
      //         fontWeight: FontWeight.w800),
      //     // style: GoogleFonts.spaceGrotesk(
      //     //     color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
      //   ),
      //   elevation: 0.0,
      // ),
      body:Padding(
        padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.08),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Divider(height: 1),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          BlocProvider.of<ProductsSearchBloc>(context)
                              .add(GetSearchProducts(value));
                        }
                      },
                      textInputAction: TextInputAction.search,
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.gothicA1(),
                      cursorColor: Color.fromRGBO(255, 76, 59, 1),
                      decoration: InputDecoration(
                          hintText: "What are you looking for?",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                          filled: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 26,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(18, 18, 18, 1),
                          ),
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(18, 18, 18, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                          hintStyle:GoogleFonts.gothicA1(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Color.fromRGBO(160, 160, 160, 1)
                                      : Color.fromRGBO(112, 112, 112, 1))),
                    ),
                  ),
                  /* InkWell(
                    onTap: (){
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilterDrawer(
                                navigateToNext: widget.navigateToNext,
                                isFromSearch: true),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFF4C3B)),
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                      ),
                    ),
                  )*/
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                          isFromSearch: true,
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
            const SizedBox(
              height: 10,
            ),
            CategoryWidgetSearchScreen(widget.navigateToNext!),
            //chipList(),
            Expanded(
              child: BlocBuilder<ProductsSearchBloc, ProductsSearchState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ProductsSearchStatus.initial:
                      return BlocProvider(
                          create: (BuildContext context) {
                            return FeaturedProductsBloc(
                                RealProductsRepo());
                          },
                          child: SearchFeaturedProducts(widget.navigateToNext!));
                    case ProductsSearchStatus.success:
                      if (state.products!.isEmpty) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(18, 18, 18, 1)
                                : Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "No Products Found",
                                  style: GoogleFonts.gothicA1(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                Text(
                                  "Your search did not match any products",
                                  style:GoogleFonts.gothicA1(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(160, 160, 160, 1)
                                        : Color.fromRGBO(112, 112, 112, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: state.products?.length,
                            itemBuilder: (context, index) {
                              return productCard(state.products![index]);
                            },
                          ),
                        );
                      }
                    case ProductsSearchStatus.failure:
                      return Text(
                          AppLocalizations.of(context).translate("Error"));
                    case ProductsSearchStatus.loading:
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(255, 76, 59, 1),
                        ),
                      );
                    case null:
                      break;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(255, 76, 59, 1),
                    ),
                  );
                },
              ),
            )
          ],
        ),
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


  Widget productCard(Product product) {
    return InkWell(
      onTap: () {
        widget.navigateToNext!(
          BlocProvider(
              create: (context) =>
                  DetailScreenBloc(RealCartRepo(), RealProductsRepo()),
              child: ProductDetailScreen(product, widget.navigateToNext!)),
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
                      style:GoogleFonts.gothicA1(
                        color: Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                        fontSize: 12, fontWeight: FontWeight.w600, decoration: TextDecoration
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
                      style:GoogleFonts.gothicA1(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color.fromRGBO(160, 160, 160, 1)
                            : Color.fromRGBO(112, 112, 112, 1),
                      ),
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

}
