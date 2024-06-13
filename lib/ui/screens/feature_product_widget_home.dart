import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api_provider.dart';
import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/detail_screen/detail_screen_bloc.dart';

import '../../blocs/featured_products/featured_products_bloc.dart';
import '../../blocs/products/products_bloc.dart';
import '../../blocs/products_by_category/products_by_cat_bloc.dart';
import '../../models/products/product.dart';
import '../../repos/cart_repo.dart';
import '../../repos/products_repo.dart';
import '../../tweaks/app_localization.dart';
import '../detail_screen.dart';
import 'new_featured_products_all_view.dart';

class FeaturedProductWidget extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const FeaturedProductWidget(this.navigateToNext, {super.key});

  @override
  State<FeaturedProductWidget> createState() => _FeaturedProductWidgetState();
}

class _FeaturedProductWidgetState extends State<FeaturedProductWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getProduct(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Products",
              maxLines: 4,

              style: GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color:Theme.of(context).brightness ==
                      Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                  onPressed: () {
                    widget.navigateToNext(
                        BlocProvider(
                        create: (BuildContext context) {
                          return FeaturedProductsBloc(
                              RealProductsRepo());
                        },
                        child: ViewAllScreen("Featured Products",widget.navigateToNext))
                    );
                    BlocProvider(
                        create: (context) =>
                            FeaturedProductsBloc(RealProductsRepo()),
                        child: ViewAllScreen(
                            "Featured Products", widget.navigateToNext)
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color:Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                    Color.fromRGBO(112,112, 112, 1),
                    size: 20,
                  ),
                  label: Text(
                    "View All",
                    maxLines: 4,
                    style: GoogleFonts.gothicA1(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                        Color.fromRGBO(112,112, 112, 1)),
                  ),
                ))
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.27,
          width: double.infinity,
          child: BlocBuilder<FeaturedProductsBloc, FeaturedProductsState>(
              builder: (context, state) {
            switch (state.status) {
              case FeaturedProductsStatus.success:
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    // padding: const EdgeInsets.only(left: 16),
                    itemCount: state.products!.length,
                    itemBuilder: (context, index) {
                      return productCard(state.products![index]);
                    });
              case FeaturedProductsStatus.failure:
                return Text(AppLocalizations.of(context)!.translate("Error")!);
              // TODO: Handle this case.
              default:
                return Center(
                  child: CircularProgressIndicator(
                      color:Color.fromRGBO(255, 76, 59, 1)
                    // color: Theme.of(context).brightness == Brightness.dark
                    //     ? Colors.white
                    //     : Theme.of(context).primaryColor,
                    // backgroundColor:
                    //     Theme.of(context).brightness == Brightness.dark
                    //         ? Theme.of(context).primaryColorLight
                    //         : Theme.of(context).primaryColor,
                  ),
                );
            }
          }),
        )
      ],
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
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: NetworkImage(
                      "${ApiProvider.imgMediumUrlString}${product.productGallary!.gallaryName!}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${product.detail!.first.title}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.gothicA1(
                  color: Theme.of(context).brightness ==
                      Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
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
                            style: GoogleFonts.gothicA1(
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
                            style: GoogleFonts.gothicA1(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color:Theme.of(context).brightness ==
                                    Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                                Color.fromRGBO(112,112, 112, 1)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
