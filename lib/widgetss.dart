import 'package:flutter/material.dart';

Color mainColor = Color(0xFF0C7AC5);

bool paiement_a_la_livraison=false;
bool paiement_en_ligne=false;
String mylink = "";
String typeLavage="";
String categorieLavage="";
String typeLivraison="Classique";
TextEditingController quartierCollecte=TextEditingController();
TextEditingController quartierLivr=TextEditingController();
String heureCollecte="";
String dateCollecte="";
String heureLivr="";
String dateLivr="";
String dropdownvalue = 'Cliquez ici';

h(double h){
  return SizedBox(height: h,);
}
w(double w){
  return SizedBox(width: w);
}
int montantTotal = 0;

/*La Quantité pour chaque catégo*/
int tshirt = 0;
int chemise = 0;
int pantalonSimple = 0;
int pantalonBlanc = 0;
int jeanHabit = 0;
int jeanPantalon = 0;
int tshirtBlanc = 0;
int chemiseColore = 0;
int pullOverBlanc = 0;
int chemiseBlanc = 0;
int tenuTradiSimple = 0;
int tenuTradiColore = 0;
int bazin = 0;
int agbada = 0;
int manteaux=0;
int manteauxCuir=0;
int trehi=0;
int blouseMedical=0;
int tenuCuir=0;
int tapis=0;
int oreiller = 0;
int rideauxGrand = 0;
int servietteBlanc=0;
int short = 0;
int pullOver = 0;
int jupe = 0;
int jupeBlanc = 0;
int soutiens = 0;
int robe= 0;
int pyjama = 0;
int drap = 0;
int rideaux = 0;
int couette = 0;
int serviette = 0;
int nappe = 0;
int chaussure = 0;
int complet = 0;
int costume = 000;

/*Le prix qui va s'afficher en fonction de la quantité*/
int tshirtP = 0;
int chemiseP = 0;
int pantalonSimpleP = 0;
int pantalonBlancP = 0;
int jeanHabitP = 0;
int jeanPantalonP = 0;
int tshirtBlancP = 0;
int chemiseColoreP = 0;
int pullOverBlancP = 0;
int chemiseBlancP = 0;
int tenuTradiSimpleP = 0;
int tenuTradiColoreP = 0;
int bazinP = 0;
int agbadaP = 0;
int manteauxP=0;
int manteauxCuirP=0;
int trehiP=0;
int blouseMedicalP=0;
int tenuCuirP=0;
int tapisP=0;
int oreillerP = 0;
int rideauxGrandP = 0;
int servietteBlancP=0;
int shortP = 0;
int pullOverP = 0;
int jupeP= 0;
int jupeBlancP = 0;
int soutiensP = 0;
int robeP = 0;
int pyjamaP = 0;
int drapP = 0;
int rideauxP = 0;
int couetteP = 0;
int servietteP = 0;
int nappeP = 0;
int chaussureP = 0;
int completP = 0;
int costumeP = 000;

/*Le prix unitaire : */
int basketPU = 500;
int chaussureSportPU = 500;
int BallerinePU = 500;
int EscapinPU = 700;
int mocassinPU = 500;
int sandalePU = 500;
int bottesPU = 800;

int basket = 0;
int chaussureSport = 0;
int Ballerine = 0;
int Escapin = 0;
int mocassin = 0;
int sandale = 0;
int bottes = 0;
int basketP = 0;
int chaussureSportP = 0;
int BallerineP = 0;
int EscapinP = 0;
int mocassinP = 0;
int sandaleP = 0;
int bottesP = 0;

/*Le prix unitaire : */
int tshirtPU = 500;
int chemisePU = 500;
int pantalonSimplePU = 500;
int pantalonBlancPU = 700;
int jeanHabitPU = 500;
int jeanPantalonPU = 500;
int tshirtBlancPU = 800;
int pullOverBlancPU = 1500;
int chemiseBlancPU = 800;
int tenuTradiSimplePU = 1000;
int bazinPU = 1500;
int agbadaPU = 2500;
int manteauxPU=1000;
int manteauxCuirPU=1500;
int trehiPU=1500;
int blouseMedicalPU=25;
int tenuCuirPU=1500;
int tapisPU=5000;
int oreillerPU = 500;
int rideauxGrandPU = 1000;
int servietteBlancPU=800;
int pullOverPU = 1500;
int jupePU = 500;
int jupeBlancPU = 700;
int robePU = 1000;
int pyjamaPU = 1000;
int rideauxPU = 500;
int couettePU = 1500;
int serviettePU = 500;
int nappePU = 500;
int drapPU = 25;
int costumePU = 2500;
int nombreTotal = 0;