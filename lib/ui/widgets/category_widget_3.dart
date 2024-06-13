import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';

import '../../tweaks/app_localization.dart';

class CategoryWidget3 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const CategoryWidget3(this.navigateToNext, {Key? key}) : super(key: key);

  @override
  _CategoryWidget3State createState() => _CategoryWidget3State();
}

class _CategoryWidget3State extends State<CategoryWidget3> {

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
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text((
                AppLocalizations.of(context)!.translate("Categories")
            )!.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                )),
          ),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (state.categoriesResponse.data!.length <=8 ) ? state.categoriesResponse.data!.length : 8,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
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
                            child: ShopScreen(state.categoriesResponse.data![index], widget.navigateToNext)));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                        child: SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: CachedNetworkImage(
                              imageUrl:
                              ApiProvider.imgMediumUrlString + state.categoriesResponse.data![index].gallary!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                      ),
                      title: Text(state.categoriesResponse.data![index].name!),
                      // trailing: Icon(Icons.navigate_next),
                    );
                  }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: AppStyles.GRID_SPACING); },
                );
              } else if (state is CategoriesError) {
                return Text(state.error);
              } else {
                return  Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
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
