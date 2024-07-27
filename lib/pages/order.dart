import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/schedule.dart';
import 'package:new_lavery_app/widgetss.dart';

class OrderPage extends StatefulWidget {
  String cagetorie = "linge";
  String typeService= "";
  OrderPage({required this.cagetorie,required this.typeService});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool vHaut=true;
  bool vBas=false;
  bool vfull=false;
  bool vAutres=false;



  // List of items in our dropdown menu
  var items = [
    'Cliquez ici',
    'Lavage et repassage',
    'Repassage',
    'Teinture',

  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
   appBar: AppBar(
     backgroundColor: mainColor,
     shadowColor: Colors.black,
     leading: InkWell(
       onTap: () => Navigator.pop(context),
       child: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
     ),
     elevation: 3,
     title: Text("Ajouter vos tenues".tr,style: TextStyle(
       fontFamily: 'bold',fontSize: 18, color : Colors.white
     ),),
   ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 15,right: 15),
        height: 70,width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Montant Total : ${tshirtP + chemiseP+ pantalonSimpleP+ pantalonBlancP+ jeanHabitP +  jeanPantalonP + tshirtBlancP + chemiseColoreP + pullOverBlancP +  chemiseBlancP + tenuTradiSimpleP + tenuTradiColoreP + bazinP + agbadaP + manteauxP+  manteauxCuirP + trehiP +  blouseMedicalP + tenuCuirP + tapisP + oreillerP+  rideauxGrandP +  servietteBlancP + shortP + pullOverP + jupeP + jupeBlancP + soutiensP + robeP + pyjamaP + drapP + rideauxP +  couetteP + servietteP +  nappeP + chaussureP + completP + costumeP} FCFA",style: TextStyle(fontSize: 15,fontFamily: 'bold',color: Colors.black),),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: mainColor),onPressed: (){
              setState(() {
                montantTotal=tshirtP + chemiseP+ pantalonSimpleP+ pantalonBlancP+ jeanHabitP +  jeanPantalonP + tshirtBlancP + chemiseColoreP + pullOverBlancP +  chemiseBlancP + tenuTradiSimpleP + tenuTradiColoreP + bazinP + agbadaP + manteauxP+  manteauxCuirP + trehiP +  blouseMedicalP + tenuCuirP + tapisP + oreillerP+  rideauxGrandP +  servietteBlancP + shortP + pullOverP + jupeP + jupeBlancP + soutiensP + robeP + pyjamaP + drapP + rideauxP +  couetteP + servietteP +  nappeP + chaussureP + completP + costumeP;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule(titrePage: "normal",category: "linge",typeServices : widget.typeService),));
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

            h(15),
            Text("Choisissez vos Linges".tr,style: TextStyle(fontFamily: 'bold',fontSize: 16),),
            h(20),
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PersonType("Vêtements Hauts".tr,vHaut),
                  PersonType("Vêtements Bas".tr,vBas),
                  PersonType("Complets".tr,vfull),
                  PersonType("Articles Maisons".tr,vAutres),
                ],
              ),
            ),
            h(15),
           vHaut? Column(
              children: [
                BoxDesTenues("assets/images/image 9.png","T-Shirt".tr, tshirt==0? "PU : $tshirtPU F" : "Prix :".tr + "$tshirtP F" , tshirt, (value) {setState(() {tshirt = value;if(tshirt<0){tshirt=0;} tshirtP=tshirtPU*tshirt;});}),
                BoxDesTenues("assets/images/tshirtBlanc.png","T-Shirt Blanc".tr, tshirtBlanc==0? "PU : $tshirtBlancPU F" : "Prix :".tr + "$tshirtBlancP F" , tshirtBlanc, (value) {setState(() {tshirtBlanc = value;if(tshirtBlanc<0){tshirtBlanc=0;} tshirtBlancP=tshirtBlancPU*tshirtBlanc;});}),
                BoxDesTenues("assets/images/chemiseCouleur.png","Chemise".tr,chemise==0? "PU : $chemisePU F" : "Prix :".tr + "$chemiseP F", chemise, (value) {setState(() {chemise = value;if(chemise<0){chemise=0;}chemiseP=chemisePU*chemise;});}),
                BoxDesTenues("assets/images/chemiseBlanche_.png","Chemise Blanche".tr,chemiseBlanc==0? "PU : $chemiseBlancPU F" : "Prix :".tr + "$chemiseBlancP F", chemiseBlanc, (value) {setState(() {chemiseBlanc = value;if(chemiseBlanc<0){chemiseBlanc=0;}chemiseBlancP=chemiseBlancPU*chemiseBlanc;});}),
                BoxDesTenues("assets/images/blouse-removebg-preview.png","Blouse".tr,blouseMedical==0? "PU : $blouseMedicalPU F" : "Prix :".tr + "$blouseMedicalP F", blouseMedical,(value) {setState(() {blouseMedical = value;if(blouseMedical<0){blouseMedical=0;}blouseMedicalP=blouseMedicalPU*blouseMedical;});}),
                BoxDesTenues("assets/images/pullOver_.png","PullOver".tr,pullOver==0? "PU : $pullOverPU F" : "Prix :".tr + "$pullOverP F", pullOver,(value) {setState(() {pullOver = value;if(pullOver<0){pullOver=0;}pullOverP=pullOverPU*pullOver;});}),
                BoxDesTenues("assets/images/pullOverBlanc.png","PullOver Blanc".tr,pullOverBlanc==0? "PU : $pullOverBlancPU F" : "Prix :".tr + "$pullOverBlancP F", pullOverBlanc,(value) {setState(() {pullOverBlanc = value;if(pullOverBlanc<0){pullOverBlanc=0;}pullOverBlancP=pullOverBlancPU*pullOverBlanc;});}),
                BoxDesTenues("assets/images/jeanHabit-removebg-preview.png","Jean Habit".tr,jeanHabit==0? "PU : $jeanHabitPU F" : "Prix :".tr + "$jeanHabitP F", jeanHabit,(value) {setState(() {jeanHabit = value;if(jeanHabit<0){jeanHabit=0;}jeanHabitP=jeanHabitPU*jeanHabit;});}),
                BoxDesTenues("assets/images/hautCuir-removebg-preview.png","Tenu en Cuir".tr,tenuCuir==0? "PU : $tenuCuirPU F" : "Prix :".tr + "$tenuCuirP F", tenuCuir,(value) {setState(() {tenuCuir = value;if(tenuCuir<0){tenuCuir=0;}tenuCuirP=tenuCuirPU*tenuCuir;});}),
               ],
            ) : vBas?Column(
             children: [
               BoxDesTenues("assets/images/pantalonCouleur.png","Pantalon Coloré".tr,pantalonSimple==0? "PU : $pantalonSimplePU F" : "Prix :".tr + "$pantalonSimpleP F" , pantalonSimple, (value) {setState(() {pantalonSimple = value;if(pantalonSimple<0){pantalonSimple=0;} pantalonSimpleP=pantalonSimplePU*pantalonSimple;});}),
               BoxDesTenues("assets/images/pantalonBlanc-removebg-preview.png","Pantalon Blanc".tr,pantalonBlanc==0? "PU : $pantalonBlancPU F" : "Prix :".tr + "$pantalonBlancP F" , pantalonBlanc, (value) {setState(() {pantalonBlanc = value;if(pantalonBlanc<0){pantalonBlanc=0;} pantalonBlancP=pantalonBlancPU*pantalonBlanc;});}),
               BoxDesTenues("assets/images/jeanPantalon.jfif","Jean Pantalon".tr,jeanPantalon==0? "PU : $jeanPantalonPU F" : "Prix :".tr + "$jeanPantalonP F" , jeanPantalon, (value) {setState(() {jeanPantalon = value;if(jeanPantalon<0){jeanPantalon=0;} jeanPantalonP=jeanPantalonPU*jeanPantalon;});}),
               BoxDesTenues("assets/images/jupeColore.png","Jupe coloré".tr,jupe==0? "PU : $jupePU F" : "Prix :".tr + "$jupeP F" , jupe, (value) {setState(() {jupe = value;if(robe<0){robe=0;} robeP=robePU*robe;});}),
               BoxDesTenues("assets/images/jupeBlanche.png","Jupe Blanc".tr,jupeBlanc==0? "PU : $jupeBlancPU F" : "Prix :".tr + "$jupeBlancP F" , jupeBlanc, (value) {setState(() {jupeBlanc = value;if(jupeBlanc<0){jupeBlanc=0;} jupeBlancP=jupeBlancPU*jupeBlanc;});}),
            ],
           ): vfull?
           Column(
             children: [
               BoxDesTenues("assets/images/Costume.png","Costume".tr,costume==0? "PU : $costumePU F" : "Prix :".tr + "$costumeP F" , costume, (value) {setState(() {costume = value;if(costume<0){costume=0;} costumeP=costumePU*costume;});}),
               BoxDesTenues("assets/images/image 11.png","Robe".tr,robe==0? "PU : $robePU F" : "Prix :".tr + "$robeP F" , robe, (value) {setState(() {robe = value;if(robe<0){robe=0;} robeP=robePU*robe;});}),
               BoxDesTenues("assets/images/tenuTradi_.png","Tenu Tradi".tr,tenuTradiSimple==0? "PU : $tenuTradiSimplePU F" : "Prix :".tr + "$tenuTradiSimpleP F" , tenuTradiSimple, (value) {setState(() {tenuTradiSimple = value;if(tenuTradiSimple<0){tenuTradiSimple=0;} tenuTradiSimpleP=tenuTradiSimplePU*tenuTradiSimple;});}),
               BoxDesTenues("assets/images/bazin.png","Bazin".tr,bazin==0? "PU : $bazinPU F" : "Prix :".tr + "$bazinP F" , bazin, (value) {setState(() {bazin = value;if(bazin<0){bazin=0;} bazinP=bazinPU*bazin;});}),
               BoxDesTenues("assets/images/agbada.png","Agbada".tr,agbada==0? "PU : $agbadaPU F" : "Prix :".tr + "$agbadaP F" , agbada, (value) {setState(() {agbada = value;if(agbada<0){agbada=0;} agbadaP=agbadaPU*agbada;});}),
               BoxDesTenues("assets/images/pyjama.png","Pyjama".tr,pyjama==0? "PU : $pyjamaPU F" : "Prix :".tr + "$pyjamaP F" , pyjama, (value) {setState(() {pyjama = value;if(pyjama<0){pyjama=0;} pyjamaP=pyjamaPU*pyjama;});}),
             ],
           ): vAutres?
           Column(
             children: [
               BoxDesTenues("assets/images/drap.png","Drap".tr,drap==0? "PU : $drapPU F" : "Prix :".tr + "$drapP F" , drap, (value) {setState(() {drap = value;if(drap<0){drap=0;} drapP=drapPU*drap;});}),
               BoxDesTenues("assets/images/rideaux.png","Rideaux".tr,rideaux==0? "PU : $rideauxPU F" : "Prix :".tr + "$rideauxP F" , rideaux, (value) {setState(() {rideaux = value;if(rideaux<0){rideaux=0;} rideauxP=rideauxPU*rideaux;});}),
               BoxDesTenues("assets/images/serviette-removebg-preview.png".tr,"Serviette",serviette==0? "PU : $serviettePU F" : "Prix :".tr + "$servietteP F" , serviette, (value) {setState(() {serviette = value;if(serviette<0){serviette=0;} servietteP=serviettePU*serviette;});}),
               BoxDesTenues("assets/images/drap.png","Couette".tr,couette==0? "PU : $couettePU F" : "Prix :".tr + "$couetteP F" , couette, (value) {setState(() {couette = value;if(couette<0){couette=0;} couetteP=couettePU*couette;});}),
               BoxDesTenues("assets/images/nappe.png","Nappe".tr,nappe==0? "PU : $nappePU F" : "Prix :".tr + "$nappeP F" , nappe, (value) {setState(() {nappe = value;if(nappe<0){nappe=0;} nappeP=nappePU*nappe;});}),
               BoxDesTenues("assets/images/tapis.png","Tapis/moquette".tr,tapis==0? "PU : $tapisPU F" : "Prix :".tr + "$tapisP F" , tapis, (value) {setState(() {tapis = value;if(tapis<0){tapis=0;} tapisP=tapisPU*tapis;});}),
               BoxDesTenues("assets/images/oreiller-removebg-preview.png","Oreiller".tr,oreiller==0? "PU : $oreillerPU F" : "Prix :".tr + "$oreillerP F" , oreiller, (value) {setState(() {oreiller = value;if(oreiller<0){oreiller=0;} oreillerP=oreillerPU*oreiller;});}),
             ],
           )
               :  Text(""),
            h(0)
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
              height: 120,width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(img),fit: BoxFit.cover)
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
