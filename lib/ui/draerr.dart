import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 // double height = 180;
  RangeValues Myheight = const RangeValues(150, 180);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Sheet with slider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                             showModalBottomSheet(
                context: context,
                builder: (BuildContext c) {
                  return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
                    return Container(
                      height: 250,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              height: 180,
                              child: Card(
                               // colors: Colors.accents,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'HEIGHT',
                                      
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        Text(
                                         '${Myheight.start.round().toString()} - ${Myheight.end.round().toString()}',
                                        
                                        ),
                                        Text(
                                          'cm',
                                         
                                        ),
                                      ],
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Colors.pink,
                                        inactiveTrackColor: Color(0xFF8D8E98),
                                        thumbColor: Color(0xFFEB1555),
                                        thumbShape:
                                        RoundSliderThumbShape(enabledThumbRadius: 15),
                                        overlayShape:
                                        RoundSliderOverlayShape(overlayRadius: 30.0),
                                        overlayColor: Color(0x29EB1555),
                                        showValueIndicator: ShowValueIndicator.always,
                                      ),
                                      child: RangeSlider(
                                        values: Myheight,
                                        min: 100,
                                        max: 220,
                                        labels: RangeLabels('${Myheight.start.round()}', '${Myheight.end.round()}'),
                                        // divisions: 10,
                                        onChanged: (RangeValues newValue) {
                                          setState(() {
                                            Myheight = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  },);
                });
              },
              child: Text(" Select Height "),
            ),
          ],
        ),
      ),
    );
  }
}