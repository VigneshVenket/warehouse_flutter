import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';

class CategoryWidget5 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const CategoryWidget5(this.navigateToNext, {Key? key}) : super(key: key);

  @override
  _CategoryWidget5State createState() => _CategoryWidget5State();
}

class _CategoryWidget5State extends State<CategoryWidget5> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12.0,
        ),
        BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoaded) {
              return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.categoriesResponse.data!.length <= 6 ? state.categoriesResponse.data!.length : 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppStyles.GRID_SPACING,
                    childAspectRatio: 1,
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
                          child: ShopScreen(state.categoriesResponse.data![index], widget.navigateToNext)));
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(100.0),
                            child: CachedNetworkImage(
                              imageUrl: ApiProvider.imgMediumUrlString +
                                  state.categoriesResponse.data![index].gallary!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Text(
                          state.categoriesResponse.data![index].name!,
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
            } else if (state is CategoriesError) {
              return Text(state.error);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
