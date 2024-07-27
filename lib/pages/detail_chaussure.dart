import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/main.dart';
import 'package:new_lavery_app/pages/waiting_page.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import 'historique.dart';

class DetailChaussure extends StatefulWidget {
     String typeService="";
     DetailChaussure({required this.typeService});

  @override
  State<DetailChaussure> createState() => _DetailChaussureState();
}

class _DetailChaussureState extends State<DetailChaussure> {

  String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String codeCommande="";
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  // print(getRandomString(10)); // LZrJOTBNGA
  String date="";
  ajoutCommande() async {
    codeCommande= getRandomString(10);
    var url =
        "https://feisholadigital.com/backend_new_lavery_app/ajoutCommande.php?type_de_lavage=$typeLavage&categerie_de_lavage=$categorieLavage&type_de_livraison=$typeLivraison&quartier_collecte=${quartierCollecte.text}&date_collecte=$dateCollecte&heure_collecte=$heureCollecte&quartier_livraison=${quartierLivr.text}&date_livraison=$dateLivr&heure_livraison=$heureLivr&montant_total=$montantTotal&email_client=$user_email&numero_client=57887411&codeCommande=$codeCommande&dateCommande=$date&typeService=${widget.typeService}";
    var response = await http.post(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.body == "OK") {
      /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Ajout Réussie",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )));*/
    } else {
      setState(() {
        /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur : Il semble que cette adresse mail a déjà été utilisée ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));*/
      });
    }
  }

  ajoutArticles() async {
    var url =
        "https://feisholadigital.com/backend_new_lavery_app/ajoutArticle.php?articles=Basket,$basketPU,$basket,$codeCommande; Chaussure Sport,$chaussureSportPU,$chaussureSport,$codeCommande; Ballerine, $BallerinePU, $Ballerine,$codeCommande;  Escarpin, $EscapinPU ,$Escapin,$codeCommande; Mocassin,$mocassinPU,$mocassin,$codeCommande; Sandale,$sandalePU,$sandale ,$codeCommande; Bottes,$bottesPU,$bottes";
    var response = await http.post(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.body == "OK") {

    } else {

    }
  }
  paymennt3() async {
    var url = "https://tabaskimood.com/lac/feishola/payment.php?name=Ange&phone=57887411&email=tognange@gmail.com&montant=$montantTotal";
    var response = await http.post(Uri.parse(url));
    print('Response status: ****** ${response.statusCode}');
    mylink = response.body;
    Future.delayed(Duration(seconds: 3),(){
      launchUrl(Uri.parse("$mylink"));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        shadowColor: Colors.black,
        elevation: 3,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
        ),
        title: Text("Details de la commande".tr,style: TextStyle(
            fontFamily: 'bold',fontSize: 18,color: Colors.white
        ),),
      ),
      bottomNavigationBar: Container(
        color: mainColor,
        padding: EdgeInsets.only(left: 15,right: 15),
        height: 70,width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(style: ElevatedButton.styleFrom(),onPressed: (){
              ajoutCommande();
              ajoutArticles();
              if(paiement_en_ligne==true){
                Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingPage(),));
                paymennt3();
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => Historique(),));

              }

            }, child: Text(paiement_en_ligne? "Valider La Commande et Payer".tr : "Valider La Commande".tr,style: TextStyle(
                color: mainColor,fontFamily: 'bold'
            ),))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  //Basket,$basketPU,$basket ; Chaussure Sport,$chaussureSportPU,$chaussureSport ; Ballerine, $BallerinePU, $Ballerine ;Escarpin, $EscapinPU ,$Escapin ; Mocassin,$mocassinPU,$mocassin ; Sandale,$sandalePU,$sandale ; Bottes,$bottesPU,$bottes
                  basket!=0?  BoxDesTenues("Basket", "Prix :".tr + "$basketPU F",basket) :w(0),
                  chaussureSport!=0 ?  BoxDesTenues("Chaussure Sport".tr, "Prix :".tr + "$chaussureSportPU F",chaussureSport):w(0),
                  Ballerine!=0 ?  BoxDesTenues("Ballerine".tr, "Prix :".tr + "$BallerinePU F",Ballerine):w(0),
                  Escapin!=0 ?  BoxDesTenues("Escarpin".tr, "Prix :".tr + "$EscapinPU F",Escapin):w(0),
                  mocassin!=0 ?  BoxDesTenues("Mocassin".tr, "Prix :".tr + "$mocassinPU F",mocassin):w(0),
                  sandale!=0 ?  BoxDesTenues("Sandale".tr, "Prix :".tr + "$sandalePU F",sandale):w(0),
                  bottes!=0 ?  BoxDesTenues("Bottes".tr, "Prix :".tr + "$bottesPU F",bottes):w(0),


                  Text("Total : $montantTotal ",style: TextStyle(fontSize: 15,fontFamily: 'bold'),)
                ],
              ),
            ),
            h(20),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("RÉCEPTION  ".tr,style: TextStyle(
                    fontFamily: 'bold',fontSize: 15
                ),),
              ],
            ),
            h(20),
            Container(
              padding: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Type de livraison :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Text("type",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quartier :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Text("quartier",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date de Réception :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Text("1/06/2024",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Heure de Réception :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Text("1/06/2024",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                  ],
              ),
            ),
            h(20),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("LIVRAISON  ".tr,style: TextStyle(
                    fontFamily: 'bold',fontSize: 15
                ),),
              ],
            ),
            h(20),
            Container(
              padding: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quartier de livraison :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Text("quartier",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date de livraison :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Text("1/06/2024",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Heure de livraison :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Text("1/06/2024",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget BoxDesTenues(String titre, prix, int compteur){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                padding: EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(titre,style: TextStyle(fontFamily: 'bold',fontSize: 15),),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 10,right:10),
            decoration: BoxDecoration(
                color: Color(0xFFD0DFF7),
                borderRadius: BorderRadius.circular(13)
            ),
            width: 140 ,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(child: Text("Quantité : ".tr,style: TextStyle(fontFamily: 'bold',color: mainColor,fontSize: 15),)),
                Text("$compteur",style: TextStyle(fontFamily: 'bold',color: mainColor,fontSize: 15),),
                ],
            ),
          )
        ],
      ),
    );
  }
}
