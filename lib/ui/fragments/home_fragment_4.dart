import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/blocs/top_selling_products/top_selling_products_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/search_screen.dart';
import 'package:flutter_kundol/ui/widgets/category_widget.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/hot_items_widget.dart';
import 'package:flutter_kundol/ui/widgets/newarrivals_banner_widget.dart';
import 'package:flutter_kundol/ui/widgets/top_selling_products_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sale_banner_widget.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomeFragment4 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final Function()? openDrawer;

  const HomeFragment4(this.navigateToNext, this.openDrawer);

  @override
  _HomeFragment4State createState() => _HomeFragment4State();
}

class _HomeFragment4State extends State<HomeFragment4> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategories());
    getProduct(context);
    BlocProvider.of<TopSellingProductsBloc>(context)
        .add(const GetTopSellingProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,

      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).cardColor,
          )
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 28.0),
                    color: const Color(0xFFADD0F4),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppStyles.CARD_RADIUS),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 6.0),
                        color: Colors.white,
                        child: Center(
                          child: HotItemsWidget(
                              isTitleVisible: true,
                              navigateToNext: widget.navigateToNext!),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.navigateToNext!(BlocProvider(
                              create: (context) => ProductsSearchBloc(RealProductsRepo()),
                              child: SearchScreen(widget.navigateToNext!),
                            ));
                          },
                          child: Container(
                            height: 56.0,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                              color: AppStyles.COLOR_SEARCH_BAR,
                              borderRadius:
                              BorderRadius.all(Radius.circular(AppStyles.CARD_RADIUS)),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/ic_search_new.svg",color: Colors.grey[700],height: 18,width: 18,),

                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "What are you looking for?",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SaleBannerWidget(
                            isTitleVisible: false,
                            navigateToNext: widget.navigateToNext!),
                        NewArrivalsBannerWidget(
                            isTitleVisible: false,
                            navigateToNext: widget.navigateToNext!),
                        // CategoryWidget(widget.navigateToNext!,),
                        TopSellingProductsWidget(widget.navigateToNext!),
                        ProductsWidget(
                            widget.navigateToNext!, _disableLoadMore),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          HomeAppBar(widget.navigateToNext!, widget.openDrawer!)
        ],
      ),
    );
  }

  void getProduct(context) {
    BlocProvider.of<ProductsBloc>(context).add(const GetProducts());
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
