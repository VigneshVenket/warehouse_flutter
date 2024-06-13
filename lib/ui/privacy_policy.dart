import 'package:flutter/material.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
            "Privacy Policy",style: TextStyle(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w900
          ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Egestas nunc neque sed lobortis tellus, sociis justo felis. Id amet orci auctor diam dolor et metus. Fringilla nulla mauris fermentum, nisl diam diam. Urna maecenas id non enim massa id quis magna. Vulputate sapien elit habitasse elementum nibh aliquam sed. Nisi aliquet mus commodo interdum nisi, faucibus. Aliquet lectus ipsum massa viverra urna egestas.",
                   style: TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 14,
                       color: Theme.of(context).brightness==Brightness.dark?
                       Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                   ),
                   ),
              SizedBox(
                height: 5,
              ),
              Text("Libero vulputate porta nisl tortor vitae. Proin pellentesque parturient ac euismod tortor malesuada pellentesque. Turpis leo blandit tristique eu phasellus viverra.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("User Information",style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness==Brightness.dark?
                      Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
              ),),
              SizedBox(
                height: 10,
              ),
              Text("Nisl porttitor amet vulputate quis eget eu urna. Et tempus tellus arcu, in. Morbi dolor volutpat vitae eu, tempor adipiscing volutpat vitae.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Sed mi condimentum tempor tempus ullamcorper sem faucibus arcu. Vel congue diam pretium duis ultricies mauris, suspendisse et.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Volutpat massa libero, orci quis eget ullamcorper mauris, sed. Nec dolor, sapien diam potenti donec. Eu sit amet integer potenti sed sed tellus interdum. Id hac phasellus sem quis facilisis turpis.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 10,),
              Text("Cookies",style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
              ),),
              SizedBox(height: 10,),
              Text("Quis ultricies donec ornare eget tempus in ut. In ipsum accumsan, magna dignissim praesent auctor pellentesque aenean.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Lobortis adipiscing vitae semper id tellus tortor massa. A vestibulum mattis ipsum, tortor at lectus maecenas. Nulla facilisis ornare ac, nunc praesent feugiat. Magna odio bibendum turpis eu in tempor vitae a laoreet. Nunc, pulvinar volutpat rutrum diam rhoncus et.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Tristique a sed sed condimentum consectetur hac. Consectetur pellentesque dolor, at elementum gravida non vitae. Odio nulla magna commodo vitae in elementum at. Adipiscing nunc in maecenas adipiscing. Ipsum non justo facilisi tincidunt venenatis quam pellentesque tristique et. Feugiat nisi vel nisl sit orci vel magna. ",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 10),
              Text("Links To The Other Sites",style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
              ),),
              SizedBox(height: 10,),
              Text("Ornare pulvinar eleifend auctor eget. Quam sit sapien, augue pellentesque purus arcu tortor. Varius morbi in id tempus vitae lectus eu porttitor quis. Leo diam ipsum consequat mi pharetra sapien iaculis. Amet orci sodales id arcu etiam.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 10,),
              Text("Information Sharing",style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
              ),),
              SizedBox(height: 10,),
              Text("Nulla in enim eget aliquet mauris et. Lobortis ut lorem sit turpis sed eu. Odio nisl odio vitae eu faucibus. Venenatis, bibendum aliquet dignissim feugiat rhoncus, sed habitasse dictum augue.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Laoreet arcu praesent euismod urna ante mattis nunc. In magna aenean nec vitae consequat sit malesuada vitae in.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Sed sapien, praesent eu turpis. Non purus volutpat tellus dolor, mauris fames quam ultrices. Maecenas blandit sodales.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 10,),
              Text("Information Security",style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness==Brightness.dark?
                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1)
              ),),
              SizedBox(height: 10,),
              Text("Nulla in enim eget aliquet mauris et. Lobortis ut lorem sit turpis sed eu. Odio nisl odio vitae eu faucibus. Venenatis, bibendum aliquet dignissim feugiat rhoncus, sed habitasse dictum augue.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Laoreet arcu praesent euismod urna ante mattis nunc. In magna aenean nec vitae consequat sit malesuada vitae in.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
              SizedBox(height: 5,),
              Text("Sed sapien, praesent eu turpis. Non purus volutpat tellus dolor, mauris fames quam ultrices. Maecenas blandit sodales.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).brightness==Brightness.dark?
                    Color.fromRGBO(160, 160, 160, 1):Color.fromRGBO(112, 112, 112, 1)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

