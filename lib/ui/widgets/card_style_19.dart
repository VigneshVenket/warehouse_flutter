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

import '../../tweaks/app_localization.dart';
import '../detail_screen.dart';

class CardStyle19 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;
  final Color cardColor;

  const CardStyle19(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle19State createState() => _CardStyle19State();
}

class _CardStyle19State extends State<CardStyle19> {
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
        child: Card(
          color: widget.cardColor,
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: double.maxFinite,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(0),
                            child: (widget.product.productGallary == null)
                                ? Container()
                                : SizedBox(
                              width: double.maxFinite,
                              child: CachedNetworkImage(
                                imageUrl: ApiProvider.imgMediumUrlString +
                                    widget
                                        .product.productGallary!.gallaryName!,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url,
                                    downloadProgress) =>
                                    CircularProgressIndicator(
                                        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
                                        value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              padding: const EdgeInsets.all(6.0),
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints.tightFor(width: double.maxFinite, height: 22),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40.0),

                                                    )
                                                )
                                            ),
                                            onPressed: () {
                                              widget.navigateToNext(
                                                BlocProvider(
                                                    create: (context) => DetailScreenBloc(
                                                        RealCartRepo(),
                                                        RealProductsRepo()),
                                                    child: ProductDetailScreen(
                                                        widget.product,
                                                        widget.navigateToNext)),
                                              );
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!.translate("View Details")!,
                                                style: const TextStyle(fontSize: 10))),
                                      )),
                                  const SizedBox(width: 6.0),
                                  Container(
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            if (AppData.user != null) {
                                              if (checkForWishlist(
                                                  widget.product.productId!)) {
                                                for (int i = 0;
                                                i < AppData.wishlistData!.length;
                                                i++) {
                                                  if (AppData.wishlistData![i].productId ==
                                                      widget.product.productId) {
                                                    setState(() {
                                                      BlocProvider.of<WishlistBloc>(context)
                                                          .add(UnLikeProduct(AppData
                                                          .wishlistData![i].wishlist!));
                                                    });
                                                    break;
                                                  }
                                                }
                                              } else {
                                                BlocProvider.of<WishlistBloc>(context).add(
                                                    LikeProduct(widget.product.productId!));
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
                                              )),
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.product.category!.first.categoryDetail
                                          !.detail!.first.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      widget.product.detail!.first.title!,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                      Theme.of(context).textTheme. bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 65,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Color(0xff444444),
                      ),
                      child: Text(
                        AppData.currency!.code !+
                            double.parse((widget.product.productDiscountPrice !=
                                0)
                                ? widget.product.productDiscountPrice
                                .toString()
                                : widget.product.productPrice.toString())
                                .toStringAsFixed(2),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      /*child: Text("Featured",
                            style:
                            TextStyle(color: Colors.white, fontSize: 12))*/
                    ),
                  ],
                ),
              )
            ],
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
