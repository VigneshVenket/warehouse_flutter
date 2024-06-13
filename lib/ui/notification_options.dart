import 'package:flutter/material.dart';


class NotificationOptions extends StatefulWidget {
  const NotificationOptions({Key? key}) : super(key: key);

  @override
  _NotificationOptionsState createState() => _NotificationOptionsState();
}

class _NotificationOptionsState extends State<NotificationOptions> {
  bool toggle1=false;
  bool toggle2=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Notification Options",style: TextStyle(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w900
          ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SwitchListTile(
                value: toggle1,
                inactiveTrackColor: Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),
                trackOutlineColor:Theme.of(context).brightness == Brightness.dark?
                MaterialStatePropertyAll(Color.fromRGBO(160, 160, 160, 1)):
                MaterialStatePropertyAll(Color.fromRGBO(112, 112, 112, 1)),
                thumbColor: MaterialStatePropertyAll(Color.fromRGBO(240, 240, 240, 1)),
                activeColor: Color.fromRGBO(74, 222, 128, 1.0),
                title: Text("General Notification",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color:Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                ),),
                onChanged: (value){
                   setState(() {
                     toggle1=value;
                   });
                }),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            SwitchListTile(
                value:toggle2,
                inactiveTrackColor: Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1),
                trackOutlineColor: Theme.of(context).brightness == Brightness.dark?
                MaterialStatePropertyAll(Color.fromRGBO(160, 160, 160, 1)):
                MaterialStatePropertyAll(Color.fromRGBO(112, 112, 112, 1)),
                thumbColor: MaterialStatePropertyAll(Color.fromRGBO(240, 240, 240, 1)),
                activeColor: Color.fromRGBO(74, 222, 128, 1.0),
                title: Text("Sound",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color:Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                ),),
                onChanged: (value){
                  setState(() {
                      toggle2=value;
                  });
                })
          ],
        ),
      ),

    );
  }
}
