import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/ui/main_screen.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/related_products/related_products_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/repos/reviews_repo.dart';
import 'package:flutter_kundol/ui/review_screen.dart';
import 'package:flutter_kundol/blocs/reviews/reviews_bloc.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/badgeCount.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/related_products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../constants/app_cart.dart';

import '../tweaks/app_localization.dart';
import 'cart_screen.dart';
import 'login_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  Product product;

  ProductDetailScreen(this.product, this.navigateToNext, {super.key});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  BottomSheetContent? bottomSheetContent;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailScreenBloc>(context)
        .add(GetProductById(widget.product.productId!));
  }

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  var s1 = AppBadge();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    List<String> apiResponseDescription=widget.product.detail!.first.desc!.split("||");
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.product.category!.first.categoryDetail!.detail!.first.name!,
          style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
        ),
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios_new_rounded, color:Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () => widget.navigateToNext(
                (AppData.user != null)
                    ? MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => CartBloc(RealCartRepo()),
                          ),

                        ],
                        child: CartScreen(widget.navigateToNext),
                      )

                    : const SignInScreen(),
              ),
              child:
              SizedBox(
                height: 40,
                width: 40,
                child: ValueListenableBuilder<int>(
                  builder: (BuildContext context, int value, Widget? child) {
                    return Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12, top: 5),
                            child: Icon(
                              Icons.shopping_cart,
                              size: 26,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(18, 18, 18, 1),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: MediaQuery.of(context).size.width * 0.02,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(255, 76, 59, 1),
                              ),
                              height: 15,
                              width: 15,
                              child: Center(
                                child: Text(
                                  value.toString(), // Display the badge count
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  valueListenable: s1.cartTotalitemsListener, // Listen to cartTotalitemsListener
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
        elevation: 0.0,
      ),
      body:
      BlocConsumer<DetailScreenBloc, DetailPageState>(
        listener: (context, state) {
          if (state is GetQuantityLoaded) {
            if (state.quantityData.remainingStock == null ||
                int.tryParse(state.quantityData.remainingStock!) == 0) {
              Navigator.pop(context);
              AppConstants.showMessage(context,"Stock is empty",Colors.red);

            } else if (int.tryParse(state.quantityData.remainingStock!)! <
                quantity) {
              Navigator.pop(context);

              AppConstants.showMessage(context,"Max stock available is ${state.quantityData.remainingStock!}",Colors.red);

            } else if (int.tryParse(state.quantityData.remainingStock!)! >=
                quantity) {
              BlocProvider.of<DetailScreenBloc>(context).add(AddToCart(
                  widget.product.productId,
                  quantity,
                  int.tryParse(
                      (state.quantityData.productCombinationId ?? ""))));
            }
          } else if (state is ItemCartAdded) {
            // Navigator.pop(context);
            BlocProvider.of<DetailScreenBloc>(context)
                .add(GetProductById(widget.product.productId!));
            AppData.sessionId = state.sessionId;

            AppConstants.showMessage(context,state.message!,Colors.green);

          } else if (state is ProductDetailsLoaded) {
            setState(() {
              widget.product = state.product!;
            });
          } else if (state is DetailPageError) {

            AppConstants.showMessage(context,state.error!,Colors.red);

          } else {
            Navigator.pop(context);
            AppConstants.showMessage(context,"Empty",Colors.red);

          }
        },
        builder: (context, state) {
          if (state is ProductDetailsLoaded) {
            print(state.product!.productRating);
            return Column(
              children:[
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Stack(
                            children: [
                              CarouselSlider.builder(
                                carouselController: buttonCarouselController,
                                options: CarouselOptions(
                                  height: double.maxFinite,
                                  autoPlay: true,
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: true,
                                  initialPage: 0,
                                  enlargeCenterPage: false,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  pauseAutoPlayOnTouch: false,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    setState(() {});
                                  },
                                ),
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    child: CachedNetworkImage(
                                      imageUrl: ApiProvider.imgMediumUrlString +
                                          widget
                                              .product
                                              .productGallaryDetail![index]
                                              .gallaryName!,
                                      fit: BoxFit.contain,
                                      progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  color:Color.fromRGBO(255, 76, 59, 1),
                                                  value:
                                                  downloadProgress.progress)),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  );
                                },
                                itemCount:
                                widget.product.productGallaryDetail?.length,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () async {
                                    if(AppData.user!=null){
                                      if (checkForWishlist(widget.product.productId!)) {
                                        BlocProvider.of<DetailScreenBloc>(context).add(GetProductById(widget.product.productId!));
                                        AppConstants.showMessage(context,"The product has already been added to the wishlist!", Colors.red);

                                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added in the wishlist!")));
                                      }
                                      else {
                                        BlocProvider.of<WishlistBloc>(context).add(LikeProduct(widget.product.productId!));
                                        await Future.delayed( const Duration(milliseconds: 200), (){
                                          BlocProvider.of<DetailScreenBloc>(context).add(GetProductById(widget.product.productId!));
                                        });
                                        AppConstants.showMessage(context,"Product successfully added to the wishlist!", Colors.green);
                                      }
                                    }
                                    else{
                                      AppConstants.showMessage(context,"Please login to add products to the whislist", Colors.red);
                                    }

                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(12),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(18,18, 18, 1):
                                        Color.fromRGBO(240,240, 240, 1)
                                    ),
                                    // color: const Color(0x22000000),
                                    child: checkForWishlist(widget.product.productId!)?
                                    Icon(Icons.favorite_outlined,color:Color.fromRGBO(255, 76, 59, 1),size: 24,):
                                    Icon(Icons.favorite_outline,color:Color.fromRGBO(255, 76, 59, 1) ,size: 24,),

                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        buttonCarouselController.previousPage();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color:Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(18,18, 18, 1):
                                            Color.fromRGBO(240,240, 240, 1)
                                        ),
                                        child:Icon(
                                            Icons.arrow_back_ios_new,
                                            color:Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(255,255, 255, 1):
                                            Color.fromRGBO(0,0, 0, 1)
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        buttonCarouselController.nextPage();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color:Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(18,18, 18, 1):
                                            Color.fromRGBO(240,240, 240, 1)),
                                        child: Icon(
                                            Icons.arrow_forward_ios,
                                            color:Theme.of(context).brightness ==
                                                Brightness.dark?Color.fromRGBO(255,255, 255, 1):
                                            Color.fromRGBO(0,0, 0, 1)
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.product.detail!.first.title!,
                          style: GoogleFonts.gothicA1(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color:Theme.of(context).brightness ==
                                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            SmoothStarRating(
                              starCount: 5,
                              size: 20,
                              allowHalfRating: true,
                              rating: state.product!.productRating!=null?state.product!.productRating!:0.0,
                              color: Color.fromRGBO(255, 76, 59, 1),
                              borderColor: Color.fromRGBO(255, 76, 59, 1),
                            ),
                            TextButton(onPressed: (){
                              state.product!.productRating == null
                                  ? null
                                  : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (BuildContext context) {
                                        return ReviewsBloc(
                                            RealReviewsRepo())
                                          ..add(GetReviews(state.product!.productId));
                                      },
                                      child: ReviewScreen(widget.product.productRating,widget.product.reviews!.length),
                                    ),
                                  ));
                              }, child: Text(
                                state.product!.productRating == null
                                    ? "0 (0 reviews)"
                                    : "${state.product!.productRating!.toStringAsFixed(1)} (${state.product!.reviews!.length.toString()} reviews)",
                                style: GoogleFonts.gothicA1(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:Theme.of(context).brightness ==
                                      Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                                  Color.fromRGBO(112,112, 112, 1),
                         )),
                            // TextButton.icon(
                            //   onPressed: () {
                            //     state.product!.productRating == null
                            //         ? null
                            //         : Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => BlocProvider(
                            //             create: (BuildContext context) {
                            //               return ReviewsBloc(
                            //                   RealReviewsRepo())
                            //                 ..add(GetReviews(state.product!.productId));
                            //             },
                            //             child: ReviewScreen(widget.product.productRating,widget.product.reviews!.length),
                            //           ),
                            //         ));
                            //   },
                            //   label:
                            //   Text(
                            //     state.product!.productRating == null
                            //         ? "0 (0 reviews)"
                            //         : "${state.product!.productRating!.toStringAsFixed(1)} (${state.product!.reviews!.length.toString()} reviews)",
                            //     style: GoogleFonts.gothicA1(
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w600,
                            //       color:Theme.of(context).brightness ==
                            //           Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                            //       Color.fromRGBO(112,112, 112, 1),
                            //     ),
                            //   ),
                            //   icon: const Icon(
                            //     Icons.star,
                            //     color: Colors.deepOrange,
                            //     size: 20,
                            //   ),
                            // )
                            )],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Description",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.gothicA1(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color:Theme.of(context).brightness ==
                                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: apiResponseDescription.length,
                              itemBuilder: (context,index){
                                return Text(apiResponseDescription[index],
                                  style: GoogleFonts.gothicA1(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color:Theme.of(context).brightness ==
                                          Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
                                      height: 1.5),
                                );
                              })
                      ),
                      const SizedBox(height: 10.0),
                      const Divider(height: 1, indent: 16, endIndent: 16,),
                      const SizedBox(height: 10.0),

                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    width: double.infinity,
                    color:Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(0,0,0,1):Color.fromRGBO(255, 255, 255,1) ,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                  Text("${AppData.currency!.code}${state.product!.productDiscountPrice}",
                                    style: GoogleFonts.gothicA1(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFFF4C3B),
                                      height: 1.5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("M.R.P :",style:GoogleFonts.gothicA1(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color:Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
                                        height: 1.5,
                                      ) ),
                                      Text("${AppData.currency!.code}${state.product!.productPrice}",

                                          style:GoogleFonts.gothicA1(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color:Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
                                          height: 1.5,
                                              decoration: TextDecoration.lineThrough,
                                      ) ),

                                    ],
                                  )
                              ],
                            ),
                            // RichText(
                            //   text: TextSpan(
                            //     text: "Price: ",
                            //     style: GoogleFonts.gothicA1(
                            //       fontSize: 12.0,
                            //       fontWeight: FontWeight.w700,
                            //       color:Theme.of(context).brightness ==
                            //           Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
                            //       height: 1.5,
                            //     ),
                            //     children: [
                            //       state.product!.productDiscountPrice != null &&
                            //           state.product!.productDiscountPrice !=
                            //               0.00 &&
                            //           state.product!.productDiscountPrice !=
                            //               0 &&
                            //           state.product!.productDiscountPrice !=
                            //               0.0
                            //           ?
                            //       TextSpan(
                            //           text:
                            //           "${AppData.currency!.code}${state.product!.productDiscountPrice} ",
                            //           style: GoogleFonts.gothicA1(
                            //             fontSize: 18.0,
                            //             fontWeight: FontWeight.w700,
                            //             color: Color(0xFFFF4C3B),
                            //             height: 1.5,
                            //           ),
                            //           children: [
                            //             TextSpan(
                            //               text:
                            //               "${AppData.currency!.code}${state.product!.productPrice}",
                            //               style: GoogleFonts.gothicA1(
                            //                 fontSize: 12.0,
                            //                 fontWeight: FontWeight.w600,
                            //                 color: Theme.of(context).brightness ==
                            //                     Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                            //                 height: 1.5,
                            //                 decoration: TextDecoration
                            //                     .lineThrough,
                            //               ),
                            //             )
                            //           ])
                            //           : TextSpan(
                            //           text: "${AppData.currency!.code}${state.product!.productPrice}",
                            //           style: GoogleFonts.gothicA1(
                            //           fontSize: 12.0,
                            //           fontWeight: FontWeight.w600,
                            //           color: const Color(0xFFFF4C3B),
                            //           height: 1.5,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Row(
                              children: [
                                IconButton(
                                  padding: const EdgeInsets.all(0.0),
                                  constraints: const BoxConstraints(
                                      maxHeight: 24,
                                      maxWidth: 24,
                                      minHeight: 24,
                                      minWidth: 24),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) quantity--;
                                    });
                                  },
                                  icon: Icon(Icons.remove, color:Theme.of(context).brightness ==
                                      Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:Theme.of(context).brightness ==
                                          Brightness.dark?Color.fromRGBO(18,18,18,1):Color.fromRGBO(240,240, 240,1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    quantity.toString(),
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color:Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
                                  ),
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0.0),
                                  constraints: const BoxConstraints(
                                      maxHeight: 24,
                                      maxWidth: 24,
                                      minHeight: 24,
                                      minWidth: 24),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  icon: Icon(Icons.add, color:Theme.of(context).brightness ==
                                      Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width:double.maxFinite,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: const Color(0xFFFF4C3B),
                            ),
                            onPressed: () {
                              debugPrint("add to cart");
                              if(AppData.user!=null){
                                if (widget.product.productType == AppConstants.PRODUCT_TYPE_VARIABLE) {
                                  buildBottomSheet(context);
                                }
                                else {
                                  BlocProvider.of<DetailScreenBloc>(context).add(
                                      GetQuantity(
                                          widget.product.productId!,
                                          AppLocalizations.of(context)
                                              .translate("simple"),
                                          1));
                                }
                              }else{
                                AppConstants.showMessage(context,"Please login to add items to the cart", Colors.red);
                              }

                            },
                            child: Text(
                              "Add To Cart",
                              style: GoogleFonts.gothicA1(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ]
            );
          } else {
            return const Center(child: CircularProgressIndicator(
                color:Color.fromRGBO(255, 76, 59, 1)
            ));
          }
        },
      ),
    );
  }

  void buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BottomSheetContent(widget.product, onVariationSelected);
      },
    );
  }

  void onVariationSelected(int combinationId, int quantity) {
    Navigator.pop(context);
    this.quantity = quantity;
    BlocProvider.of<DetailScreenBloc>(context).add(GetQuantity(
        widget.product.productId!,
        AppLocalizations.of(context).translate("variable"),
        combinationId));
  }

  Widget buildDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppStyles.COLOR_LITE_GREY_DARK
          : AppStyles.COLOR_LITE_GREY_LIGHT,
      thickness: 4,
    );
  }

  Widget buildSection(
      List<Widget> children, bool isDividerVisible, bool isPaddingEnabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: isPaddingEnabled
              ? EdgeInsets.symmetric(
                  vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                  horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL)
              : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        if (isDividerVisible)
          Divider(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppStyles.COLOR_LITE_GREY_DARK
                : AppStyles.COLOR_LITE_GREY_LIGHT,
            thickness: 4,
          ),
      ],
    );
  }

  Widget buildLabel(String text, Color color) {
    return Container(
      width: 70,
      height: 20,
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
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
}

int BadgeItems() {
  var s1 = AppBadge();
  print(
      "-------------------------------------------- updated home cart    ----------------------- ${s1.getBadgeUpdate()}");
  return s1.getBadgeUpdate();
}

/*
class RelatedProducts extends StatelessWidget {
  const RelatedProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppStyles.GRID_SPACING,
        mainAxisSpacing: AppStyles.GRID_SPACING,
        childAspectRatio: 0.75,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://i.pinimg.com/originals/66/f1/6e/66f16eee76fa106a4cc160cbf6a58611.jpg",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "This is large text title for product. This is large text title for product. ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "\$1200.00",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "\$1200.00",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                )
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8)),
                            )),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: IconTheme(
                                  data: IconThemeData(color: Colors.white),
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 18,
                                  )),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*/

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).primaryColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisSize: MainAxisSize.min,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

