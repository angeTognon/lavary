import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/order.dart';
import 'package:new_lavery_app/pages/order0.dart';
import 'package:new_lavery_app/pages/order_by_kg.dart';
import 'package:new_lavery_app/pages/order_for_chaussure.dart';
import 'package:new_lavery_app/widgetss.dart';

class Choix extends StatefulWidget {
  String typeService="";
   Choix({required this.typeService, super.key});

  @override
  State<Choix> createState() => _ChoixState();
}

class _ChoixState extends State<Choix> {
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
        title: Text("Choisissez un type de quantification".tr,style: TextStyle(
            fontFamily: 'bold',fontSize: 18,color: Colors.white
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20,bottom: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [


              InkWell(
                onTap: () {
                  setState(() {
                    typeLavage="quantite";
                    print(typeLavage);

                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(cagetorie: "linge",typeService : widget.typeService,)));
                },
                child: Card(color: Colors.white,elevation: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 200,width: 160,
                    child: Column(
                      children: [
                        Container(
                            height: 150,
                            child: Image.asset("assets/images/quantite-removebg-preview.png")),
                        SizedBox(height: 4),
                        Text("Lavage par\nquantité".tr,style: TextStyle(fontFamily: 'bold',color: Colors.black,fontSize: 15),textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    typeLavage="kg";
                    print(typeLavage);
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageByKg(typeService: widget.typeService,),));
                },
                child: Card(color: Colors.white,elevation: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 200,width: 160,
                    child: Column(
                      children: [
                        Container(
                            height: 150,
                            child: Image.asset("assets/images/kg-removebg-preview.png")),
                        SizedBox(height: 4),
                        Text("Lavage par kilogramme".tr,style: TextStyle(fontFamily: 'bold',color: Colors.black,fontSize: 15),textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
                ),
              ),
            ],),
          ),
        ),
      ),
    );
  }
}
