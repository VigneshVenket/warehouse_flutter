import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplOffersScreen extends StatefulWidget {
  const SplOffersScreen({super.key});

  @override
  State<SplOffersScreen> createState() => _SplOffersScreenState();
}

class _SplOffersScreenState extends State<SplOffersScreen> {


  List<String> offerContent=["30% OFF","20% OFF","10% OFF","5% OFF"];

 int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context,index){
          final PageController  _pageController = PageController(initialPage: 0);
          return offerWidget(_pageController);
        },
      ),
    );
  }

  Widget offerWidget(PageController controller){
    return Container(
      height:MediaQuery.of(context).size.height*0.215,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller:controller,
            scrollDirection: Axis.horizontal,
            itemCount: offerContent.length,
            padEnds: false,
            allowImplicitScrolling: false,
            pageSnapping: false,
            itemBuilder: (context,index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    offerContent[index].toString(),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                    const SizedBox(height: 10,),
                  Text(
                    "Today’s Special!",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    "Get discount for every order.\nOnly valid for today",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF707070),
                    ),
                  ),
                  const SizedBox(height: 5,),

                ],
              );
            }
          ),
          Align(
            alignment: const Alignment(0,1),
            child: SmoothPageIndicator(
              controller: controller,
              count: offerContent.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                dotColor: Color(0xFF707070),
                activeDotColor: Color(0xFF707070),
                strokeWidth: 1,
                expansionFactor: 3,
                paintStyle:  PaintingStyle.fill,
              ),
              onDotClicked: (index){
                setState(() {
                  currentIndex = index;
                });
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int getCurrentPage(PageController controller) {
    if (controller.positions.isNotEmpty) {
      // Access the position information when it's available
      return controller.page?.round() ?? 0;
    } else {
      // Default value when positions are not available
      return 0;
    }
  }



}
