import 'package:flutter/material.dart';
import 'package:flutter_kundol/models/orders_data.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/ui/fav_fragment.dart';



class CardStyleNew extends StatefulWidget {
  final FavProducts ?product;

  CardStyleNew({this.product});

  @override
  _CardStyleNewState createState() => _CardStyleNewState();
}

class _CardStyleNewState extends State<CardStyleNew> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.product!.imgUrl!,
                    width: 165,
                    height: 120,
                    fit: BoxFit.fill,
                  )),
              Positioned(
                left: 133,
                top: 5,
                child: Container(
                  width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness==Brightness.dark?
                      Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1)
                    ),
                    child: Icon(Icons.favorite,size: 18,color: Color.fromRGBO(255, 76, 59, 1),)),
              )

            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.product!.description!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).brightness ==
                    Brightness.dark?Color.fromRGBO(255, 255,255, 1):Color.fromRGBO(0, 0, 0,1)
            ),),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$ ${widget.product!.price}",
                style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness ==
                    Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                Color.fromRGBO(0, 0, 0, 1)
              ),),
              Row(
                children: [
                  Icon(Icons.star,size: 18,color: Color.fromRGBO(255, 76, 59, 1),),
                  SizedBox(width: 5,),
                  Text("${widget.product!.rating}",style: TextStyle(
                    fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color:Theme.of(context).brightness ==
                          Brightness.dark?Color.fromRGBO(160,160, 160, 1):
                      Color.fromRGBO(112,112, 112, 1)
                  ),)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


class FavProducts{
  String ?imgUrl;
  String ?description;
  double ?price;
  double ?rating;

  FavProducts({
    this.imgUrl,
    this.description,
    this.price,
    this.rating
  });

}
