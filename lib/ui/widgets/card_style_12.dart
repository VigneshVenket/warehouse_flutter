import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

import '../../tweaks/app_localization.dart';
import '../detail_screen.dart';

class CardStyle12 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;
  final Color cardColor;

  const CardStyle12(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle12State createState() => _CardStyle12State();
}

class _CardStyle12State extends State<CardStyle12> {
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
        borderRadius: BorderRadius.circular(0),
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
                    child: Container(
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(0),
                        child: (widget.product.productGallary == null)
                            ? Container()
                            : SizedBox(
                          width: double.maxFinite,
                          child: CachedNetworkImage(
                            imageUrl: ApiProvider.imgMediumUrlString +
                                widget.product.productGallary!.gallaryName!,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
                                    value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                widget.product.detail!.first.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            (widget.product.productDiscountPrice != 0) ?
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Wrap(
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
                                        fontFamily: "MontserratSemiBold",
                                        color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(width: 8),
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
                              ),
                            ) : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                AppData.currency!.code !+
                                    double.parse(widget.product.productPrice
                                        .toString())
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: "MontserratSemiBold",
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            const SizedBox(height: 6,),
/*
                            (widget.product.productType ==
                                AppConstants.PRODUCT_TYPE_SIMPLE)
                                ? Row(
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
                            )
                                : RichText(
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
*/
                            SizedBox(
                              width: double.maxFinite,
                              height: 24,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0.0),

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
                                  }, child: Text(
                                AppLocalizations.of(context)!.translate("View Details")!,
                                style: const TextStyle(fontSize: 10),)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.product.productDiscountPrice != 0)
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Text("-${((double.parse(widget.product.productPrice
                                .toString()) -
                                double.parse(widget
                                    .product.productDiscountPrice
                                    .toString())) /
                                double.parse(widget.product.productPrice
                                    .toString()) *
                                100)
                                .toStringAsFixed(0)}%",
                                style:
                                const TextStyle(color: Colors.white, fontSize: 8)),
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

  bool checkForWishlist(int productId) {
    for (int i = 0; i < AppData.wishlistData!.length; i++) {
      if (productId == AppData.wishlistData![i].productId) {
        return true;
      }
    }
    return false;
  }
}