// ignore: must_be_immutable
class BottomSheetContent extends StatefulWidget {
  Product product;
  Function(int combinationId, int quantity) onVariationSelected;

  BottomSheetContent(this.product, this.onVariationSelected);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  ProductCombination? selectedCombination;
  String selectionText = "";
  List<ProductAttributeVariations> selectedVariations = [];
  int quantity = 1;

  @override
  void initState() {
    super.initState();

    //selection of first / first variation.
    selectedVariations = [];
    for (int i = 0; i < widget.product.attribute!.length; i++) {
      selectedVariations.add(widget.product.attribute![i].variations!.first);
    }
    selectedCombination = widget.product.productCombination![0];
    findCombination();
  }

/*
  void findCombination() {
    //finding the combination for selected variations.
    for (int combinationIndex = 0;
        combinationIndex < widget.product.productCombination.length;
        combinationIndex++) {
      if (checkForSelectedCombination(
          widget.product.productCombination[combinationIndex].combination,
          selectedVariations)) {
        selectedCombination =
            widget.product.productCombination[combinationIndex];
      }
    }
    selectionText = "";
    for (int i = 0; i < selectedCombination.combination.length; i++) {
      selectionText = (i == 0)
          ? selectedCombination.combination[i].variation.detail.first.name
          : selectionText +
              ", " +
              selectedCombination.combination[i].variation.detail.first.name;
    }
  }
*/

