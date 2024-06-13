import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/search_screen.dart';
import 'package:flutter_kundol/ui/widgets/banner_slider.dart';
import 'package:flutter_kundol/ui/widgets/category_widget.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/home_tags.dart';
import 'package:flutter_kundol/ui/widgets/hot_items_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sale_banner_widget.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/featured_products/featured_products_bloc.dart';
import '../screens/choose_brand_widget.dart';
import '../screens/feature_product_widget_home.dart';
import '../screens/new_arrival_widget.dart';

// ignore: must_be_immutable
class HomeFragment1 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  const HomeFragment1(this.navigateToNext, this.openDrawer);

  @override
  _HomeFragment1State createState() => _HomeFragment1State();
}

class _HomeFragment1State extends State<HomeFragment1> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
late Color color;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    getProduct(context);
  }
  final _key = GlobalKey();
final keyCounterr = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), // here the desired height
          child: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          )
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeAppBar(widget.navigateToNext, widget.openDrawer),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding:Theme.of(context).brightness==Brightness.dark?EdgeInsets.all(8):EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     widget.navigateToNext(BlocProvider(
                  //       create: (context) => ProductsSearchBloc(RealProductsRepo()),
                  //       child: SearchScreen(widget.navigateToNext),
                  //     ));
                  //   },
                  //   child: Container(
                  //     height: 56.0,
                  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //     alignment: Alignment.centerLeft,
                  //     decoration: const BoxDecoration(
                  //       color: AppStyles.COLOR_SEARCH_BAR,
                  //       borderRadius:
                  //       BorderRadius.all(Radius.circular(AppStyles.CARD_RADIUS)),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         SvgPicture.asset("assets/icons/ic_search_new.svg",color: Colors.grey[700],height: 18,width: 18,),
                  //         Padding(
                  //             padding: const EdgeInsets.only(left: 10),
                  //             child: Text(
                  //               "What are you looking for?",
                  //               style: Theme.of(context).textTheme.bodySmall,
                  //             ))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16.0,
                  // ),
                  BannerSlider(widget.navigateToNext,"primary"),
                  // HomeTags(),
                  FeaturedProductWidget(widget.navigateToNext),
                  CategoryWidget(widget.navigateToNext,widget.openDrawer),
                  BannerSlider(widget.navigateToNext,"secondary"),
                  // const ChooseBrandWidget(),
                  NewArrivalWidget(widget.navigateToNext),
                  // SaleBannerWidget(
                  //     isTitleVisible: true,
                  //     navigateToNext: widget.navigateToNext),
                  // HotItemsWidget(
                  //     isTitleVisible: true,
                  //     navigateToNext: widget.navigateToNext),
                  // ProductsWidget(widget.navigateToNext, _disableLoadMore),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getProduct(context) {
    BlocProvider.of<ProductsBloc>(context).add(const GetProducts());
    BlocProvider.of<FeaturedProductsBloc>(context).add(const GetFeaturedProducts());
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getProduct(context);
    }
  }

  _disableLoadMore() {
    isLoadingMore = false;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
