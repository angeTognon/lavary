import 'package:flutter/material.dart';
import 'package:new_lavery_app/pages/order.dart';
import 'package:new_lavery_app/pages/order_for_chaussure.dart';
import 'package:new_lavery_app/widgetss.dart';

class Order0 extends StatefulWidget {
  const Order0({super.key});

  @override
  State<Order0> createState() => _Order0State();
}

class _Order0State extends State<Order0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 3,
        title: Text("Choisissez une catégorie",style: TextStyle(
            fontFamily: 'bold',fontSize: 18
        ),),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            InkWell(
              onTap: () {
                setState(() {
                  categorieLavage="linge";
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(cagetorie: 'linge',typeService: "s",),));
              },
              child: Card(
                child: Container(
                  height: 200,width: 160,
                  child: Column(
                    children: [
                      Container(
                          height: 150,
                          child: Image.asset("assets/images/tshirtBlanc.png")),
                      SizedBox(height: 4),
                      Text("Linge",style: TextStyle(fontFamily: 'bold'),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  categorieLavage="chaussures";
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageChaussure(typeService: "r",),));
              },
              child: Card(
                child: Container(
                  height: 200,width: 160,
                  child: Column(
                    children: [
                      Container(
                          height: 150,
                          child: Image.asset("assets/images/chaussure_.png")),
                      SizedBox(height: 4),
                      Text("Chaussures",style: TextStyle(fontFamily: 'bold'),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            ),

          ],),
        ),
      ),
    );
  }
}
