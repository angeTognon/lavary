import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConfidentialitePage(),
    );
  }
}

class ConfidentialitePage extends StatefulWidget {
  @override
  _ConfidentialitePageState createState() => _ConfidentialitePageState();
}

class _ConfidentialitePageState extends State<ConfidentialitePage> {
  List<Item> _data = <Item>[
    Item(headerValue: "Comment fonctionne l'application de laverie ?", expandedValue: 'This is the content for Panel 1'),
    Item(headerValue: "Quels services sont proposés par votre laverie ?", expandedValue: 'This is the content for Panel 2'),
    Item(headerValue: "Comment puis-je créer un compte ?", expandedValue: 'This is the content for Panel 3'),
    Item(headerValue: "Comment puis-je passer une commande ?", expandedValue: 'This is the content for Panel 1'),
    Item(headerValue: "Puis-je suivre ma commande en temps réel ?", expandedValue: 'This is the content for Panel 2'),
    Item(headerValue: "Comment la collecte et la livraison sont-elles organisées ?", expandedValue: 'This is the content for Panel 3'),
    Item(headerValue: "Comment puis-je contacter le service client ?", expandedValue: 'This is the content for Panel 3'),
  ];

  void togglePanel(int index) {
    setState(() {
      if (_data[index].isExpanded) {
        _data[index].isExpanded = false;
      } else {
        _data.forEach((item) => item.isExpanded = false); // Fermer tous les autres panneaux
        _data[index].isExpanded = true; // Ouvrir le panneau sélectionné
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        toolbarHeight: 80,

        title: Text("FAQ ",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,fontFamily: "regular",),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              Container(
                child: Image.asset(
                  "assets/images/centre-dappel.png",
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    togglePanel(index);
                  },
                  children: _data.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.headerValue,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                        );
                      },
                      body: ListTile(
                        title: Text(item.expandedValue),
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
