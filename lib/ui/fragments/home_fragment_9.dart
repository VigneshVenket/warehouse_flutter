import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/featured_products/featured_products_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/blocs/super_deal_products/super_deal_products_bloc.dart';
import 'package:flutter_kundol/blocs/top_selling_products/top_selling_products_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/search_screen.dart';
import 'package:flutter_kundol/ui/widgets/banner_slider.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_6.dart';
import 'package:flutter_kundol/ui/widgets/featured_single_page_widget.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/hot_items_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sale_banner_widget.dart';
import 'package:flutter_kundol/ui/widgets/super_deals_single_page_widget.dart';
import 'package:flutter_kundol/ui/widgets/top_selling_single_page_widget.dart';
import 'package:flutter_svg/svg.dart';

import '../../tweaks/app_localization.dart';

// ignore: must_be_immutable
class HomeFragment9 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  const HomeFragment9(this.navigateToNext, this.openDrawer);

  @override
  _HomeFragment9State createState() => _HomeFragment9State();
}

class _HomeFragment9State extends State<HomeFragment9>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getProduct(context);
    BlocProvider.of<TopSellingProductsBloc>(context)
        .add(const GetTopSellingProducts());
    BlocProvider.of<SuperDealProductsBloc>(context).add(const GetSuperDealProducts());
    BlocProvider.of<FeaturedProductsBloc>(context).add(const GetFeaturedProducts());
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeAppBar(widget.navigateToNext, widget.openDrawer),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
                    vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.navigateToNext(BlocProvider(
                          create: (context) => ProductsSearchBloc(RealProductsRepo()),
                          child: SearchScreen(widget.navigateToNext),
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
                    CategoryWidget6(widget.navigateToNext),
                    BannerSlider(widget.navigateToNext,"primary"),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(height: 15,),
                        Container(
                          child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BubbleTabIndicator(
                                indicatorHeight: 34.0,
                                indicatorRadius: 12,
                                indicatorColor:   Theme.of(context).primaryColor,
                                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                // Other flags
                                // indicatorRadius: 1,
                                // insets: EdgeInsets.all(1),
                                // padding: EdgeInsets.all(10)

                              ),
                              controller: _tabController,
                              labelStyle: const TextStyle(),
                              unselectedLabelColor:
                              Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                              // labelColor: Theme.of(context).primaryColor,
                              labelColor: Colors.white,
                              tabs: [
                                Tab(text:
                                AppLocalizations.of(context)!.translate("New Arrivals")
                                ),
                                Tab(text:
                                AppLocalizations.of(context)!.translate("Trending")
                                ),
                                Tab(text:
                                AppLocalizations.of(context)!.translate("Sale Items")
                                ),
                              ]),
                        ),
                        Center(
                          child: [
                            TopSellingSinglePageWidget(widget.navigateToNext),
                            SuperDealSinglePageWidget(widget.navigateToNext),
                            FeaturedSinglePageWidget(widget.navigateToNext),
                          ][_tabController.index],
                        ),
                      ],
                    ),
                    SaleBannerWidget(isTitleVisible: true, navigateToNext: widget.navigateToNext),
                    HotItemsWidget(isTitleVisible: true, navigateToNext: widget.navigateToNext),
                    ProductsWidget(widget.navigateToNext, _disableLoadMore),
                  ],
                ),
              ),
            ),
          )
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
