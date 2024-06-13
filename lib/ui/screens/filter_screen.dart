import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedId = 1;
  int selectedPriceId = 1;

  SfRangeValues _values = const SfRangeValues(40.0, 80.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Filter",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(
            height: 30,
          ),
          toggleSwitch(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 30),
            child: Text(
              "Category",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color:  Colors.black ),
            ),
          ),
          chipList("Category"),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 30),
            child: Text(
              "Price",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color:  Colors.black ),
            ),
          ),

          Container(
            height: 100,
            color: Colors.grey,
            child: SfRangeSliderTheme(
              data: SfRangeSliderThemeData(
                thumbStrokeWidth: 2,
                thumbStrokeColor: Colors.black,
                thumbColor: Colors.white,
                activeTrackHeight: 2,
                inactiveTrackHeight: 2,
                activeTrackColor: Colors.black,
                inactiveTrackColor:const Color(0xFFF0F0F0),
                tooltipBackgroundColor: Colors.black,
                tooltipTextStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600
                ),
              ),
              child: SfRangeSlider(
                min: 0.0,
                max: 100.0,
                values: _values,
                showTicks: false,
                showLabels: false,
                enableTooltip: true,
                shouldAlwaysShowTooltip: true,

                onChanged: (SfRangeValues values){
                  setState(() {
                    _values = values;
                  });
                },
                tooltipTextFormatterCallback: (dynamic,value){
                  double roundedValue = roundToHalf(double.parse(value));
                  return '\$$roundedValue';
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Rating",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color:  Colors.black ),
            ),
          ),
          chipList("price"),
        ],
      ),
    );
  }

  chipList(String type) {
     switch(type){
       case "Category":
         return SizedBox(
           height: 50,
           child: ListView(
             scrollDirection: Axis.horizontal,
             shrinkWrap: true,
             padding: const EdgeInsets.only(left: 16),
             children: <Widget>[
               _buildChip(1, 'All',"Category"),
               _buildChip(2, 'Cloths',"Category"),
               _buildChip(3, 'Electronics',"Category"),
               _buildChip(4, 'Cosmetics',"Category"),
               _buildChip(5, 'Fitness',"Category"),
               _buildChip(6, 'Toys',"Category"),
               _buildChip(7, 'Kitchen',"Category"),
               _buildChip(8, 'Jewelry',"Category"),
               _buildChip(9, 'Musical Instruments',"Category"),
             ],
           ),
         );
       case "price":
         return SizedBox(
           height: 50,
           child: ListView(
             scrollDirection: Axis.horizontal,
             shrinkWrap: true,
             padding: const EdgeInsets.only(left: 16),
             children: <Widget>[
               _buildChip(1, 'All',"price"),
               _buildChip(2, '5',"price"),
               _buildChip(3, '4',"price"),
               _buildChip(4, '3',"price"),
               _buildChip(5, '2',"price"),
               _buildChip(6, '1',"price"),
             ],
           ),
         );
    }
  }

  double roundToHalf(double value) {
    return (value * 2).round() / 2;
  }
  Widget _buildChip(int id, String label, String type) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            if(type=="price"){
              selectedPriceId = id;
            }else{
              selectedId = id;
            }
          });
        },
        child: Chip(
          side: const BorderSide(width: 2, color: Colors.black),
          backgroundColor:type=="price"? selectedPriceId == id ? Colors.black : Colors.transparent : selectedId == id ? Colors.black : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding:  const EdgeInsets.symmetric(horizontal: 10.0),
          label:type=="price"? Row(
            children: [
              const Icon(Icons.star,color: Colors.deepOrange,size: 20,),
              const SizedBox(width: 3,),
              Text(
                label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selectedPriceId == id ? Colors.white : Colors.black),
              ),
            ],
          ): Text(
            label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color:type=="price"?selectedPriceId == id ? Colors.white : Colors.black :selectedId == id ? Colors.white : Colors.black),
          ),
          padding: const EdgeInsets.all(5.0),
        ),
      ),
    );
  }

  int selectedToggleId=1;
  Widget toggleSwitch(){
    return Container(
      height: MediaQuery.of(context).size.height*0.055,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black,width: 2)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          toggleSwitchItem(1,"Sale"),
          toggleSwitchItem(2,"Trending"),
          toggleSwitchItem(3,"New"),
        ],
      ),
    );
  }

  Widget toggleSwitchItem(int id, String title){
    return InkWell(
      onTap: (){
        setState(() {
          selectedToggleId=id;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height*0.045,
        width: MediaQuery.of(context).size.width*0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: selectedToggleId==id? Colors.black:Colors.transparent
        ),
        child: Text(
          title,
          style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selectedToggleId == id ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
