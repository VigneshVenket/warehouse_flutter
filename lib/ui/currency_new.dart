import 'package:flutter/material.dart';


class CurrencyNew extends StatefulWidget {
  const CurrencyNew({Key? key}) : super(key: key);

  @override
  _CurrencyNewState createState() => _CurrencyNewState();
}

class _CurrencyNewState extends State<CurrencyNew> {
  bool isEnableddollar=false;
  bool isEnabledrupee=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
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
            "Currency",style: TextStyle(
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
            ListTile(
              leading: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).brightness==Brightness.dark?isEnableddollar?Color.fromRGBO(255, 255, 255,1):Color.fromRGBO(160, 160, 160, 1):
                    isEnableddollar?
                    Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(112, 112, 112, 1)
                  )
                ),
                child: Theme.of(context).brightness==Brightness.dark?isEnableddollar?
                Image.asset("assets/images/dollar_white_icon-removebg-preview.png",fit: BoxFit.fill,):Image.asset("assets/images/dollar_grey_icon-removebg-preview.png",fit: BoxFit.fill,):
                isEnableddollar?Image.asset("assets/images/dollar_black_icon-removebg-preview.png"):
                Image.asset("assets/images/dollar_grey_icon-removebg-preview.png"),
              ),
              title: Text("Dollar",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color:Theme.of(context).brightness==Brightness.dark?isEnableddollar?Color.fromRGBO(255, 255, 255,1):Color.fromRGBO(160, 160, 160, 1):
                isEnableddollar?
                Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(112, 112, 112, 1)
              ),),
              trailing: isEnableddollar?Icon(Icons.check_box_outlined,
                size: 26,
                color: Color.fromRGBO(255, 76, 59,1),
              ):Icon(Icons.check_box_outline_blank_outlined,
                size: 26,
                color: Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(160, 160, 160, 1):
                Color.fromRGBO(112, 112, 112, 1),
              )
              ,
              onTap: (){
                  setState(() {
                    isEnableddollar=!isEnableddollar;
                  });
              },
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            ListTile(
              leading: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).brightness==Brightness.dark?isEnableddollar?Color.fromRGBO(255, 255, 255,1):Color.fromRGBO(160, 160, 160, 1):
                        isEnableddollar?
                        Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(112, 112, 112, 1)
                    )
                ),
                child: Theme.of(context).brightness==Brightness.dark?isEnabledrupee?
                Image.asset("assets/images/rupee_white_icon-removebg-preview.png",fit: BoxFit.fill,):Image.asset("assets/images/rupee_grey_icon-removebg-preview.png",fit: BoxFit.fill,):
                isEnabledrupee?Image.asset("assets/images/rupee_black_icon-removebg-preview.png"):
                Image.asset("assets/images/rupee_grey_icon-removebg-preview.png"),
              ),
              title: Text("Rupee",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color:Theme.of(context).brightness==Brightness.dark?isEnabledrupee?Color.fromRGBO(255, 255, 255,1):Color.fromRGBO(160, 160, 160, 1):
                  isEnabledrupee?
                  Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(112, 112, 112, 1)
              ),),
              trailing: isEnabledrupee?Icon(Icons.check_box_outlined,
                size: 26,
                color: Color.fromRGBO(255, 76, 59,1),
              ):Icon(Icons.check_box_outline_blank_outlined,
                size: 26,
                color: Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(160, 160, 160, 1):
                Color.fromRGBO(112, 112, 112, 1),
              )
              ,
              onTap: (){
                setState(() {
                  isEnabledrupee=!isEnabledrupee;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


