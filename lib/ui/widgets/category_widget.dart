import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../tweaks/app_localization.dart';
import '../fragments/category_fragment_2.dart';

class CategoryWidget extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  const CategoryWidget(this.navigateToNext,this.openDrawer, {Key? key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shop by Category",
                maxLines: 4,
                style: GoogleFonts.gothicA1(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color:Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
              ),
              // Directionality(
              //   textDirection: TextDirection.rtl,
              //   child: TextButton.icon(
              //     onPressed: () {
              //         widget.navigateToNext(CategoryFragment2(widget.navigateToNext, widget.openDrawer));
              //     },
              //     icon: Icon(
              //       Icons.arrow_back_ios_new,
              //       color:Theme.of(context).brightness ==
              //           Brightness.dark?Color.fromRGBO(160,160, 160, 1):
              //       Color.fromRGBO(112,112, 112, 1),
              //       size: 20,
              //     ),
              //     label: Text(
              //       "View All",
              //       maxLines: 4,
              //       style: GoogleFonts.gothicA1(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //           color:Theme.of(context).brightness ==
              //               Brightness.dark?Color.fromRGBO(160,160, 160, 1):
              //           Color.fromRGBO(112,112, 112, 1)),
              //     ),
              //   ),
              // )
            ],
          ),
          SizedBox(height: 15,),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.categoriesResponse.data!.length > 8
                      ? 8
                      : state.categoriesResponse.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: AppStyles.GRID_SPACING,
                      childAspectRatio: 0.85,
                      mainAxisSpacing: AppStyles.GRID_SPACING),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        widget.navigateToNext(BlocProvider(
                            create: (BuildContext context) {
                              return ProductsByCatBloc(
                                  RealProductsRepo(),
                                  BlocProvider.of<CategoriesBloc>(context),
                                  state.categoriesResponse.data![index].id,
                                  "id",
                                  "ASC",
                                  "");
                            },
                            child: ShopScreen(
                                state.categoriesResponse.data![index],
                                widget.navigateToNext)));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: CachedNetworkImage(
                              imageUrl: ApiProvider.imgMediumUrlString +
                                  state.categoriesResponse.data![index]
                                      .gallary!,
                              fit: BoxFit.cover,
                              height: 70,
                              width: double.infinity,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Color.fromRGBO(255, 76, 59, 1),
                                // color: Theme.of(context).brightness ==
                                //         Brightness.dark
                                //     ? Theme.of(context).primaryColorLight
                                //     : Theme.of(context).primaryColor,
                              )),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                state.categoriesResponse.data![index].name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.gothicA1(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color:Theme.of(context).brightness ==
                                        Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (state is CategoriesError) {
                return Text(state.error);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      color:Color.fromRGBO(255, 76, 59, 1)
                    // color: Theme.of(context).brightness == Brightness.dark
                    //     ? Theme.of(context).primaryColorLight
                    //     : Theme.of(context).primaryColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
