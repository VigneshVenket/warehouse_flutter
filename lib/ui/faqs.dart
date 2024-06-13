import 'package:flutter/material.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {

  bool isadded1=false;
  bool isadded2=false;
  bool isadded3=false;
  bool isadded4=false;
  bool isadded5=false;

  bool isOpened1=false;
  bool isOpened2=false;
  bool isOpened3=false;
  bool isOpened4=false;

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
            "FAQs",style: TextStyle(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w900
          ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Refund Status: Common Questions",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isadded1?Color.fromRGBO(255, 76, 59, 1):
                Theme.of(context).brightness==Brightness.dark?
                Color.fromRGBO(255, 255, 255, 1):
                Color.fromRGBO(0, 0, 0, 1)
              ),
        ),
              trailing:isadded1?
              Icon(Icons.remove,
                  size: 20,
                  color:Color.fromRGBO(255, 76, 59, 1)
              ):
              Icon(Icons.add,
                  size: 20,
                  color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),
              onTap: (){
                setState(() {
                  isadded1=true;
                });
              },
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            isadded1?Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("How can I submit a refund request?",style: TextStyle(
                              color: isOpened1?Color.fromRGBO(255, 76, 59, 1):
                              Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),),
                          IconButton(
                              icon:Icon(Icons.keyboard_arrow_up_outlined),
                              onPressed: () {
                                setState(() {
                                  isOpened1=!isOpened1;
                                });
                              },),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    isOpened1?Padding(
                      padding: const EdgeInsets.only(left: 14.0,right: 11.5),
                      child: Text("Refund requests are submitted immediately to your payment processor or financial institution after Udemy has received and processed your request. It may take 5 to 10 business days or longer to post the funds in your account, depending on your financial institution or location.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).brightness==Brightness.dark?
                            Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                        ),
                      ),
                    ):SizedBox()
                  ],
                ),
                Divider(thickness: .8,endIndent: 20.0,indent: 15,),
              ],
            ):SizedBox(),
            isadded1?Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("When will I receive my refund?",style: TextStyle(
                              color: isOpened2?Color.fromRGBO(255, 76, 59, 1):
                              Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          IconButton(
                            icon:Icon(Icons.keyboard_arrow_up_outlined),
                            onPressed: () {
                              setState(() {
                                isOpened2=!isOpened2;
                              });
                            },),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    isOpened2?Padding(
                      padding: const EdgeInsets.only(left: 14.0,right: 11.5),
                      child: Text("Refund requests are submitted immediately to your payment processor or financial institution after Udemy has received and processed your request. It may take 5 to 10 business days or longer to post the funds in your account, depending on your financial institution or location.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).brightness==Brightness.dark?
                            Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                        ),
                      ),
                    ):SizedBox()
                  ],
                ),
                Divider(thickness: .8,endIndent: 20.0,indent: 15,),
              ],
            ):SizedBox(),
            isadded1?Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Why was my refund request denied?",style: TextStyle(
                              color: isOpened3?Color.fromRGBO(255, 76, 59, 1):
                              Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          IconButton(
                            icon:Icon(Icons.keyboard_arrow_up_outlined),
                            onPressed: () {
                              setState(() {
                                isOpened3=!isOpened3;
                              });
                            },),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    isOpened3?Padding(
                      padding: const EdgeInsets.only(left: 14.0,right: 11.5),
                      child: Text("Refund requests are submitted immediately to your payment processor or financial institution after Udemy has received and processed your request. It may take 5 to 10 business days or longer to post the funds in your account, depending on your financial institution or location.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).brightness==Brightness.dark?
                            Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                        ),
                      ),
                    ):SizedBox()
                  ],
                ),
                Divider(thickness: .8,endIndent: 20.0,indent: 15,),
              ],
            ):SizedBox(),
            isadded1?Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("What is a “credit refund”?",style: TextStyle(
                              color: isOpened4?Color.fromRGBO(255, 76, 59, 1):
                              Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(255, 255, 255, 1):
                              Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          IconButton(
                            icon:Icon(Icons.keyboard_arrow_up_outlined),
                            onPressed: () {
                              setState(() {
                                isOpened4=!isOpened4;
                              });
                            },),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    isOpened4?Padding(
                      padding: const EdgeInsets.only(left: 14.0,right: 11.5),
                      child: Text("Refund requests are submitted immediately to your payment processor or financial institution after Udemy has received and processed your request. It may take 5 to 10 business days or longer to post the funds in your account, depending on your financial institution or location.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).brightness==Brightness.dark?
                            Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                        ),
                      ),
                    ):SizedBox()
                  ],
                ),
                Divider(thickness: .8,endIndent: 20.0,indent: 15,),
              ],
            ):SizedBox(),
            ListTile(
              title: Text("Payment Methods on Zoop Store",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isadded2?Color.fromRGBO(255, 76, 59, 1):
                  Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),),
              trailing:isadded2?
              Icon(Icons.remove,
                  size: 20,
                  color:Color.fromRGBO(255, 76, 59, 1)
              ):
              Icon(Icons.add,
                  size: 20,
                  color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),
              onTap: (){
                setState(() {
                  isadded2=true;
                });
              },
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            ListTile(
              title: Text("How to Find Your Missing Product",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isadded3?Color.fromRGBO(255, 76, 59, 1):
                  Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),),
              trailing:isadded3?
              Icon(Icons.remove,
                  size: 20,
                  color:Color.fromRGBO(255, 76, 59, 1)
              ):
              Icon(Icons.add,
                  size: 20,
                  color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),
              onTap: (){
                setState(() {
                  isadded3=true;
                });
              },
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            ListTile(
              title: Text("How to Refund a Product",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isadded4?Color.fromRGBO(255, 76, 59, 1):
                  Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),),
              trailing:isadded4?
              Icon(Icons.remove,
                  size: 20,
                  color:Color.fromRGBO(255, 76, 59, 1)
              ):
              Icon(Icons.add,
                  size: 20,
                  color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),
              onTap: (){
                setState(() {
                  isadded4=true;
                });
              },
            ),
            Divider(thickness: .8,endIndent: 20.0,indent: 15,),
            ListTile(
              title: Text("Downloading Payment Invoice",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isadded5?Color.fromRGBO(255, 76, 59, 1):
                  Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),),
              trailing:isadded5?
              Icon(Icons.remove,
                  size: 20,
                  color:Color.fromRGBO(255, 76, 59, 1)
              ):
              Icon(Icons.add,
                  size: 20,
                  color: Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(255, 255, 255, 1):
                  Color.fromRGBO(0, 0, 0, 1)
              ),
              onTap: (){
                setState(() {
                  isadded5=true;
                });
              },
            ),
        
          ],
        ),
      ),
    );
  }
}
