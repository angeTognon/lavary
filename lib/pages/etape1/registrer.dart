import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_lavery_app/pages/etape1/login.dart';
import 'package:new_lavery_app/pages/home.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool show = false;

  inscription() async {
    setState(() {
      show = true;
    });
    var url =
        "https://feisholadigital.com/backend_lavery_app/inscription.php?name=${_nameController.text}&email=${_emailController.text}&phone=${_phoneController.text}&profil=d&password=${_passwordController.text}";
    var response = await http.post(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Inscription Réussie",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (route) => false);
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur : Il semble que cette adresse mail a déjà été utilisée ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }
bool en = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            en = !en;
            if (en) {
              var locale = Locale('en', 'US');
              Get.updateLocale(locale);
            } else {
              var locale = Locale('fr', 'FR');
              Get.updateLocale(locale);
            }
          });
        },
        child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Text(
              en == true ? "EN" : "FR",
              style: TextStyle(
                  fontFamily: 'bold', color: Colors.white, fontSize: 16),
            ))),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 20.0,
                  top: 50.0,
                ),
                child: Text(
                  'Créer un compte'.tr,
                  style: TextStyle(
                    fontSize: 20.0, 
                    fontFamily: 'bold',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                'assets/images/m7.png',
                height: 250.0,
              ),
              SizedBox(height: 32.0),
              Container(
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom'.tr,
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                      labelStyle: TextStyle(fontSize: 15,fontFamily: 'bold',color: Color(0xCD000000))
                  ),
                  style: TextStyle(fontSize: 12.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Adresse e-mail'.tr,
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                      labelStyle: TextStyle(fontSize: 15,fontFamily: 'bold',color: Color(0xCD000000))
                  ),
                  style: TextStyle(fontSize: 12.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {

                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Numéro de téléphone'.tr,
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                      labelStyle: TextStyle(fontSize: 15,fontFamily: 'bold',color: Color(0xCD000000))
                  ),
                  style: TextStyle(fontSize: 12.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe'.tr,
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                      labelStyle: TextStyle(fontSize: 15,fontFamily: 'bold',color: Color(0xCD000000))
                  ),
                  style: TextStyle(fontSize: 12.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 32.0),
              show
                  ? Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: Lottie.asset("assets/images/auto_loading.json")))
                  : MouseRegion(
                      cursor: SystemMouseCursors.click,
                          child: Container(
  margin: EdgeInsets.symmetric(horizontal: 22.0), // Ajout des marges horizontales
  width: 120, // Largeur fixe du bouton
  height: 45, // Diminution de la hauteur du bouton
  child: ElevatedButton(
    onPressed: () {
      if (_phoneController.text.isEmpty || _passwordController.text.isEmpty || _emailController.text.isEmpty || _nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Color(0xFFB0201B),content: Text("Veuillez remplir tous les champs",style: TextStyle(fontFamily: 'bold',),)));
      }else{
       inscription();
      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
      }
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0), // Ajustement du padding vertical
      child: Text(
        'S\'inscrire'.tr,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
),

                    ),
              SizedBox(height: 12.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text(
                      'Vous avez déjà un compte ? Se connecter'.tr,
                      style: TextStyle(color: Colors.black,fontFamily: 'bold'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
