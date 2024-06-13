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

class CategoryWidgetStyle1 extends StatelessWidget {
  final List<Category> allCategories;
  final List<Category> parentCategories;
  final Function(Widget widget) navigateToNext;

  const CategoryWidgetStyle1(this.allCategories, this.parentCategories, this.navigateToNext,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,

      body: Container(
        child : ListView.separated(
          padding: const EdgeInsets.symmetric(
              horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
              vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
          itemBuilder: (context, index) {
            return InkWell(
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
                      child: ShopScreen (
                          parentCategories[index],
                          navigateToNext)));
                } else {
                  navigateToNext(ChildCategoriesScreen(childCategories, allCategories, navigateToNext));
                }
              },
              child: Row(children: [
                SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          AppStyles.CARD_RADIUS),
                      child: CachedNetworkImage(
                        imageUrl: ApiProvider.imgMediumUrlString +
                            parentCategories[index]
                                .gallary!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url,
                            downloadProgress) =>
                            Center(
                                child: CircularProgressIndicator(
                                    value:
                                    downloadProgress.progress,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,)),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  parentCategories[index].name!,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ]),
            );
          },
          itemCount: parentCategories.length,
          separatorBuilder: (context, index) =>
              const SizedBox(
                height: AppStyles.GRID_SPACING,
              ),
        ),
      ),
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