  void findCombination() {
    //finding the combination for selected variations.

    int found = 0;
    for (int i = 0; i < widget.product.productCombination!.length; i++) {
      ProductCombination combinations = widget.product.productCombination![i];
      found = 0;
      for (int j = 0; j < selectedVariations.length; j++) {
        ProductAttributeVariations inner = selectedVariations[j];
        for (int k = 0; k < combinations.combination!.length; k++) {
          Combination element = combinations.combination![k];
          if (element.variationId == inner.productVariation!.id) {
            found++;
          }
        }
        if (found == this.selectedVariations.length)
          this.selectedCombination = combinations;
      }
    }

    selectionText = "";
    for (int i = 0; i < selectedCombination!.combination!.length; i++) {
      selectionText = ((i == 0)
          ? selectedCombination?.combination![i].variation!.detail!.first.name
          : selectionText +
              ", " +
              selectedCombination!
                  .combination![i].variation!.detail!.first.name!)!;
    }
  }

  bool checkForSelectedCombination(List<Combination> combination,
      List<ProductAttributeVariations> selectedVariations) {
    for (int i = 0; i < selectedVariations.length; i++) {
      if (combination[i].variationId !=
          selectedVariations[i].productVariation?.id) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).scaffoldBackgroundColor
            : Color(0xffF6F6F6),
      ),
      // color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Color(0xffF6F6F6),
      padding: EdgeInsets.symmetric(
          horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
          vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
              child: Container(
            width: 70,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xffCCCCCC)),
          )),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  child: CachedNetworkImage(
                    imageUrl: ApiProvider.imgMediumUrlString +
                        selectedCombination!.gallary!.gallaryName!,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppData.currency!.code! +
                        double.tryParse((selectedCombination!.price! * quantity)
                                .toString())!
                            .toStringAsFixed(2),
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: AppLocalizations.of(context).translate("Selection"),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextSpan(
                        text: selectionText,
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT)),
                  ])),
                ],
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.product.attribute?.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Text(widget
                    .product.attribute![index].attributes!.detail!.first.name!),
                const SizedBox(
                  height: 12.0,
                ),
                ChoiceChips(
                  chipName: widget.product.attribute![index].variations!,
                  choiceChipsCallback: (variation) {
                    setState(() {
                      selectedVariations[index] = variation;
                      findCombination();
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(AppLocalizations.of(context).translate("Quantity")),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                  color: Colors.grey,
                  textColor: Colors.white,
                  padding: const EdgeInsets.only(bottom: 3),
                  shape: const CircleBorder(),
                  child: const Text(
                    "-",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              // IconButton(
              //     icon: Icon(Icons.chevron_left),
              //     onPressed: () {
              //       setState(() {
              //         if (quantity > 1) quantity--;
              //       });
              //     }),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    quantity.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
              // IconButton(
              //     icon: Icon(Icons.chevron_right),
              //     onPressed: () {
              //       setState(() {
              //         quantity++;
              //       });
              //     }),
              SizedBox(
                height: 24,
                width: 24,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  padding: const EdgeInsets.only(bottom: 3),
                  shape: const CircleBorder(),
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
            height: 45.0,
            width: double.maxFinite,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ))),
                onPressed: () {
                  widget.onVariationSelected(
                      selectedCombination!.productCombinationId!, quantity);
                },
                child:
                    Text(AppLocalizations.of(context).translate("Continue"))),
          ),
        ],
      ),
    );
  }
}

