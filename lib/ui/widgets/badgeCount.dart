import 'package:flutter/material.dart';
import 'package:flutter_kundol/constants/app_cart.dart';

class NamedIcon extends StatefulWidget {
  final IconData iconData;
  final VoidCallback? onTap;
   int? itemsCount;
   NamedIcon({
    Key? key,
    this.onTap,
    required this.iconData,
    this.itemsCount = 0,
  }) : super(key: key);
  @override
  State<NamedIcon> createState() => _NamedIconState();
}

class _NamedIconState extends State<NamedIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          width:50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(widget.iconData,size: 25,),
               //   Text(text, overflow: TextOverflow.ellipsis),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 13,
                  width: 13,
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1.7),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                //  alignment: Alignment.center,
                  child: Center(child: Text('${widget.itemsCount}',style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}