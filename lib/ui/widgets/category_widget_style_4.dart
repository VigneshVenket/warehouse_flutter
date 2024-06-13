import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

import '../child_categories_screen.dart';
import '../shop_screen.dart';

class CategoryWidgetStyle4 extends StatelessWidget {
  final List<Category> allCategories;
  final List<Category> parentCategories;
  final Function(Widget widget) navigateToNext;

  const CategoryWidgetStyle4(this.allCategories, this.parentCategories, this.navigateToNext,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppStyles.GRID_SPACING),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: parentCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppStyles.GRID_SPACING,
            childAspectRatio: 1,
            mainAxisSpacing: AppStyles.GRID_SPACING),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius:
            BorderRadius.circular(AppStyles.CARD_RADIUS),
            child: Container(
              child: GestureDetector(
                onTap: () {
                  List<Category> childCategories = getChildCategories(allCategories, parentCategories[index].id!);
                  if(childCategories.isEmpty) {
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
                        child: ShopScreen(
                            parentCategories[index],
                            navigateToNext)));
                  } else {
                    navigateToNext(ChildCategoriesScreen(childCategories, allCategories, navigateToNext));
                  }
                },
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: ApiProvider.imgMediumUrlString +
                          parentCategories[index].gallary!,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,)),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Align(
                      alignment:
                      Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),

                          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor :  Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            parentCategories[index].name!,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w300,),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.SCREEN_MARGIN_VERTICAL, horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
      itemCount: parentCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppStyles.GRID_SPACING,
          childAspectRatio: 0.9,
          mainAxisSpacing: AppStyles.GRID_SPACING),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            List<Category> childCategories = getChildCategories(allCategories, parentCategories[index].id!);
            if(childCategories.isEmpty) {
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
                  child: ShopScreen(
                      parentCategories[index],
                      navigateToNext)));
            } else {
              navigateToNext(ChildCategoriesScreen(childCategories, allCategories, navigateToNext));
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
                            value: downloadProgress.progress)),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Text(
                parentCategories[index].name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Category> getChildCategories(List<Category> data, int id) {
    List<Category> tempCategories = [];
    for (int i=0; i<data.length; i++){
      if (data[i].parent == id){
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }
}
