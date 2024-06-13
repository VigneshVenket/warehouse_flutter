import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/reviews/reviews_bloc.dart';
import '../../tweaks/app_localization.dart';
import '../detail_screen.dart';
class CardStyleFav extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;

  const CardStyleFav(this.navigateToNext, this.product);

  @override
  _CardStyleFavState createState() => _CardStyleFavState();
}

class _CardStyleFavState extends State<CardStyleFav> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.navigateToNext(
          BlocProvider(
              create: (context) => DetailScreenBloc(RealCartRepo(), RealProductsRepo()),
              child: ProductDetailScreen(widget.product, widget.navigateToNext)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
          child: Card(
            color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(0, 0, 0, 1): Color.fromRGBO(255, 255, 255, 1),
            margin: EdgeInsets.zero,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                            // width: double.maxFinite,
                            height: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${ApiProvider.imgMediumUrlString}${widget.product.productGallary!.gallaryName!}"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            // child:
                            // CachedNetworkImage(
                            //   imageUrl: ApiProvider.imgMediumUrlString + widget.product.productGallary!.gallaryName!,
                            //   fit: BoxFit.fill,
                            //   progressIndicatorBuilder:
                            //       (context, url, downloadProgress) =>
                            //           Center(
                            //             child: CircularProgressIndicator(
                            //                 color: Color.fromRGBO(255, 76, 59, 1),
                            //                 value: downloadProgress.progress),
                            //           ),
                            //   errorWidget:
                            //       (context, url, error) =>
                            //        Icon(Icons.error,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Color.fromRGBO(255, 76, 59, 1)),
                            // ),
                        ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:50,
                                child: Text(
                                  widget.product.detail!.first.title!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.gothicA1(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                  ),

                                ),
                              ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppData.currency!.code !+ double.parse(widget.product.productDiscountPrice.toString()).toStringAsFixed(2),
                                          style: GoogleFonts.gothicA1(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            color: Color(0xFFFF4C3B),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Text(
                                          AppData.currency!.code !+ double.parse(widget.product.productPrice.toString()).toStringAsFixed(2),
                                          style: GoogleFonts.gothicA1(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              decoration: TextDecoration
                                                  .lineThrough,
                                              color:Theme.of(context).brightness ==
                                                  Brightness.dark?Color.fromRGBO(255, 255, 255, 1): Color.fromRGBO(0, 0, 0, 1)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,size: 18,color: Color.fromRGBO(255, 76, 59, 1),),
                                        SizedBox(width:2,),
                                        Text(widget.product.productRating!=null?"${widget.product.productRating!.toStringAsFixed(1)}":"0",
                                          style: TextStyle(
                                              fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color:Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                                            Color.fromRGBO(112,112, 112, 1)
                                        ),)
                                      ],
                                    )
                                  ],
                                ),
                                // child: (widget.product.productDiscountPrice != 0) ?
                                // Wrap(
                                //   crossAxisAlignment: WrapCrossAlignment.center,
                                //   children: [
                                //     Text(
                                //       AppData.currency!.code !+
                                //           double.parse(widget.product.productDiscountPrice.toString()).toStringAsFixed(2),
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w700,
                                //           color:Theme.of(context).brightness ==
                                //               Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                                //           Color.fromRGBO(0, 0, 0, 1)
                                //       ),
                                //     ),
                                //     const SizedBox(width: 8),
                                //     Text(
                                //       AppData.currency!.code !+ double.parse(widget.product.productPrice.toString()).toStringAsFixed(2),
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w700,
                                //           color:Theme.of(context).brightness ==
                                //               Brightness.dark?Color.fromRGBO(255, 255, 255, 1): Color.fromRGBO(0, 0, 0, 1),
                                //         decoration: TextDecoration.lineThrough
                                //       ),
                                //     ),
                                //   ],
                                // ) : Text(
                                //   AppData.currency!.code !+ double.parse(widget.product.productPrice.toString()).toStringAsFixed(2),
                                //   style: TextStyle(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w700,
                                //       color:Theme.of(context).brightness ==
                                //           Brightness.dark?Color.fromRGBO(255, 255, 255, 1): Color.fromRGBO(0, 0, 0, 1)
                                //   ),
                                // ),
                              ),
        /*
                              (widget.product.productType ==
                                      AppConstants.PRODUCT_TYPE_SIMPLE)
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "\$" +
                                                double.parse(widget
                                                        .product.productPrice
                                                        .toString())
                                                    .toStringAsFixed(2),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          SizedBox(width: 8),
                                          if (widget
                                                  .product.productDiscountPrice !=
                                              0)
                                            Text(
                                              "\$" +
                                                  double.parse(widget.product
                                                          .productDiscountPrice
                                                          .toString())
                                                      .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                            ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                          text: "\$" +
                                              double.tryParse(widget
                                                      .product
                                                      .productCombination
                                                      .first
                                                      .price
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        TextSpan(text: " - "),
                                        TextSpan(
                                          text: "\$" +
                                              double.tryParse(widget
                                                      .product
                                                      .productCombination
                                                      .last
                                                      .price
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ])),
                                    ),
        */
                              // SizedBox(
                              //   width: double.maxFinite,
                              //   child: ElevatedButton(
                              //       style: ButtonStyle(
                              //         backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                              //         elevation: MaterialStateProperty.all(0),
                              //       ),
                              //       onPressed: () {
                              //         for (int i = 0;
                              //             i < AppData.wishlistData!.length;
                              //             i++) {
                              //           if (AppData.wishlistData![i].productId ==
                              //               widget.product.productId) {
                              //             setState(() {
                              //               BlocProvider.of<WishlistBloc>(context)
                              //                   .add(UnLikeProduct(AppData
                              //                       .wishlistData![i].wishlist!));
                              //               print("unlike ${UnLikeProduct}");
                              //             });
                              //             break;
                              //           }
                              //         }
                              //       },
                              //       child: Text(
                              //         AppLocalizations.of(context)!.translate("Remove")!,
                              //         style: const TextStyle(fontSize: 12),
                              //       )),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Container(
                      //     height: 30,
                      //     width: 30,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: Theme.of(context).primaryColor,
                      //     ),
                      //     child: const Center(
                      //       child: Text("-67%",
                      //           style:
                      //               TextStyle(color: Colors.white, fontSize: 8)),
                      //     )),
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              color: Theme.of(context).brightness==Brightness.dark?
                                      Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(240, 240, 240,1)
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (AppData.user != null) {
                                  if (checkForWishlist(widget.product.productId!)) {
                                    for (int i = 0;
                                        i < AppData.wishlistData!.length; i++) {
                                      if (AppData.wishlistData![i].productId == widget.product.productId) {
                                        setState(() {
                                          BlocProvider.of<WishlistBloc>(context).add(UnLikeProduct(AppData.wishlistData![i].wishlist!));

                                        });
                                        break;
                                      }
                                    }
                                  } else {
                                    // BlocProvider.of<WishlistBloc>(context).add(LikeProduct(widget.product.productId!));
        /*
                                                                  GetWishlistOnStartData
                                                                  data =
                                                                  GetWishlistOnStartData();
                                                                  data.productId = state
                                                                      .products[
                                                                  index]
                                                                      .productId;
                                                                  data.customerId =
                                                                      AppData.user
                                                                          .id;
                                                                  data.wishlist =
                                                                  0;
                                                                  setState(() {
                                                                    AppData
                                                                        .wishlistData
                                                                        .add(data);
                                                                  });
        */
                                  }
                                }
                              },
                              child: IconTheme(
                                  data: const IconThemeData(color: Colors.white),
                                  child: Icon(
                                    (checkForWishlist(widget.product.productId!))
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 18,
                                    color: Color.fromRGBO(255, 76, 59, 1),
                                  )
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkForWishlist(int productId) {
    for (int i = 0; i < AppData.wishlistData!.length; i++) {
      if (productId == AppData.wishlistData![i].productId) {
        return true;
      }
    }
    return false;
  }
}
