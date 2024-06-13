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

class ChooseBrandScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const ChooseBrandScreen(this.navigateToNext, {super.key});

  @override
  State<ChooseBrandScreen> createState() => _ChooseBrandScreenState();
}

class _ChooseBrandScreenState extends State<ChooseBrandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Choose Brand",
          style: GoogleFonts.spaceGrotesk(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        leading: InkWell(
          child: Image.asset("assets/images/Button - Setting.png"),
          onTap: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded) {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.9,
                            mainAxisSpacing: 16),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.135,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: NetworkImage("https://banner2.cleanpng.com/20180711/jfx/kisspng-samsung-electronics-logo-business-samsung-5b466e4f50eac8.7795341715313424153315.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Samsung",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).primaryColor,
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
