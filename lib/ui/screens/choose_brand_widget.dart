import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseBrandWidget extends StatefulWidget {
  const ChooseBrandWidget({super.key});

  @override
  State<ChooseBrandWidget> createState() => _ChooseBrandWidgetState();
}

class _ChooseBrandWidgetState extends State<ChooseBrandWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose Brands",
                maxLines: 4,
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 18, fontWeight: FontWeight.w700,color: Colors.black),
              ),

              Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new,color: Color(0xFF707070),size: 20,), label:Text(
                    "View All",
                    maxLines: 4,
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.w600,color: const Color(0xFF707070)),
                  ), ))
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.16,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 8),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
              itemBuilder: (context,index){
            return Container(
              height: MediaQuery.of(context).size.height*0.2,
              width: MediaQuery.of(context).size.width/3,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(4),
                      image: const DecorationImage(
                        image: NetworkImage("https://banner2.cleanpng.com/20180711/jfx/kisspng-samsung-electronics-logo-business-samsung-5b466e4f50eac8.7795341715313424153315.jpg"),
                        fit: BoxFit.contain,
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
          }),
        )
      ],
    );
  }
}
