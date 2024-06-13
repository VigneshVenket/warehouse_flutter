
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api_provider.dart';
import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/products_by_category/products_by_cat_bloc.dart';
import '../../constants/app_styles.dart';
import '../../repos/products_repo.dart';
import '../shop_screen.dart';

class CategoryWidgetSearchScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const CategoryWidgetSearchScreen(this.navigateToNext ,{Key? key}) : super(key: key);

  @override
  _CategoryWidgetSearchScreenState createState() => _CategoryWidgetSearchScreenState();
}

class _CategoryWidgetSearchScreenState extends State<CategoryWidgetSearchScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoaded) {
            return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.categoriesResponse.data!.length > 8
                  ? 8
                  : state.categoriesResponse.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        const BorderRadius.all(Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: ApiProvider.imgMediumUrlString +
                              state.categoriesResponse.data![index]
                                  .gallary!,
                          fit: BoxFit.fill,
                          height: 50,
                          width: double.infinity,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Color.fromRGBO(255, 76, 59, 1),
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
    );
  }
}