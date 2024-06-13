import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api_provider.dart';
import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/detail_screen/detail_screen_bloc.dart';
import '../../blocs/new_arrival_blocs/new_arrival_product_bloc.dart';
import '../../models/category.dart';
import '../../models/products/product.dart';
import '../../repos/cart_repo.dart';
import '../../repos/products_repo.dart';
import '../../tweaks/app_localization.dart';
import '../detail_screen.dart';
import 'new_featured_products_all_view.dart';

class NewArrivalWidget extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const NewArrivalWidget(this.navigateToNext, {super.key});

  @override
  State<NewArrivalWidget> createState() => _NewArrivalWidgetState();
}

class _NewArrivalWidgetState extends State<NewArrivalWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New Arrivals",
              maxLines: 4,
              style: GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color:Theme.of(context).brightness ==
                      Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1)),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: () {
                  widget.navigateToNext(
                    BlocProvider(
                        create: (context) =>
                            NewArrivalProductBloc(RealProductsRepo(),selectedId,BlocProvider.of<CategoriesBloc>(context)),
                        child: ViewAllScreen("New Arrival", widget.navigateToNext)),
                  );
                },
                icon: Icon(Icons.arrow_back_ios_outlined,
                  color:Theme.of(context).brightness ==
                      Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                  Color.fromRGBO(112,112, 112, 1),
                  size: 20,
                ),
                label: Text(
                  "View All",
                  maxLines: 4,
                  style: GoogleFonts.gothicA1(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:Theme.of(context).brightness ==
                          Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                      Color.fromRGBO(112,112, 112, 1)),
                ),
              ),
            )
          ],
        ),
        // chipList(context),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.27,
          width: double.infinity,
          child: BlocProvider(
            create: (context) {
              return NewArrivalProductBloc(RealProductsRepo(), selectedId,
                  BlocProvider.of<CategoriesBloc>(context));
            },
            child: BlocBuilder<NewArrivalProductBloc, NewArrivalProductsState>(
                builder: (context, state) {
              switch (state.status) {
                case NewArrivalProductsStatus.success:
                  if (state.products!.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).translate("Empty"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        // padding: const EdgeInsets.only(left: 16),
                        itemCount: state.products!.length > 10
                            ? 10
                            : state.products!.length,
                        itemBuilder: (context, index) {
                          return productCard(state.products![index]);
                        });
                  }
                case NewArrivalProductsStatus.failure:
                  return const Text("Error");
                default:
                  return Center(
                    child: CircularProgressIndicator(
                        color:Color.fromRGBO(255, 76, 59, 1)
                      // color: Theme.of(context).brightness == Brightness.dark
                      //     ? Colors.white
                      //     : Theme.of(context).primaryColor,
                      //  backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                    ),
                  );
              }
            }),
          ),
        )
      ],
    );
  }

  Widget productCard(Product product) {
    return InkWell(
      onTap: () {
        widget.navigateToNext(
          BlocProvider(
              create: (context) =>
                  DetailScreenBloc(RealCartRepo(), RealProductsRepo()),
              child: ProductDetailScreen(product, widget.navigateToNext)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: NetworkImage(
                      "${ApiProvider.imgMediumUrlString}${product.productGallary!.gallaryName!}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.08,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                child: Text(
                  "${product.detail!.first.title}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.gothicA1(
                      color: Theme.of(context).brightness ==
                          Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [


                        Text(
                          "${AppData.currency!.code}${product.productDiscountPrice}",
                          style: GoogleFonts.gothicA1(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFF4C3B),
                            height: 1.5,
                          ),
                          // style: GoogleFonts.lato(
                          //     color: Theme.of(context).brightness ==
                          //         Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                          //     fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 6,),
                        Text(
                          "${AppData.currency!.code}${product.productPrice}",
                          style:GoogleFonts.gothicA1(
                            color: Theme.of(context).brightness ==
                                Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1),
                            fontSize: 12, fontWeight: FontWeight.w600, decoration: TextDecoration
                              .lineThrough,),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 20,
                        ),
                        Text(
                          product.productRating!=null?"${product.productRating!.toStringAsFixed(1)}":"0",
                          style: GoogleFonts.gothicA1(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color:Theme.of(context).brightness ==
                              Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                          Color.fromRGBO(112,112, 112, 1)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // chipList(BuildContext contexts) {
  //   return SizedBox(
  //     height: 50,
  //     child: BlocBuilder<CategoriesBloc, CategoriesState>(
  //         builder: (context, state) {
  //       if (state is CategoriesLoaded) {
  //         final List<Category> parentCategories =
  //             getParentCategories(state.categoriesResponse.data!);
  //         return ListView(
  //           scrollDirection: Axis.horizontal,
  //           shrinkWrap: true,
  //           padding: const EdgeInsets.only(left: 16),
  //           children: parentCategories
  //               .map((category) => _buildChip(category,contexts))
  //               .toList(),
  //         );
  //       } else if (state is CategoriesError) {
  //         return Text(state.error);
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             color: Color.fromRGBO(255, 76, 59, 1),
  //             // color: Colors.white,
  //             // backgroundColor: Theme.of(context).brightness == Brightness.dark
  //             //     ? Theme.of(context).primaryColorLight
  //             //     : Theme.of(context).primaryColor,
  //           ),
  //         );
  //       }
  //     }),
  //   );
  // }

  int selectedId = 1;

  List<Category> getParentCategories(List<Category> data) {
    List<Category> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == null) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

  Widget _buildChip(Category category,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedId = category.id!;
          });
          BlocProvider.of<NewArrivalProductBloc>(context).add(CategoryChanged(selectedId));
        },
        child: Chip(
          side: const BorderSide(width: 2, color: Colors.black),
          backgroundColor:
              selectedId == category.id ? Colors.black : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          label: Text(
            category.name!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selectedId == category.id ? Colors.white : Colors.black,
            ),
          ),
          padding: const EdgeInsets.all(5.0),
        ),
      ),
    );
  }
}
