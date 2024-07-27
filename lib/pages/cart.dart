import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      elevation: 1,
      backgroundColor: Colors.blue,
      title:Text("Cart page",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "regular",color: Colors.white),
      ) ,

      centerTitle: true,
    ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
