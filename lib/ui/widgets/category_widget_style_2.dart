import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:google_fonts/google_fonts.dart';

import '../child_categories_screen.dart';
import '../shop_screen.dart';

class CategoryWidgetStyle2 extends StatelessWidget {
  final List<Category> allCategories;
  final List<Category> parentCategories;
  final Function(Widget widget) navigateToNext;

  const CategoryWidgetStyle2(
      this.allCategories, this.parentCategories, this.navigateToNext,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(
              vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
              horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
          itemCount: parentCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
              mainAxisSpacing: 15),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                List<Category> childCategories = getChildCategories(
                    allCategories, parentCategories[index].id!);
                if (childCategories.isEmpty) {
                  navigateToNext(BlocProvider(
                      create: (BuildContext context) {
                        return ProductsByCatBloc(
                            RealProductsRepo(),
                            BlocProvider.of<CategoriesBloc>(context),
                            parentCategories[index].id,
                            "id",
                            "ASC",
                            "");
                      },
                      child:
                          ShopScreen(parentCategories[index], navigateToNext)));
                } else {
                  navigateToNext(ChildCategoriesScreen(
                      childCategories, allCategories, navigateToNext));
                }
              },
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppStyles.CARD_RADIUS),
                      child: CachedNetworkImage(
                        imageUrl: ApiProvider.imgMediumUrlString +
                            parentCategories[index].gallary!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Color.fromRGBO(255, 76, 59, 1),
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Text(
                    parentCategories[index].name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color:Theme.of(context).brightness ==
                            Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ));
  }

  List<Category> getChildCategories(List<Category> data, int id) {
    List<Category> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == id) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }
}
