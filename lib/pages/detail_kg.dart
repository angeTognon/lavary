import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/waiting_page.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import '../../main.dart';
import 'historique.dart';
class DetailKg extends StatefulWidget {
     String typeService="";
   DetailKg({required this.typeService});

  @override
  State<DetailKg> createState() => _DetailKgState();
}

class _DetailKgState extends State<DetailKg> {

  String _chars = '1234567890';
  Random _rnd = Random();
  String codeCommande="";
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  // print(getRandomString(10)); // LZrJOTBNGA
  String date="";
  ajoutCommande() async {
    codeCommande= getRandomString(10);
    var url =
        "https://feisholadigital.com/backend_new_lavery_app/ajoutCommande.php?type_de_lavage=$typeLavage&categerie_de_lavage=$categorieLavage&type_de_livraison=$typeLivraison&quartier_collecte=${quartierCollecte.text}&date_collecte=$dateCollecte&heure_collecte=$heureCollecte&quartier_livraison=${quartierLivr.text}&date_livraison=$dateLivr&heure_livraison=$heureLivr&montant_total=$nombreTotal&email_client=$user_email&numero_client=57887411&codeCommande=$codeCommande&dateCommande=$date&typeService=${widget.typeService}";
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
        "https://feisholadigital.com/backend_new_lavery_app/ajoutArticle.php?articles=T-Shirt,$tshirtPU,$tshirt,$codeCommande; T-Shirt Blanc,$tshirtBlancPU,$tshirtBlanc,$codeCommande; Chemise,$chemisePU,$chemise,$codeCommande;  Chemise Blanc,$chemiseBlancPU,$chemiseBlanc,$codeCommande; Chemise,$chemisePU,$chemise,$codeCommande; Chemise Blanc,$chemiseBlancPU,$chemiseBlanc,$codeCommande; Blouse Médicale,$blouseMedicalPU,$blouseMedical,$codeCommande; Pull Over,$pullOverPU,$pullOver,$codeCommande; Pull Over Blanc,$pullOverBlancPU,$pullOverBlanc,$codeCommande;  Pantalon Simple,$pantalonSimplePU,$pantalonSimple,$codeCommande; Tenu en Cuir,$tenuCuirPU,$tenuCuir,$codeCommande; Pull Over,$pullOverPU,$pullOver,$codeCommande;Blouse Médicale,$blouseMedicalPU,$blouseMedical,$codeCommande;  Pantalon Simple,$pantalonSimplePU,$pantalonSimple,$codeCommande; Pantalon Blanc,$pantalonBlancPU,$pantalonBlanc,$codeCommande; Jean Habit,$jeanPantalonPU,$jeanPantalon,$codeCommande; Jupe,$jupePU,$jupe,$codeCommande;Jupe Blanche,$jupeBlancPU,$jupeBlanc,$codeCommande;Costume,$costumePU,$costume,$codeCommande;Robe,$robePU,$robe,$codeCommande;  Tenu Tradi,$tenuTradiSimplePU,$tenuTradiSimple,$codeCommande;Bazin,$bazinPU,$bazin,$codeCommande";
    var response = await http.post(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.body == "OK") {

    } else {

    }
  }


  @override
  void initState() {
    date="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    print(date);
    // TODO: implement initState
    super.initState();
  }