typedef void ChoiceChipsCallback(ProductAttributeVariations variation);

class ChoiceChips extends StatefulWidget {
  final List<ProductAttributeVariations>? chipName;
  final ChoiceChipsCallback? choiceChipsCallback;

  ChoiceChips({Key? key, this.chipName, this.choiceChipsCallback})
      : super(key: key);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  String _selected = "";

  @override
  void initState() {
    super.initState();
    _selected = widget.chipName!.first.productVariation!.detail!.first.name!;
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.chipName?.forEach((item) {
      choices.add(Container(
        child: FilterChip(
          checkmarkColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          label: Text(item.productVariation!.detail!.first.name!),
          labelStyle: TextStyle(
              color: _selected == item.productVariation!.detail!.first.name
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).brightness == Brightness.dark
                      ? AppStyles.COLOR_GREY_DARK
                      : AppStyles.COLOR_GREY_LIGHT),
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(
          //       color: _selected == item.productVariation.detail.first.name
          //           ? Colors.transparent
          //           : Theme.of(context).brightness == Brightness.dark
          //               ? AppStyles.COLOR_GREY_DARK
          //               : AppStyles.COLOR_GREY_LIGHT,
          //       width: 1),
          //   borderRadius: BorderRadius.circular(5),
          // ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: _selected == item.productVariation!.detail!.first.name
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          selectedColor: Colors.transparent,
          selected: _selected == item.productVariation!.detail!.first.name,
          onSelected: (selected) {
            setState(() {
              _selected = item.productVariation!.detail!.first.name!;
              widget.choiceChipsCallback!(item);
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
