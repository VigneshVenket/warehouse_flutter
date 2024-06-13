import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/reviews/reviews_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/reviews_repo.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/reviews_data.dart';
import '../tweaks/app_localization.dart';
import 'detail_screen.dart';

// const SnackBar _snackBar = SnackBar(
//   content: Text('Add Review Successfully'),
//   duration: Duration(seconds: 5),
// );

class ReviewScreen extends StatefulWidget {

  double ?rating;
  int ?reviews;

  ReviewScreen(this.rating,this.reviews,{super.key});

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<ReviewScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Reviews",
            style: GoogleFonts.gothicA1(
                color:Theme.of(context).brightness ==
                    Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1),
                fontWeight: FontWeight.w800, fontSize: 18),
          ),
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios_new_rounded, color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1),),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          elevation: 0.0,
        ),
        body: BlocBuilder<ReviewsBloc, ReviewsState>(
          builder: (context, state) {
            if (state is ReviewsLoaded) {
              print(state.reviewsData[0].date);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Divider(height: 1,),
                  // const SizedBox(height: 10,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16.0),
                  //   child: Text(
                  //     "${widget.rating} (${widget.reviews} reviews)",
                  //     style: GoogleFonts.spaceGrotesk(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10,),
                  // ratingHeadWidget(),
                  // const SizedBox(height: 10,),
                  // const Divider(height: 1,),
                  state.reviewsData.isNotEmpty? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.reviewsData.length,
                        itemBuilder: (context,index) {
                          return reviewWidget(state.reviewsData[index]);
                        }
                    ),
                  ):const Center(child: Text("No reviews")),
                  Divider(thickness: 1.5,)
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 20),
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 130,
                  //         height: 130,
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             const Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                   "3.00",
                  //                   style: TextStyle(fontSize: 18),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 4,
                  //                 ),
                  //                 Icon(
                  //                   Icons.star,
                  //                   size: 22,
                  //                 ),
                  //               ],
                  //             ),
                  //             Text(
                  //               AppLocalizations.of(context)!
                  //                   .translate("rating"),
                  //               style: TextStyle(
                  //                   fontSize: 18,
                  //                   color: Theme.of(context).primaryColor),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         width: 1,
                  //         height: 110,
                  //         color: Colors.grey,
                  //       ),
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 130,
                  //           width: double.maxFinite,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Row(
                  //                 children: [
                  //                   SizedBox(
                  //                     width: 8,
                  //                   ),
                  //                   Text("1"),
                  //                   Icon(
                  //                     Icons.star,
                  //                     size: 16,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                   Expanded(
                  //                     child: LinearProgressIndicator(
                  //                       minHeight: 7,
                  //                       valueColor:
                  //                           AlwaysStoppedAnimation<Color>(
                  //                         Colors.amber,
                  //                       ),
                  //                       backgroundColor: Theme.of(context)
                  //                                   .brightness ==
                  //                               Brightness.dark
                  //                           ? Theme.of(context)
                  //                               .primaryColorLight
                  //                           : Theme.of(context).primaryColor,
                  //                       value: 0.1,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(
                  //                 height: 4,
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   SizedBox(
                  //                     width: 8,
                  //                   ),
                  //                   Text("2"),
                  //                   Icon(
                  //                     Icons.star,
                  //                     size: 16,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                   Expanded(
                  //                     child: LinearProgressIndicator(
                  //                       minHeight: 7,
                  //                       valueColor:
                  //                           AlwaysStoppedAnimation<Color>(
                  //                         Colors.amber,
                  //                       ),
                  //                       backgroundColor: Theme.of(context)
                  //                                   .brightness ==
                  //                               Brightness.dark
                  //                           ? Theme.of(context)
                  //                               .primaryColorLight
                  //                           : Theme.of(context).primaryColor,
                  //                       value: 0.2,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(
                  //                 height: 4,
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   SizedBox(
                  //                     width: 8,
                  //                   ),
                  //                   Text("3"),
                  //                   Icon(
                  //                     Icons.star,
                  //                     size: 16,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                   Expanded(
                  //                     child: LinearProgressIndicator(
                  //                       minHeight: 7,
                  //                       valueColor:
                  //                           AlwaysStoppedAnimation<Color>(
                  //                         Colors.amber,
                  //                       ),
                  //                       backgroundColor: Theme.of(context)
                  //                                   .brightness ==
                  //                               Brightness.dark
                  //                           ? Theme.of(context)
                  //                               .primaryColorLight
                  //                           : Theme.of(context).primaryColor,
                  //                       value: 0.3,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(
                  //                 height: 4,
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   SizedBox(
                  //                     width: 8,
                  //                   ),
                  //                   Text("4"),
                  //                   Icon(
                  //                     Icons.star,
                  //                     size: 16,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                   Expanded(
                  //                     child: LinearProgressIndicator(
                  //                       minHeight: 7,
                  //                       valueColor:
                  //                           AlwaysStoppedAnimation<Color>(
                  //                         Colors.amber,
                  //                       ),
                  //                       backgroundColor: Theme.of(context)
                  //                                   .brightness ==
                  //                               Brightness.dark
                  //                           ? Theme.of(context)
                  //                               .primaryColorLight
                  //                           : Theme.of(context).primaryColor,
                  //                       value: 0.4,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(
                  //                 height: 4,
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   SizedBox(
                  //                     width: 8,
                  //                   ),
                  //                   Text("5"),
                  //                   Icon(
                  //                     Icons.star,
                  //                     size: 16,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                   Expanded(
                  //                     child: LinearProgressIndicator(
                  //                       minHeight: 7,
                  //                       valueColor:
                  //                           AlwaysStoppedAnimation<Color>(
                  //                         Colors.amber,
                  //                       ),
                  //                       backgroundColor: Theme.of(context)
                  //                                   .brightness ==
                  //                               Brightness.dark
                  //                           ? Theme.of(context)
                  //                               .primaryColorLight
                  //                           : Theme.of(context).primaryColor,
                  //                       value: 0.5,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 4,
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(
                  //                 height: 4,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(
                  //       horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  //   height: 45.0,
                  //   width: double.maxFinite,
                  //   child: ElevatedButton(
                  //       style: ButtonStyle(
                  //           shape: MaterialStateProperty.all<
                  //               RoundedRectangleBorder>(RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(40.0),
                  //       ))),
                  //       onPressed: () {
                  //         showReviewDialog();
                  //       },
                  //       child: Text(AppLocalizations.of(context)!
                  //           .translate("Write a Review")!)),
                  // ),
                  //
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Expanded(
                  //   child: (state.reviewsData.isEmpty)
                  //       ? Container(
                  //           child: Center(
                  //             child: Text(AppLocalizations.of(context)!
                  //                 .translate("Empty")!),
                  //           ),
                  //         )
                  //       : ListView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: state.reviewsData.length,
                  //           itemBuilder: (context, index) =>
                  //               //     ListTile(
                  //               //   title: Text(state
                  //               //           .reviewsData[index].customer.customerFirstName +
                  //               //       " " +
                  //               //       state.reviewsData[index].customer.customerLastName),
                  //               //   titleMedium: Text(state.reviewsData[index].comment),
                  //               //   leading: Container(
                  //               //     width: 50.0,
                  //               //     height: 50.0,
                  //               //     decoration: new BoxDecoration(shape: BoxShape.circle),
                  //               //     child: ClipRRect(
                  //               //       borderRadius: BorderRadius.circular(50.0),
                  //               //       child: CachedNetworkImage(
                  //               //         imageUrl:
                  //               //             "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                  //               //         fit: BoxFit.fill,
                  //               //         progressIndicatorBuilder:
                  //               //             (context, url, downloadProgress) =>
                  //               //                 CircularProgressIndicator(
                  //               //                     value: downloadProgress.progress),
                  //               //         errorWidget: (context, url, error) =>
                  //               //             Icon(Icons.error),
                  //               //       ),
                  //               //     ),
                  //               //   ),
                  //               //   trailing: StarRating(
                  //               //       starCount: 5,
                  //               //       rating: double.parse(state.reviewsData[index].rating),
                  //               //       onRatingChanged: (rating) {}),
                  //               // ),
                  //               Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 14, vertical: 10),
                  //             color: Theme.of(context).brightness ==
                  //                     Brightness.dark
                  //                 ? Theme.of(context).cardColor
                  //                 : Colors.white,
                  //             child: Row(
                  //               children: [
                  //                 Container(
                  //                   width: 50.0,
                  //                   height: 50.0,
                  //                   decoration: const BoxDecoration(
                  //                       shape: BoxShape.circle),
                  //                   child: ClipRRect(
                  //                     borderRadius: BorderRadius.circular(50.0),
                  //                     child: CachedNetworkImage(
                  //                       imageUrl:
                  //                           "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                  //                       fit: BoxFit.fill,
                  //                       progressIndicatorBuilder: (context, url,
                  //                               downloadProgress) =>
                  //                           CircularProgressIndicator(
                  //                               backgroundColor:
                  //                                   Theme.of(context)
                  //                                               .brightness ==
                  //                                           Brightness.dark
                  //                                       ? Theme.of(context)
                  //                                           .primaryColorLight
                  //                                       : Theme.of(context)
                  //                                           .primaryColor,
                  //                               value:
                  //                                   downloadProgress.progress),
                  //                       errorWidget: (context, url, error) =>
                  //                           const Icon(Icons.error),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Expanded(
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Container(
                  //                         child: Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text(
                  //                                 "${state.reviewsData[index].customer?.customerFirstName} ${state.reviewsData[index].customer?.customerLastName}"),
                  //                             Container(
                  //                               child: StarRating(
                  //                                 starCount: 5,
                  //                                 rating: double.parse(state
                  //                                     .reviewsData[index]
                  //                                     .rating!),
                  //                                 onRatingChanged: (rating) {},
                  //                                 color: Colors.black12,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 4,
                  //                       ),
                  //                       Text(state.reviewsData[index].comment!),
                  //                       const Divider(),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(
                  //       vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                  //       horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  //   height: 45.0,
                  //   width: double.maxFinite,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         showReviewDialog();
                  //       },
                  //       child: Text("Write a Review")),
                  // ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                    color:  Color.fromRGBO(255, 76, 59, 1)
                ),
              );
            }
          },
        ));
  }

  Widget reviewWidget(ReviewsData reviewsData) {
    return Column(
      children: [
        Container(
          color:Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(0,0,0,1):Color.fromRGBO(255, 255, 255,1),
          // height: MediaQuery.of(context).size.height * 0.17,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  horizontalTitleGap: 10,
                  // leading: Container(
                  //   height: 50,
                  //   width: 50,
                  //   // decoration: const BoxDecoration(
                  //   //     shape: BoxShape.circle,
                  //   //     color: Colors.grey,
                  //   //     image: DecorationImage(image: NetworkImage("")
                  //   //     )
                  //   // ),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.grey
                  //   ),
                  // ),
                  title: Text(
                    "${reviewsData.customer!.customerFirstName} ${reviewsData.customer!.customerLastName}",
                    style: GoogleFonts.gothicA1(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:Theme.of(context).brightness ==
                          Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1),
                    ),
                  ),
                  // titleMedium: Row(
                  //   children: [
                  //     AbsorbPointer(
                  //       absorbing: true,
                  //       child: RatingBar(
                  //         initialRating:double.parse(reviewsData.rating!),
                  //         direction: Axis.horizontal,
                  //         allowHalfRating: true,
                  //         itemCount: 5,
                  //         itemSize: 16,
                  //         ratingWidget: RatingWidget(
                  //           full: const Icon(
                  //             Icons.star,
                  //             size: 20,
                  //             color: Colors.deepOrange,
                  //           ),
                  //           half: const Icon(
                  //             Icons.star_half,
                  //             size: 20,
                  //             color: Colors.deepOrange,
                  //           ),
                  //           empty: const Icon(
                  //             Icons.star_border,
                  //             size: 20,
                  //             color: Colors.deepOrange,
                  //           ),
                  //         ),
                  //         itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  //         glow: true,
                  //         glowColor: Colors.deepOrange,
                  //         onRatingUpdate: (rating) {
                  //           print(rating);
                  //         },
                  //         maxRating: 5,
                  //         ignoreGestures: false,
                  //         tapOnlyMode: false,
                  //         updateOnDrag: false,
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 8.0),
                  //       child: Text(
                  //         reviewsData.date!,
                  //         style: GoogleFonts.gothicA1(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w500,
                  //           color:Theme.of(context).brightness ==
                  //               Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // trailing: Container(
                  //   height: 25,
                  //   width: 25,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       border: Border.all(color: Colors.black, width: 2)),
                  //   child: const Icon(
                  //     Icons.more_horiz,
                  //     size: 20,
                  //   ),
                  // ),
                ),
              ),
              Text(
                reviewsData.comment!=null?
                "${reviewsData.comment}":"Comment not added by the user",
                style: GoogleFonts.gothicA1(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:Theme.of(context).brightness ==
                        Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1),
                    height: 1.8),
              ),
              // Row(
              //   children: [
              //     Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         "Was this review helpful?",
              //         style: GoogleFonts.lato(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w500,
              //             color: Colors.black,
              //             height: 1.8),
              //       ),
              //     ),
              //     const SizedBox(width: 30,),
              //     TextButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(Icons.thumb_up_alt_outlined,color:Color(0xFF4ADE80),),
              //       label: Text(
              //         "369",
              //         style: GoogleFonts.lato(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w500,
              //             color: const Color(0xFF707070),
              //             height: 1.8),
              //       ),
              //     ),
              //     TextButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(Icons.thumb_down_alt_outlined,color:Color(0xFFED0006),),
              //       label: Text(
              //         "369",
              //         style: GoogleFonts.lato(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w500,
              //             color: const Color(0xFF707070),
              //             height: 1.8),
              //       ),
              //     )
              //   ],
              // ),
              // const Divider(
              //   height: 1,
              // ),
            ],
          ),
        ),
        Divider(color:Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(160,160, 160, 1):
        Color.fromRGBO(112,112, 112, 1),),
      ],
    );
  }



  Widget ratingHeadWidget(){
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 16),
        children: <Widget>[
          _buildChip(0, 'All',"price"),
          _buildChip(5, '5',"price"),
          _buildChip(4, '4',"price"),
          _buildChip(3, '3',"price"),
          _buildChip(2, '2',"price"),
          _buildChip(1, '1',"price"),
        ],
      ),
    );
  }

  Widget _buildChip(int id, String label, String type) {
    bool chipFilterbg=false;
    Color bgColor=Colors.transparent;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          chipFilterbg=!chipFilterbg;
          setState(() {
            chipFilterbg?bgColor=Colors.black:bgColor=Colors.transparent;
          });
          print(chipFilterbg);
          // BlocProvider.of<ReviewsBloc>(context).add(GetReviews(widget.productId,id));
          // setState(() {
          //
          // });

        },
        child: Chip(
          side: const BorderSide(width: 2, color: Colors.black),
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding:  const EdgeInsets.symmetric(horizontal: 10.0),
          label: Row(
            children: [
              const Icon(Icons.star,color: Colors.deepOrange,size: 20,),
              const SizedBox(width: 3,),
              Text(
                label,
                style:TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: chipFilterbg?Colors.white:Colors.black,
                ),
              ),
            ],
          ),
          padding: const EdgeInsets.all(5.0),
        ),
      ),
    );
  }


