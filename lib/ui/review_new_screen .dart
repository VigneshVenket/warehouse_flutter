import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/reviews/reviews_bloc.dart';
import 'package:flutter_kundol/ui/my_orders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../api/api_provider.dart';
import '../blocs/detail_screen/detail_screen_bloc.dart';
import '../constants/app_constants.dart';
import '../constants/app_data.dart';
import '../constants/app_styles.dart';
import '../models/orders_data.dart';



class ReviewNewScreen extends StatefulWidget {
  final int productId;
  Product product;
  String orderstatus;
  String orderdate;
  String productQty;

  ReviewNewScreen(this.productId,this.product,this.orderstatus,this.orderdate,this.productQty);

  @override
  _ReviewNewScreenState createState() => _ReviewNewScreenState();
}

class _ReviewNewScreenState extends State<ReviewNewScreen> {
   double rating=0;
   TextEditingController commentController=TextEditingController();

   @override
  void initState() {
    // TODO: implement initState
     BlocProvider.of<DetailScreenBloc>(context)
         .add(GetProductById(widget.product.productId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String originalDateString=widget.orderdate.substring(0,8);
    DateTime originalDate = DateFormat("dd/MM/yy").parse(originalDateString);
    String formattedDate = DateFormat("dd-MM-yy").format(originalDate);

    double subtotal = 0;
    double orderTotal = 0;

    subtotal += (double.parse(widget.product!.productDiscountPrice.toString()) *
        int.parse(widget.productQty));
    print(subtotal);
    orderTotal = subtotal;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Leave A Review",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),

      body: BlocListener<ReviewsBloc,ReviewsState>(
        listener: (context,state) {
          if(state is ReviewsAdded){
            commentController.clear();
            rating=0;
            AppConstants.showMessage(context,"Review added successfully",Colors.green);

            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Review added Successfully")));
          }else if(state is ReviewsError){
            commentController.clear();
            rating=0;
            AppConstants.showMessage(context,state.error,Colors.red);

            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(state.error)));
          }
        },
          child :SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                              CachedNetworkImage(
                                imageUrl: ApiProvider.imgMediumUrlString + widget.product.productGallary!.gallaryName!,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        color: Color.fromRGBO(255, 76, 59, 1),
                                        value: downloadProgress.progress)),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.48,
                              height: 150,
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(widget.product.detail![0].title!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                    ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text( "Order Date : "+formattedDate,
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                    ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text( "Qty : "+widget.productQty,
                                    style: GoogleFonts.gothicA1(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness ==
                                            Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
                                    ),),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(AppData.currency!.code !+
                                          double.parse(widget.product.productDiscountPrice.toString()).toStringAsFixed(2),style: GoogleFonts.gothicA1(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(255, 76, 59, 1)
                                      ),),
                                      SizedBox(width: 6,),
                                      Text(AppData.currency!.code !+
                                          double.parse(widget.product.productPrice.toString()).toStringAsFixed(2),style: GoogleFonts.gothicA1(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):
                                          Color.fromRGBO(0, 0, 0, 1),
                                          decoration: TextDecoration.lineThrough
                                      ),),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    Divider(
                    thickness: 2,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(29, 29, 29, 1):Color.fromRGBO(240, 240, 240, 1)
                  ),
                  BlocBuilder<ReviewsBloc,ReviewsState>(
                    builder: (context,state) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text("How is the Product?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.gothicA1(
                                  color: Theme.of(context).brightness==Brightness.dark?
                                  Color.fromRGBO(255, 255, 255, 1):
                                  Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700
                              ),),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Please leave a review",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gothicA1(
                                color: Theme.of(context).brightness==Brightness.dark?
                                Color.fromRGBO(112, 112, 112, 1):
                                Color.fromRGBO(120, 120, 120, 1),
                                fontWeight:FontWeight.w600,
                                fontSize: 16
                            ),),
                          SizedBox(
                            height: 10,
                          ),
                          SmoothStarRating(
                            onRatingChanged: (v){
                              setState(() {
                                rating=v;
                              });
                            },
                            starCount: 5,
                            size: 40,
                            allowHalfRating: true,
                            rating: rating,
                            color: Color.fromRGBO(255, 76, 59, 1),
                            borderColor: Color.fromRGBO(255, 76, 59, 1),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.95,
                            height: MediaQuery.of(context).size.height*0.26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(29, 29, 29, 1):Color.fromRGBO(240, 240, 240, 1),
                            ),

                            child: Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    height: MediaQuery.of(context).size.height*0.2,
                                    color: Theme.of(context).brightness==Brightness.dark?
                                    Color.fromRGBO(29, 29, 29, 1):Color.fromRGBO(240, 240, 240, 1),
                                    child: TextField(
                                      cursorColor:Color.fromRGBO(255, 76, 59, 1),
                                      controller: commentController,
                                      style: GoogleFonts.gothicA1(
                                          color: Theme.of(context).brightness==Brightness.dark?
                                          Color.fromRGBO(255, 255, 255, 1):
                                          Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w600
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        fillColor: Theme.of(context).brightness ==
                                            Brightness.dark
                                            ?  Color.fromRGBO(29, 29, 29, 1)
                                            : Color.fromRGBO(240, 240, 240, 1),
                                        filled: true,
                                        hintText:"Your Comment",
                                        hintStyle: GoogleFonts.gothicA1(
                                            color: Theme.of(context).brightness ==
                                                Brightness.dark
                                                ? AppStyles.COLOR_GREY_DARK
                                                : AppStyles.COLOR_GREY_LIGHT,
                                            fontSize: 16),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 170,
                                height: 50,
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                    style: TextButton.styleFrom(
                                        backgroundColor:Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
                                        ,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                    child:Text("Cancel",style: GoogleFonts.gothicA1(
                                        color: Theme.of(context).brightness==Brightness.dark?
                                        Color.fromRGBO(18, 18, 18, 1):
                                        Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700
                                    ),)),
                              ),
                              SizedBox(
                                width: 170,
                                height: 50,
                                child: TextButton(onPressed: (){
                                  if(commentController!.text.isNotEmpty) {
                                    BlocProvider.of<ReviewsBloc>(context).add(AddReviews(widget.productId!, commentController.text, rating,"Product Review"));
                                  }
                                },
                                    style: TextButton.styleFrom(
                                        backgroundColor:Color.fromRGBO(255, 76, 59, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )),
                                    child:Text("Submit",style: GoogleFonts.gothicA1(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700
                                    ),)),
                              ),

                            ],
                          )
                        ],
                      );
                    }
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
