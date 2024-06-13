import 'package:flutter/material.dart';

class AboutUsNew extends StatelessWidget {
  const AboutUsNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?const Color.fromRGBO(0, 0, 0, 1):const Color.fromRGBO(255, 255, 255,1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?const Color.fromRGBO(18, 18, 18, 1):const Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "About Us",style: TextStyle(
              color:Theme.of(context).brightness ==
                  Brightness.dark?const Color.fromRGBO(255,255,255,1):const Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w900
          ),
          )),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text("Egestas nunc neque sed lobortis tellus, sociis justo felis. Id amet orci auctor diam dolor et metus. Fringilla nulla mauris fermentum, nisl diam diam. Urna maecenas id non enim massa id quis magna. Vulputate sapien elit habitasse elementum nibh aliquam sed. Nisi aliquet mus commodo interdum nisi, faucibus. Aliquet lectus ipsum massa viverra urna egestas.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness==Brightness.dark?
                    const Color.fromRGBO(160, 160, 160, 1):const Color.fromRGBO(112, 112, 112, 1)),),
            const SizedBox(
              height: 5,
            ),
            Text("Libero vulputate porta nisl tortor vitae. Proin pellentesque parturient ac euismod tortor malesuada pellentesque. Turpis leo blandit tristique eu phasellus viverra. Faucibus neque, urna nunc quis id. In luctus sagittis vitae aliquet. Felis dolor in sit arcu ut enim dis. Nibh molestie cursus euismod lacus leo, arcu magna enim blandit.", style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness==Brightness.dark?
                const Color.fromRGBO(160, 160, 160, 1):const Color.fromRGBO(112, 112, 112, 1)),),
            const SizedBox(
              height: 5,
            ),
            Text("At adipiscing bibendum ultricies vitae at scelerisque dui turpis et. Aliquam lorem dui aliquet leo sed mauris, amet, at. At volutpat vel eget leo. Integer rhoncus odio massa arcu condimentum. Ac laoreet id malesuada vel metus egestas lacinia.", style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness==Brightness.dark?
                const Color.fromRGBO(160, 160, 160, 1):const Color.fromRGBO(112, 112, 112, 1)),),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(59, 89, 153, 0.2)
                      ),
                      child: Image.asset("assets/images/Icon fb.png"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Facebook", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness==Brightness.dark?
                        const Color.fromRGBO(160, 160, 160, 1):const Color.fromRGBO(112, 112, 112, 1)))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(208, 116, 199, 0.2)
                      ),
                      child: Image.asset("assets/images/Icon  insta.png"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Instagram", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness==Brightness.dark?
                        const Color.fromRGBO(160, 160, 160, 1):const Color.fromRGBO(112, 112, 112, 1)))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(29, 161, 242, 0.2)
                      ),
                      child: Image.asset("assets/images/icon twitter.png"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Twitter", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness==Brightness.dark?
                        const Color.fromRGBO(160, 160, 160, 1):const Color.fromRGBO(112, 112, 112, 1)))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 0, 0, 0.1)
                      ),
                      child: Image.asset("assets/images/Icon yt.png"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Youtube", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness==Brightness.dark?
                        const Color.fromRGBO(160, 160, 160, 1):const Color.fromRGBO(112, 112, 112, 1)))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