// void showReviewDialog() {
//   Dialog ratingDialog = Dialog(
//     //this right here
//     child: BlocProvider(
//         create: (context) => ReviewsBloc(RealReviewsRepo()),
//         child: RatingDialogBody(
//           context: context,
//           productId: widget.productId,
//         )),
//   );
//   showDialog(
//       context: context, builder: (BuildContext context) => ratingDialog);
// }
}

class RatingDialogBody extends StatefulWidget {
  const RatingDialogBody({
    Key? key,
    required this.context,
    required this.productId,
  }) : super(key: key);

  final BuildContext context;
  final int? productId;

  @override
  _RatingDialogBodyState createState() => _RatingDialogBodyState();
}

class _RatingDialogBodyState extends State<RatingDialogBody> {
  double rating = 0.0;

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate("Your Rating")!),
                StarRating(
                  starCount: 5,
                  rating: rating,
                  onRatingChanged: (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  },
                  color: Colors.black12,
                ),
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            TextField(
              minLines: 5,
              maxLines: null,
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? AppStyles.COLOR_LITE_GREY_DARK
                      : AppStyles.COLOR_LITE_GREY_LIGHT,
                  filled: true,
                  // border: InputBorder.none,
                  hintText:
                  AppLocalizations.of(context)!.translate("Your comment")!,
                  hintStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                      fontSize: 14)),
            ),
            const SizedBox(
              height: 6.0,
            ),
            SizedBox(
              height: 45.0,
              width: double.maxFinite,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ))),
                  onPressed: () {
                    if (_messageController!.text.isNotEmpty) {
                      BlocProvider.of<ReviewsBloc>(context).add(AddReviews(
                          widget.productId!,
                          _messageController!.text,
                          rating,
                          null));
                      // ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    }
                  },
                  child: Text(
                      AppLocalizations.of(context)!.translate("Add Review")!)),
            ),
          ],
        ),
      ),
    );
  }
}
