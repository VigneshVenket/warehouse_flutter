import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';

class CategoryWidget6 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const CategoryWidget6(this.navigateToNext, {Key? key}) : super(key: key);

  @override
  _CategoryWidget6State createState() => _CategoryWidget6State();
}

class _CategoryWidget6State extends State<CategoryWidget6> {

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
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                return SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categoriesResponse.data!.length <= 6 ? state.categoriesResponse.data!.length : 10,
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
                            SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(80.0),
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
                    }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 10.0,); },
                  ),
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
