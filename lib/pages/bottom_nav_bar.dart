import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/choix.dart';
import 'package:new_lavery_app/pages/historique.dart';
import 'package:new_lavery_app/pages/order0.dart';
import 'package:new_lavery_app/pages/profil.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'cart.dart';
import 'home.dart';
import 'order.dart';


class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;

  List<Widget> pages = const [
    Home(),
    //Choix(),
    Historique(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 25,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(fontFamily: 'bold',fontSize: 14),
            selectedLabelStyle: TextStyle(fontFamily: 'bold',fontSize: 14),
            backgroundColor: mainColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.amber,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,size: 25,), label: "Accueil".tr,),
             // BottomNavigationBarItem(icon: Icon(Icons.redeem,size: 25), label: "Commande"),
              BottomNavigationBarItem(icon: Icon(Icons.history,size: 25,), label: "Historique".tr),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline,size: 25), label: "Profil".tr),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: myCurrentIndex,
        children: pages,
      ),
    );
  }
}
