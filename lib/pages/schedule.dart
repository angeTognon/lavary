import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/pages/detail.dart';
import 'package:new_lavery_app/pages/detail_chaussure.dart';
import 'package:new_lavery_app/pages/detail_kg.dart';
import 'package:new_lavery_app/pages/maps.dart';
import 'package:new_lavery_app/pages/maps2.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Schedule extends StatefulWidget {
  String titrePage="";
  String category="";
  String typeServices="";

   Schedule({required this.titrePage, required this.category,required this.typeServices,});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late DateTime selectedDate;
  late DateTime selectedDate2;
  final dt = DateTime.now();
  final dt2 = DateTime.now();
  String _t1="";
  String _t2="";
  bool deliveryNormal = true;
  bool deliveryEx=false;
  String date ="";

  @override
  void initState() {
    date="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    print(date);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainColor,
          primary: mainColor,
          secondary: mainColor,
        ),
        useMaterial3: true,
      ),
      child: Scaffold(
        bottomNavigationBar: Container(
          color: mainColor,
          padding: EdgeInsets.only(left: 15,right: 15),
          height: 70,width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => widget.titrePage=="chaussure"? DetailChaussure(typeService: widget.typeServices,):  Detail(categroy: 'linge',typeService: widget.typeServices,)));
                paiement_en_ligne?null : null;
              },
                  //child: Text(paiement_en_ligne? "Valider La Commande et Payer" : "Valider La Commande",style: TextStyle(
                  child: Text("Continuer".tr,style: TextStyle(
                  color: mainColor,fontFamily: 'bold'
              ),))
            ],
          ),
        ),

          appBar: AppBar(
            backgroundColor: mainColor,
            shadowColor: Colors.black,
            elevation: 3,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
            ),
            title: Text("Informations de livraison".tr,style: TextStyle(
                fontFamily: 'bold',fontSize: 18,color: Colors.white
            ),),
          ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //h(10),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Type de livraison".tr,style: TextStyle(
                      fontFamily: 'bold',fontSize: 16
                  ),),
                ],
              ),
              h(20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      deliveryNormal=true;
                      deliveryEx=false;
                      typeLivraison="Classique";
                    });
                  },
                  child: Container(
                    height: 120,width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: deliveryNormal? mainColor : Colors.grey,width: 1.5)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 10, left: 25,
                            child: Column(
                              children: [
                                Text("Normal",style: TextStyle(
                                  color: deliveryNormal? mainColor : Colors.grey,
                                  fontFamily: 'bold',fontSize: 16
                                ),),
                                Text("Moins de 72 H".tr,style: TextStyle(
                                    color: deliveryNormal? mainColor : Colors.grey,
                                    fontFamily: 'regular',fontSize: 14
                                ),),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),w(40),
                InkWell(
                  onTap: () {
                    setState(() {
                      deliveryNormal=false;
                      deliveryEx=true;
                      typeLivraison="Express";
                    });
                  },
                  child: Container(
                    height: 120,width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: deliveryEx? mainColor : Colors.grey,width: 1.5)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 10, left: 40,
                            child: Column(
                              children: [
                                Text("Express",style: TextStyle(
                                    color: deliveryEx? mainColor : Colors.grey,
                                    fontFamily: 'bold',fontSize: 16
                                ),),
                                Text("- 24 H",style: TextStyle(
                                    color: deliveryEx? mainColor : Colors.grey,
                                    fontFamily: 'regular',fontSize: 14
                                ),),
                              ],
                            )),
                      ],
                    ),
                  ),
                )
              ],),
              h(20),
              Text("Quartier".tr,style: TextStyle(
                  fontFamily: 'bold',fontSize: 15
              ),),
              /* h(20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                height: 160,width: MediaQuery.of(context).size.width,
                child: SearchWithMap(),
              ),
              h(20), */
              Container(
                padding: const EdgeInsets.only(left: 20, top: 12),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                child: Container(
                  height: 50,
                  width: 230,
                  child: TextFormField(
                    controller: quartierCollecte,
                    decoration:  InputDecoration.collapsed(
                        hintText: "Veuillez entrer votre quartier actuel ".tr,
                        hintStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              h(20),
              Text("Date de Collecte ".tr,style: TextStyle(
                  fontFamily: 'bold',fontSize: 15
              ),),
              h(20),
              Container(
                height: 100,
                child: DatePicker(
                  dayTextStyle: TextStyle(fontFamily: 'bold',fontSize: 12),
                  dateTextStyle: TextStyle(fontFamily: 'bold',fontSize: 20),
                  monthTextStyle: TextStyle(fontFamily: 'bold',fontSize: 12),
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: mainColor,
                  width: 80,
                  deactivatedColor: Color(0xFFD0DFF7),
                  selectedTextColor: Color(0xFFD0DFF7),
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      selectedDate = date;
                      dateCollecte="${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                    });
                  },
                ),
              ),
              h(20),
              Text("Heure de Collecte".tr,style: TextStyle(
                  fontFamily: 'bold',fontSize: 15
              ),),

              Container(
                  child: _timePicker1()),

              h(20),
              Text("Quartier Livraison".tr,style: TextStyle(
                  fontFamily: 'bold',fontSize: 15
              ),),
              h(20),
              /* Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                height: 160,width: MediaQuery.of(context).size.width,
                child: SearchWithMap2(),
              ),
              h(20), */
              Container(
                padding: const EdgeInsets.only(left: 20, top: 12),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                child: Container(
                  height: 50,
                  width: 230,
                  child: TextFormField(
                    controller: quartierLivr,
                    decoration:  InputDecoration.collapsed(
                        hintText: "Veuillez entrer votre quartier actuel ".tr,
                        hintStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              h(20),
              Text("Date de Livraison".tr,style: TextStyle(
                  fontFamily: 'bold',fontSize: 15
              ),),
              h(20),
              Container(
                height: 100,
                child: DatePicker(
                  dayTextStyle: TextStyle(fontFamily: 'bold',fontSize: 12),
                  dateTextStyle: TextStyle(fontFamily: 'bold',fontSize: 20),
                  monthTextStyle: TextStyle(fontFamily: 'bold',fontSize: 12),
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: mainColor,
                  width: 80,
                  deactivatedColor: Color(0xFFD0DFF7),
                  selectedTextColor: Color(0xFFD0DFF7),
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      selectedDate2 = date;

                      dateLivr="${selectedDate2.day}-${selectedDate2.month}-${selectedDate2.year}";
                      print(dateLivr);
                    });
                  },
                ),
              ),
              h(20),
              Text("Heure de Livraison ".tr,style: TextStyle(
                  fontFamily: 'bold',fontSize: 15
              ),),

              _timePicker2(),
              h(20),
              Text("Mode de Paiement".tr,style: TextStyle(
                  fontFamily: 'bold',fontSize: 15
              ),),
              h(20),
              InkWell(
                onTap: () {
                  setState(() {
                    paiement_en_ligne=false;
                    paiement_a_la_livraison=true;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 30,width: 30,
                      decoration: BoxDecoration(
                        color : paiement_a_la_livraison? mainColor : Colors.grey,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.black54)
                      ),
                    ), SizedBox(width: 30,),
                    Text("Paiement à la Collecte des linges".tr,style: TextStyle(fontFamily: 'normal',fontSize:15))
                  ],
                ),
              ),
              h(20),
              InkWell(
                onTap: () {
                  setState(() {
                    paiement_en_ligne=true;
                    paiement_a_la_livraison=false;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 30,width: 30,
                      decoration: BoxDecoration(
                          color : paiement_en_ligne? mainColor : Colors.grey,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.black54)
                      ),
                    ), SizedBox(width: 30,),
                    Text("Paiement en ligne".tr,style: TextStyle(fontFamily: 'normal',fontSize:15))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _timePicker2() {
    return Container(
      child: DateTimePicker(
        timePickerTitle: "",
        type: DateTimePickerType.Time,
        is24h: true,
        startTime: DateTime.now(),
        timeInterval: const Duration(minutes: 15),
        onTimeChanged: (time) {
          setState(() {
            _t2 = DateFormat('hh:mm aa').format(time);
            heureLivr=_t2;
          });
        },
      ),
    );
  }
  Widget _timePicker1() {
    return Container(

      child: DateTimePicker(

        timePickerTitle: "",
        type: DateTimePickerType.Time,
        is24h: true,
        startTime: DateTime.now(),
        timeInterval: const Duration(minutes: 15),
        onTimeChanged: (time) {
          setState(() {
            _t1 = DateFormat('hh:mm aa').format(time);
            heureCollecte=_t1;
          });
        },
      ),
    );
  }
}
