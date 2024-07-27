import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/main.dart';
import 'package:new_lavery_app/pages/detail_historique.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  getCommande() async {
    var url =
        "https://feisholadigital.com/backend_lavery_app/getCommande.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    var pub = await json.decode(response.body);
    return pub;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        shadowColor: Colors.black,
        elevation: 3,
        title: Text("Historique".tr,style: TextStyle(
            fontFamily: 'bold',fontSize: 18,color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 1, left: 20, right: 20, top: 20),
              height: MediaQuery.of(context).size.height/1.18,
              child: FutureBuilder(
                future: getCommande(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Erreur de chargement. Veuillez relancer l'application".tr),
                    );
                  }
                  if (snapshot.hasData) {
                    return
                      snapshot.data.isEmpty ? Center(
                        child: Text("Vous n'avez pas de commande".tr,style: TextStyle(color: Colors.black38,fontFamily: 'normal',fontWeight: FontWeight.bold,fontSize: 18)),
                      ):
                      Container(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return   BoxHistorique(snapshot.data![index]['codeCommande'],
                              snapshot.data![index]['dateCommande'], snapshot.data![index]['typeService']);
                        },
                      ),
                    );
                  }
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: Lottie.asset("assets/images/auto_loading.json",)));
                },
              ),
            ),

        
          ],
        ),
      ),
    );
  }
  BoxHistorique(String code, date, typeService){
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: mainColor)
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25,right: 25),
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: mainColor
                    ),
                    child: Center(child: Text("Code",style: TextStyle(color: Colors.white,fontFamily: 'normal',fontWeight: FontWeight.bold,fontSize: 15),)),
                  ),
                  h(10),
                  Container(
                    width: 100,
                      child: Text(code,style: TextStyle(color: Colors.black,fontFamily: 'normal',fontWeight: FontWeight.bold,fontSize: 15),textAlign: TextAlign.center,)),
                  ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text("Date ",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold,fontFamily: 'normal',fontSize: 15),)),
                  ),
                  h(10),
                  Container(
                      child: Text(date,style: TextStyle(color: Colors.black,fontFamily: 'normal',fontWeight: FontWeight.bold,fontSize: 15),))
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(" Paiement ",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold,fontFamily: 'normal',fontSize: 15),)),
                  ),
                  h(10),
                  Text("Payé".tr,style: TextStyle(color: Colors.black,fontFamily: 'normal',fontWeight: FontWeight.bold,fontSize: 15),)
                ],
              ),
            ],
          ),
          h(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Text(typeService,style: TextStyle(color: mainColor,fontFamily: 'normal',fontWeight: FontWeight.bold,fontSize: 15),)),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailHistorique(code_commande:code ),));
                },
               child: Container(
                 height:35 ,
                 padding: EdgeInsets.only(left: 15,right: 15),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15),
                   color: Colors.green.shade800
                 ),
                 child: Center(
                   child: Text("Détails".tr,style: TextStyle(color: Colors.white,fontFamily: 'normal',fontWeight: FontWeight.bold),),
                 ),
               ),
             )
            ],
          )
        ],
      )
    );
  }
}
