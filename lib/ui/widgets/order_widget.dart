import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kundol/ui/my_orders.dart';
import 'package:flutter_kundol/ui/review_new_screen%20.dart';
import 'package:flutter_kundol/ui/review_screen.dart';
import 'package:flutter_kundol/ui/track_order_screen.dart';


// class OrderWidget extends StatefulWidget {
//    final OrderProducts ?orderProducts;
//
//    OrderWidget({this.orderProducts});
//
//   @override
//   _OrderWidgetState createState() => _OrderWidgetState();
// }
//
// class _OrderWidgetState extends State<OrderWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 140,
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(widget.orderProducts!.imgUrl!,fit: BoxFit.fill,height: 160,
//                 width: MediaQuery.of(context).size.width*0.4,),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width*0.48,
//               height: 140,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(widget.orderProducts!.description!,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Theme.of(context).brightness ==
//                             Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
//                     ),),
//                   SizedBox(height: 10,),
//                   Row(
//                     children: [
//                       Text("Color : ${widget.orderProducts!.color!}",style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Theme.of(context).brightness==Brightness.dark?
//                             Color.fromRGBO(160, 160, 160, 1):
//                             Color.fromRGBO(112, 112, 112, 1)
//                       ),),
//                       Text(" | ",style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Theme.of(context).brightness==Brightness.dark?
//                           Color.fromRGBO(160, 160, 160, 1):
//                           Color.fromRGBO(112, 112, 112, 1)
//                       ),),
//                       Text("Size : ${widget.orderProducts!.size}",style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Theme.of(context).brightness==Brightness.dark?
//                           Color.fromRGBO(160, 160, 160, 1):
//                           Color.fromRGBO(112, 112, 112, 1)
//                       ),)
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     width: 90,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).brightness==Brightness.dark?
//                           Color.fromRGBO(29, 29, 29, 1):
//                           Color.fromRGBO(240, 240, 240, 1)
//                     ),
//                     child: Text(widget.orderProducts!.status!,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Theme.of(context).brightness==Brightness.dark?
//                           Color.fromRGBO(255, 255, 255, 1):
//                           Color.fromRGBO(0, 0, 0, 1)
//                     ),),
//                   ),
//                   SizedBox(
//                     height: 33,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("\$${widget.orderProducts!.price}",style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Theme.of(context).brightness==Brightness.dark?
//                             Color.fromRGBO(255, 255, 255, 1):
//                             Color.fromRGBO(0, 0, 0, 1)
//                       ),),
//                       InkWell(onTap: (){
//                         widget.orderProducts!.status=="In Delivery"?
//                         Navigator.of(context).push(MaterialPageRoute(builder: (c)=>TrackOrderScreen(widget.orderProducts))):
//                         Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ReviewNewScreen(widget.orderProducts!)));
//                       },
//                           child: Container(
//                             width: 110,
//                             height: 22,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               color: Theme.of(context).brightness==Brightness.dark?
//                                   Color.fromRGBO(255, 255, 255, 1):
//                                   Color.fromRGBO(0, 0, 0, 1)
//                             ),
//                             child: widget.orderProducts!.status=="In Delivery"?
//                             Text("Track Order",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                   color: Theme.of(context).brightness==Brightness.dark?
//                                   Color.fromRGBO(0, 0, 0, 1):
//                                   Color.fromRGBO(255, 255, 255, 1)
//                               ),):Text("Leave Review",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                   color: Theme.of(context).brightness==Brightness.dark?
//                                   Color.fromRGBO(0, 0, 0, 1):
//                                   Color.fromRGBO(255, 255, 255, 1)
//                               ),),
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
