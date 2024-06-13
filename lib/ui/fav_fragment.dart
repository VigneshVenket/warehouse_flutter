import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/ui/settings_new.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/card_style_fav.dart';
import 'package:flutter_kundol/ui/widgets/card_style_new.dart';
import 'package:flutter_kundol/ui/widgets/card_style_new_1.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/sigin.dart';
import 'package:google_fonts/google_fonts.dart';

class FavFragment extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  const FavFragment(this.openDrawer,this.navigateToNext);

  @override
  _FavFragmentState createState() => _FavFragmentState();
}

class _FavFragmentState extends State<FavFragment> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;



  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // getProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "WishList",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            AppData.user!=null?
            BlocBuilder<WishlistProductsBloc, WishlistProductsState>(
                          builder: (context, state) {
                            // print(state.wishlistData![0].products!.detail![0].desc);
                            switch (state.status) {
                               case WishlistProductsStatus.success:
                                if (state.wishlistData!.isEmpty) {
                                  return
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 45,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.9,
                                            height: MediaQuery.of(context).size.height * 0.4,
                                            child: Image.asset(
                                              "assets/images/whislist_bg_image-removebg-preview.png",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Center(
                                            child: Text(
                                              "Your wishlist is empty",
                                              style: GoogleFonts.gothicA1(
                                                  fontSize: 28,
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
                                  return GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: AppStyles.GRID_SPACING,
                                          mainAxisSpacing: AppStyles.GRID_SPACING,
                                          childAspectRatio: 0.75
                                      ),
                                      itemCount: state.wishlistData?.length,
                                      itemBuilder: (context, index) {
                                        return CardStyleFav(widget.navigateToNext, state.wishlistData![index].products!);
                                      });
                                }
                                case WishlistProductsStatus.failure:
                                 return Text("Error");
                                default:
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromRGBO(255,76,59,1),
                                    ),
                                  );

                            }
                          }
                          ):
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset(
                      "assets/images/whislist_bg_image-removebg-preview.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Your wishlist is empty",
                    style: GoogleFonts.gothicA1(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getProduct(context);
    }
  }

  void getProduct(BuildContext context) {
    BlocProvider.of<WishlistProductsBloc>(context).add(GetWishlistProducts());
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






