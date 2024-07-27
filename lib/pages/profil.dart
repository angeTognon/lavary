import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/main.dart';
import 'package:new_lavery_app/pages/etape1/login.dart';
import 'package:new_lavery_app/pages/profil/confidentialite.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_lavery_app/main.dart';


class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  File? image;
  var uploadimage;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      uploadimage = File(image.path);
      setState(() => this.image = uploadimage);
    } on PlatformException catch (e) {
      //print('Failed to pick image: $e');
    }
  }

  String base64String = "";

  Random random = new Random();
  int? randomNumber;

  Future<void> uploadImage() async {
    String uploadurl =
        "https://tabaskimood.com/lac/feishola/article_image_upload.php";

    Uint8List _bytes = await uploadimage.readAsBytes();

    String _base64String = base64.encode(_bytes);
    base64String = _base64String;
    //print(base64String);

    var response = await http.post(Uri.parse(uploadurl), body: {
      'image': base64String,
      'mail': "$user_email" + "$randomNumber"
    });
    if (response.statusCode == 200) {
      // //print(response.body);
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        //print(jsondata["msg"]);
      } else {
        //print("Upload successful");
      }
    } else {
      //print("Error during connection to server");
    }
  }



  getUserProfile() async {
    var url =
        "https://feisholadigital.com/backend_lavery_app/get_user_profile.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    var pub = await json.decode(response.body);
    return pub;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,

        title: Text("Profil",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,fontFamily: "regular",),),
       centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
        
          children: [
            SizedBox(height: 30,),

            Container(
              height: 140,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width/3,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(100),
                          color: uploadimage == null
                              ? Colors.white
                              : Colors.white),
                      child: Center(
                        child: uploadimage == null
                            ? ClipOval(
                          child: Image.asset(
                            "assets/images/profil.jpg",
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ): Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  100),
                              image: DecorationImage(
                                  image: FileImage(
                                      uploadimage!),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: MediaQuery.of(context).size.width/2.5,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                        Future.delayed(
                          Duration(seconds: 10),
                              () {
                            uploadImage();
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Icon(
                            Icons.edit,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 140,
              child: FutureBuilder(
                future: getUserProfile(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Erreur de chargement. Veuillez relancer l'application".tr),
                    );
                  }
                  if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [

                              SizedBox(height: 15,),
                              Text(snapshot.data![index]['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "regular",),),
                              SizedBox(height: 10,),
                              Text(snapshot.data![index]['email'],style: TextStyle(fontSize: 18,fontFamily: "regular",),),
                              SizedBox(height: 10,),
                              Text(snapshot.data![index]['phone'],style: TextStyle(fontSize: 18,fontFamily: "regular",),),
                              SizedBox(height: 15,),
                              Container(
                                width: 250,
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                ),

                              ),
                            ],
                          ) ;  },
                      ),
                    );
                  }
                  return Container(
                      height: 50,
                      width: 50,
                      child: Center(
                          child: Lottie.asset("assets/images/auto_loading.json",
                              height: 150)));
                },
              ),
            ),
            SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: InkWell(
        
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15,),
                        child: Row(
                          children: [
                            Icon(Icons.edit,color: Colors.blue,),
                            SizedBox(width: 10,),
                            Text("Editer profil".tr,style: TextStyle(fontSize: 18,fontFamily: "regular",),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15,right: 10),
                        child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfidentialitePage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15,),
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet,color: Colors.blue,),
                            SizedBox(width: 10,),
                            Text("Confidentialité".tr,style: TextStyle(fontSize: 18,fontFamily: "regular",),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15,right: 10),
                        child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15,),
                      child: Row(
                        children: [
                          Icon(Icons.settings,color: Colors.blue,),
                          SizedBox(width: 10,),
                          Text("Paramettre".tr,style: TextStyle(fontSize: 18,fontFamily: "regular",),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15,right: 10),
                      child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
           InkWell(
             onTap: () async{
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
               final prefs = await SharedPreferences.getInstance();
               eya = false;
               prefs.setBool('isConnected', eya);
               print(eya);
               Phoenix.rebirth(context);
             },
             child: Padding(
               padding: const EdgeInsets.only(left: 15,right: 15),
               child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black12,
                       blurRadius: 4.0,
                       offset: Offset(0, 3),
                     ),
                   ],
                 ),
                 child: Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15,right: 20),
                       child: Row(
                         children: [
                           Icon(Icons.logout,color: Colors.blue,),
                           SizedBox(width: 10,),
                           Text("Deconnexion".tr,style: TextStyle(fontSize: 18,fontFamily: "regular",),),
                         ],
                       ),
                     ),
                   ],
                 ),



               ),
             ),
           ),

            SizedBox(
              height: 95,
            ),
          ],
        ),
      ),
    );
  }
}
