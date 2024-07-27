import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/schedule.dart';
import 'package:new_lavery_app/widgetss.dart';

class OrderPageChaussure extends StatefulWidget {
  String typeService = "";
  OrderPageChaussure({required this.typeService});

  @override
  State<OrderPageChaussure> createState() => _OrderPageChaussureState();
}

class _OrderPageChaussureState extends State<OrderPageChaussure> {
  bool vHaut=true;
  bool vBas=false;
  bool vfull=false;
  bool vAutres=false;

  // List of items in our dropdown menu
  var items = [
    'Cliquez ici',
    'Lavage',
    'Lavage et Reparation' ,
    'Lavage et Teinture',

  ];

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
     title: Text("Ajouter vos chaussures".tr,style: TextStyle(
       fontFamily: 'bold',fontSize: 18,color: Colors.white
     ),),
   ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 15,right: 15),
        height: 70,width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Montant Total : ${basketP+chaussureSportP+BallerineP+EscapinP+mocassinP+sandaleP+bottesP} FCFA",style: TextStyle(fontSize: 15,fontFamily: 'bold',color: Colors.black),),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: mainColor),onPressed: (){
              setState(() {
                montantTotal=basketP+chaussureSportP+BallerineP+EscapinP+mocassinP+sandaleP+bottesP;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule(titrePage: 'chaussure',category: 'chaussure',typeServices: widget.typeService,),));
            }, child: Text("Continuer".tr,style: TextStyle(
              color: Colors.white,fontFamily: 'bold'
            ),))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choisissez la chaussure à laver".tr,style: TextStyle(fontFamily: 'bold',fontSize: 16),),

            h(15),
            Column(
              children: [
                BoxDesTenues("assets/images/chaussure.png","Baskets", basket==0? "PU : $basketPU F" : "Prix :".tr + "$basketP F" , basket, (value) {setState(() {basket = value;if(basket<0){basket=0;} basketP=basketPU*basket;});}),
                BoxDesTenues("assets/images/chaussureSport.png","Chaussure de sport".tr, chaussureSport==0? "PU : $chaussureSportPU F" : "Prix :".tr + "$chaussureSportP F" , chaussureSport, (value) {setState(() {chaussureSport = value;if(chaussureSport<0){chaussureSport=0;} chaussureSportP=chaussureSportPU*chaussureSport;});}),
                BoxDesTenues("assets/images/ballerine.png","Ballerine".tr,Ballerine==0? "PU : $BallerinePU F" : "Prix :".tr + "$BallerineP F", Ballerine, (value) {setState(() {Ballerine = value;if(Ballerine<0){Ballerine=0;}BallerineP=BallerinePU*Ballerine;});}),
                BoxDesTenues("assets/images/escarpin.png","Escarpin".tr,Escapin==0? "PU : $EscapinPU F" : "Prix :".tr + "$EscapinP F", Escapin, (value) {setState(() {Escapin = value;if(Escapin<0){Escapin=0;}EscapinP=EscapinPU*Escapin;});}),
                BoxDesTenues("assets/images/mocassin.png","Mocassin".tr,mocassin==0? "PU : $mocassinPU F" : "Prix :".tr + "$mocassinP F", mocassin,(value) {setState(() {mocassin = value;if(mocassin<0){mocassin=0;}mocassinP=mocassinPU*mocassin;});}),
                BoxDesTenues("assets/images/sandale.png","Sandale".tr,sandale==0? "PU : $sandalePU F" : "Prix :".tr + "$sandaleP F", sandale,(value) {setState(() {sandale = value;if(sandale<0){sandale=0;}sandaleP=sandalePU*sandale;});}),
                BoxDesTenues("assets/images/bottes.png","Bottes".tr,bottes==0? "PU : $bottesPU F" : "Prix :".tr + "$bottesP F", bottes,(value) {setState(() {bottes = value;if(bottes<0){bottes=0;}bottesP=bottesPU*bottes;});}),
               ],
            )
            ],
        ),
      ),
    );
  }
  PersonType(String titre,bool isClicked){
    return InkWell(
      onTap: () {
        setState(() {
          if(titre=="Vêtements Hauts"){
            vHaut=true;
            vBas=vfull=vAutres=false;
          }else if(titre=="Vêtements Bas"){
            vBas=true;
            vHaut=vfull=vAutres=false;
          }else if(titre=="Complets"){
            vfull=true;
            vHaut=vBas=vAutres=false;
          }else{
            vAutres=true;
            vHaut=vBas=vfull=false;
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        height: 50,
        constraints: BoxConstraints(maxWidth: 160),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: mainColor,width: 1.3),
          color:isClicked? mainColor : Colors.white
        ),
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Center(
          child: Text(titre,style: TextStyle(
            fontSize: 15,fontFamily: 'bold',color: isClicked? Colors.white : mainColor
          ),),
        ),
      ),
    );
  }
  Widget BoxDesTenues(String img, titre, prix, int compteur,ValueChanged<int> onCounterChanged){
    return Card(
      child: Container(
        height: 120,width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 120,width: 110,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(img),fit: BoxFit.contain)
              ),
            ),
            Container(
              width: 130,
              padding: EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(titre,style: TextStyle(fontFamily: 'bold',fontSize: 15),),
                  h(10),
                  Text(prix,style: TextStyle(fontFamily: 'bold',fontSize: 13,color: Colors.deepOrangeAccent,),),
                ],
              ),

            ),
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 10,right:10),
              margin: EdgeInsets.only(right:10),
              decoration: BoxDecoration(
                  color: Color(0xFFD0DFF7),
                  borderRadius: BorderRadius.circular(13)
              ),
              width: 80 ,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        onCounterChanged(compteur - 1);
                      },
                      child: Text("-",style: TextStyle(fontFamily: 'bold',color: mainColor,fontSize: 26),)),
                  Text("$compteur",style: TextStyle(fontFamily: 'bold',color: mainColor,fontSize: 20),),
                  InkWell(
                      onTap: () {
                        onCounterChanged(compteur + 1);
                      },
                      child: Text("+",style: TextStyle(fontFamily: 'bold',color: mainColor,fontSize: 23),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
