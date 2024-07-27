import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/choix.dart';
import 'package:new_lavery_app/pages/order_for_chaussure.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getUserProfile() async {
    var url =
        "https://feisholadigital.com/backend_new_lavery_app /get_user_profile.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    var pub = await json.decode(response.body);
    return pub;
  }
  bool en = false;
  int _currentCarouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        elevation: 1,
        backgroundColor: mainColor,

        title: Column(
          children: [
             Text("App Laverie".tr,style: TextStyle(color: Colors.white,fontFamily: 'bold'),)
          ],
        ),
        actions: [
          InkWell(
        onTap: () {
          setState(() {
            en=!en;
            if(en){
              var locale= Locale('en','US');
              Get.updateLocale(locale);
            }else{
              var locale= Locale('fr','FR');
              Get.updateLocale(locale);
            }
          });
        },
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          height: 30,
          decoration: BoxDecoration(
            color: Colors.orange,borderRadius: BorderRadius.circular(5)
          ),
          child: Center(child: Text(en==true?"Français": "Anglais",style: TextStyle(fontFamily: 'bold',color: Colors.white,fontSize: 16),))),
      ),
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Badge(
                label: Text('5'),
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 25,
                    color: Colors.white,

                  ),
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            CarouselSlider(
              options: CarouselOptions(
                
                height: 220.0, // Hauteur du carrousel
                enlargeCenterPage: true, // Agrandir la page centrale
                autoPlay: true, // Lecture automatique
                aspectRatio: 16 / 9, // Ratio d'aspect des images
                autoPlayCurve:Curves.fastOutSlowIn, // Animation de lecture automatique
                autoPlayAnimationDuration: Duration(milliseconds:900), // Durée de l'animation de lecture automatique
                enableInfiniteScroll: true, // Défilement infini du carrousel
                autoPlayInterval: Duration(seconds:8), // Intervalle entre les animations de lecture automatique
                pauseAutoPlayOnTouch:true, // Mettre en pause la lecture automatique lorsqu'on touche le carrousel
                viewportFraction: 0.9, 
                // Fraction visible de chaque image
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                },
              ),
              items: [
                'assets/images/pub.jpg',
                'assets/images/pub.jpg',
                'assets/images/pub.jpg',
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0), // Remplacez 15.0 par le rayon que vous souhaitez
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                        ),
                      )
                    );
                  },
                );
              }).toList(),
            ),
            h(10),         
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    width: 12,
                    height: 12,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentCarouselIndex == i
                          ? mainColor
                          : Colors.grey,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nos services".tr,
                    style: TextStyle(fontSize: 18,color: Colors.black87, fontFamily: "bold",),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Choix(typeService: "Lavage et repassage",),)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(elevation : 5,
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(

                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/images/ma.jpg",fit:BoxFit.cover)),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lavage et repassage".tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "bold",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Choix(typeService: "Repassage",),)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Container(

                              width: 150,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/images/repassagep.jpg",fit:BoxFit.cover)),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Repassage".tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "bold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Choix(typeService: "Teinture",),)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Container(

                              width: 150,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/images/pile-crayons-multi.jpg",fit:BoxFit.cover)),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Teinture".tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "bold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageChaussure(typeService: "Lavage chaussure",),)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Container(

                              width: 150,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/images/lave.jpg",fit:BoxFit.cover)),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lavage chaussure".tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "bold",
                            ),
                          ),
                        ],
                      ),
                    ),
            
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageChaussure(typeService: "Lavage et teinture",),)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/images/cirage.jpg",fit:BoxFit.cover)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lavage et teinture".tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "regular",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
            
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageChaussure(typeService: "Reparation et Lavage",),)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/images/bo.jpg",fit:BoxFit.cover)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Reparation et Lavage".tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "regular",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,

                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Comment sa marche ?".tr,
                          style: TextStyle(
                              fontFamily: "bold",
                              fontSize: 18, color: mainColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: 155,
                          height: 155,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                              fontFamily: "regular",
                                              color: mainColor,
                                              fontSize: 50, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Image.asset("assets/images/enquete.png",width: 80,height: 110,),

                                        ],
                                      ),
                                    ],
                                  ),

                                  Center(
                                    child: Text(
                                      "Passer commande".tr,
                                      style: TextStyle(
                                          fontFamily: "regular",
                                          fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: 155,
                          height: 155,
                          child: Column(
                            children: [

                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text(
                                          "2",
                                          style: TextStyle(
                                              fontFamily: "regular",
                                              color: mainColor,
                                              fontSize: 50, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Image.asset("assets/images/icons8-fournisseur-94.png",width: 80,height: 110,),

                                        ],
                                      ),
                                    ],
                                  ),

                                  Center(
                                    child: Text(
                                      "Nous collectons \n à domicile".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "regular",
                                          fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: 155,
                          height: 155,
                          child: Column(
                            children: [

                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text(
                                          "3",
                                          style: TextStyle(
                                              fontFamily: "regular",
                                              color: mainColor,
                                              fontSize: 50, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Image.asset("assets/images/icons8-propre-85.png",width: 80,height: 110,),

                                        ],
                                      ),
                                    ],
                                  ),

                                  Center(
                                    child: Text(
                                      "Nous prenons soin".tr,
                                      style: TextStyle(
                                          fontFamily: "regular",
                                          fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: 155,
                          height: 155,
                          child: Column(
                            children: [

                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text(
                                          "4",
                                          style: TextStyle(
                                              fontFamily: "regular",
                                              color: mainColor,
                                              fontSize: 50, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Image.asset("assets/images/livraison (1).png",width: 80,height: 110,),

                                        ],
                                      ),
                                    ],
                                  ),

                                  Center(
                                    child: Text(
                                      "Nous Livrons".tr,
                                      style: TextStyle(
                                          fontFamily: "regular",
                                          fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Temoignages".tr,
                              style: TextStyle(
                                  fontFamily: "regular",
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only( right: 10),
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4.0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 12, bottom: 12, right: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipOval(
                                                child: Image.asset(
                                                  "assets/images/profil.jpg",
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Marthe Toni",

                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size:15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                    ],
                                                  ),



                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Cette application a révolutionné ma \n routine de lessive ! En quelques clics, \n je programme la collecte et la livraison \n de mon linge. ".tr,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "regular",

                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4.0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 12, bottom: 12, right: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipOval(
                                                child: Image.asset(
                                                  "assets/images/profil.jpg",
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Ali Sekou",

                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size:15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                    ],
                                                  ),



                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Une application indispensable pour tous \n ceux qui manquent de temps pour faire leur \n lessive. La possibilité de choisir des options \n de lavage spécifiques est un plus.".tr,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "regular",

                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4.0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 12, bottom: 12, right: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipOval(
                                                child: Image.asset(
                                                  "assets/images/profil.jpg",
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Franck Teni",

                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size:15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orangeAccent,
                                                        size: 15,
                                                      ),
                                                    ],
                                                  ),



                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Je recommande vivement cette \n application à tous ceux qui \n cherchent une solution de laverie \n fiable et sans tracas ".tr,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "regular",

                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Porter plainte/Urgence".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red,
                                        fontFamily: "regular",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 15,),
                                  Icon(
                                    Icons.fax_sharp,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 30, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: _launchWhatsApp,
                                        child: Image.asset("assets/images/icons8-whatsapp-48.png",),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "Message",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mainColor,
                                            fontFamily: "regular",
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: _launchPhoneCall,
                                        child: Icon(
                                          Icons.phone,
                                          size: 35,
                                          color: mainColor
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "Appel".tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mainColor,
                                            fontFamily: "regular",
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
  void _launchPhoneCall() async {
    const phoneNumber = '+22967316832';
    const url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _launchWhatsApp() async {
    const phoneNumber = '+22967316832';
    const url = 'https://wa.me/$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
