import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

import '../detail_screen.dart';

class CardStyle1 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;

  const CardStyle1(this.navigateToNext, this.product);

  @override
  _CardStyle1State createState() => _CardStyle1State();
}

class _CardStyle1State extends State<CardStyle1> {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
        child: new Card(
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(AppStyles.CARD_RADIUS),
                        child: (widget.product.productGallary == null)
                            ? Container()
                            : Container(
                          width: double.maxFinite,
                          child: CachedNetworkImage(
                            imageUrl: ApiProvider.imgMediumUrlString +
                                widget.product.productGallary!.gallaryName!,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.detail!.first.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            (widget.product.productType ==
                                AppConstants.PRODUCT_TYPE_SIMPLE)
                                ? Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  AppData.currency!.code !+
                                      double.parse(widget.product.productDiscountPrice
                                          .toString())
                                          .toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium?.copyWith(
                                      fontFamily: "MontserratSemiBold"),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  AppData.currency!.code !+
                                      double.parse(widget
                                          .product.productPrice
                                          .toString())
                                          .toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                      fontSize: 12.0,
                                      decoration:
                                      TextDecoration.lineThrough),
                                ),
                              ],
                            )
                                : Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppData.currency!.code !+
                                          double.tryParse(widget
                                              .product
                                              .productCombination
                                              !.first
                                              .price
                                              .toString())
                                              !.toStringAsFixed(2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    TextSpan(text: " - "),
                                    TextSpan(
                                      text: AppData.currency!.code !+
                                          double.tryParse(widget
                                              .product
                                              .productCombination
                                              !.last
                                              .price
                                              .toString())
                                              !.toStringAsFixed(2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text("-67%",
                              style:
                              TextStyle(color: Colors.white, fontSize: 8)),
                        )),
                    Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              if (AppData.user != null) {
                                if (checkForWishlist(
                                    int.parse(widget.product.productId.toString()))) {
                                  for (int i = 0;
                                  i < AppData.wishlistData!.length;
                                  i++) {
                                    if (AppData.wishlistData![i].productId ==
                                        widget.product.productId) {
                                      setState(() {
                                        BlocProvider.of<WishlistBloc>(context)
                                            .add(UnLikeProduct(AppData
                                            .wishlistData![i].wishlist));
                                      });
                                      break;
                                    }
                                  }
                                } else {
                                  BlocProvider.of<WishlistBloc>(context).add(
                                      LikeProduct(widget.product.productId));
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
                                data: IconThemeData(color: Colors.white),
                                child: Icon(
                                  (checkForWishlist(widget.product.productId!))
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 18,
                                )),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkForWishlist(int? productId) {
    for (int i = 0; i < AppData.wishlistData!.length; i++) {
      if (productId == AppData.wishlistData![i].productId) {
        return true;
      }
    }
    return false;
  }
}
