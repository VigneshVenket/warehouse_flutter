import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';

import '../../tweaks/app_localization.dart';

class CategoryFragment6 extends StatefulWidget {
  Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  CategoryFragment6(this.navigateToNext, this.openDrawer);

  @override
  _CategoryFragment6State createState() => _CategoryFragment6State();
}

class _CategoryFragment6State extends State<CategoryFragment6> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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
      body: Row(
        children: <Widget>[
          const SizedBox(height: 5,),
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.favorite_border),
                label: Text(
                    AppLocalizations.of(context).translate('First')!
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.bookmark_border),
                label: Text(
                    AppLocalizations.of(context).translate('Second')!
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.star_border),
                label: Text(
                    AppLocalizations.of(context).translate('Third')!
                ),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.categoriesResponse.data?.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: AppStyles.GRID_SPACING,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: AppStyles.GRID_SPACING),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SizedBox(
                                width: 60.0,
                                height: 60.0,
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
                                            value: downloadProgress.progress)),
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
                                    fontSize: 11.0, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is CategoriesError) {
                  return Text(state.error);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