  paymennt3() async {
    var url = "https://tabaskimood.com/lac/feishola/payment.php?name=Ange&phone=57887411&email=tognange@gmail.com&montant=$nombreTotal";
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
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 3,
        title: Text("Details de la commande".tr,style: TextStyle(
            fontFamily: 'bold',fontSize: 18
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
            h(20),
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

                  tshirt!=0?  BoxDesTenues("T-Shirt".tr,"Prix :".tr +"$tshirtP F",tshirt) :w(0),
                  tshirtBlanc!=0?  BoxDesTenues("T-Shirt Blanc".tr, "Prix :".tr +"$tshirtBlancP F",tshirtBlanc) :w(0),
                  chemise!=0 ?  BoxDesTenues("Chemise".tr, "Prix :".tr +"$chemiseP F",chemise):w(0),
                  chemiseBlanc!=0 ?  BoxDesTenues("Chemise Blanc".tr, "Prix :".tr +"$chemiseBlancP F",chemiseBlanc):w(0),
                  blouseMedical!=0 ?  BoxDesTenues("Blouse Médicale".tr, "Prix :".tr +"$blouseMedicalP F",blouseMedical):w(0),
                  pullOver!=0 ?  BoxDesTenues("Pull Over".tr, "Prix :".tr +"$pullOverP F",pullOver):w(0),
                  pullOverBlanc!=0 ?  BoxDesTenues("Pull Over Blanc".tr, "Prix :".tr +"$pullOverBlancP F",pullOverBlanc):w(0),
                  pantalonSimple!=0 ?  BoxDesTenues("Pantalon Simple".tr, "Prix :".tr +"$pantalonSimpleP F",pantalonSimple):w(0),
                  tenuCuir!=0 ?  BoxDesTenues("Tenu en Cuir".tr, "Prix :".tr +"$tenuCuirP F",tenuCuir):w(0),

                  pantalonBlanc!=0 ?  BoxDesTenues("Pantalon Blanc".tr, "Prix :".tr +"$pantalonBlancP F",pantalonBlanc):w(0),
                  jeanPantalon!=0 ?  BoxDesTenues("Jean Habit".tr, "Prix :".tr +"$jeanPantalonP F",jeanPantalon):w(0),
                  jupe!=0 ?  BoxDesTenues("Jupe".tr, "Prix :".tr +"$jupeP F",jupe):w(0),
                  jupeBlanc!=0 ?  BoxDesTenues("Jupe Blanc".tr, "Prix :".tr +"$jupeBlancP F",jupeBlanc):w(0),
                  costume!=0 ?  BoxDesTenues("Costume", "Prix :".tr +"$costumeP F",costume):w(0),
                  robe!=0 ?  BoxDesTenues("Robe".tr, "Prix :".tr +"$robeP F",robe):w(0),
                  tenuTradiSimple!=0 ?  BoxDesTenues("Tenu Tradi".tr, "Prix :".tr +"$tenuTradiSimpleP F",tenuTradiSimple):w(0),
                  bazin!=0 ?  BoxDesTenues("Bazin", "Prix :".tr +"$bazinP F",bazin):w(0),
                  // Agbada,$agbadaPU,$agbadaP,$codeCommande;
                  // Pyjama,$pyjamaPU,$pyjamaP,$codeCommande;
                  // Drap,$drapP,$drapPU,$codeCommande;
                  // Rideaux,$rideauxPU,$rideauxP,$codeCommande;
                  // Serviette,$serviettePU,$servietteP,$codeCommande;
                  // Couette,$couettePU,$couetteP,$codeCommande;
                  // Nappe,$nappePU,$nappeP,$codeCommande;
                  // Tapis,$tapisPU,$tapisP,$codeCommande;
                  agbada!=0 ?  BoxDesTenues("Agbada", "Prix :".tr +"$agbadaP F",agbada):w(0),
                  pyjama!=0 ?  BoxDesTenues("Pyjama", "Prix :".tr +"$pyjamaP F",pyjama):w(0),
                  drap!=0 ?  BoxDesTenues("Drap".tr, "Prix :".tr +"$drapP F",drap):w(0),
                  rideaux!=0 ?  BoxDesTenues("Rideaux".tr, "Prix :".tr +"$rideauxP F",rideaux):w(0),
                  serviette!=0 ?  BoxDesTenues("Serviette".tr, "Prix :".tr +"$servietteP F",serviette):w(0),
                  couette!=0 ?  BoxDesTenues("Couette".tr, "Prix :".tr +"$couetteP F",couette):w(0),
                  nappe!=0 ?  BoxDesTenues("Nappe".tr, "Prix :".tr +"$nappeP F",nappe):w(0),
                  tapis!=0 ?  BoxDesTenues("Tapis".tr, "Prix :".tr +"$tapisP F",tapis):w(0),
                  oreiller!=0 ?  BoxDesTenues("Oreiller".tr, "Prix :".tr +"$oreillerP F",oreiller):w(0),
                  Text("Total : $nombreTotal",style: TextStyle(fontSize: 15,fontFamily: 'bold'),)
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
                      Text(typeLivraison,style: TextStyle(
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
                      Text("${quartierCollecte.text}",style: TextStyle(
                          fontFamily: 'bold',fontSize: 15,color: mainColor
                      ),),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date de Collecte :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Container(width: 100,
                        child: Text(dateCollecte,style: TextStyle(
                            fontFamily: 'bold',fontSize: 15,color: mainColor
                        ),),
                      ),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Heure de Collecte :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Container(width: 100,
                        child: Text(heureCollecte,style: TextStyle(
                            fontFamily: 'bold',fontSize: 15,color: mainColor
                        ),),
                      ),
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
                      Container(
                        child: Text("${quartierLivr.text}",style: TextStyle(
                            fontFamily: 'bold',fontSize: 15,color: mainColor
                        ),),
                      ),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date de livraison :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Container(width: 100,
                        child: Text(dateLivr,style: TextStyle(
                            fontFamily: 'bold',fontSize: 15,color: mainColor
                        ),),
                      ),
                    ],
                  ),
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Heure de livraison :  ".tr,style: TextStyle(
                          fontFamily: 'bold',fontSize: 15
                      ),),
                      Container(width: 100,
                        child: Text(heureLivr,style: TextStyle(
                            fontFamily: 'bold',fontSize: 15,color: mainColor
                        ),),
                      ),
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
