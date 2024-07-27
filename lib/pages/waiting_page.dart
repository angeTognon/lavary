import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/bottom_nav_bar.dart';
import 'package:new_lavery_app/widgetss.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  bool show = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 8),(){
      setState(() {
        show= true;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,width: 150,
            ),
            Text("Veuillez patienter Quelques Secondes.\nLa page de Paiement arrive.".tr,style: TextStyle(fontFamily: 'normal',fontSize: 17),textAlign: TextAlign.center,),
            h(20),
            show ? ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15)),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyBottomNavBar(),)), child: Text("Revenir sur l'accueil",style: TextStyle(fontSize: 16),)):Text("")
          ],
        ),
      ),
    );
  }
}
