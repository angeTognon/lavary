import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/main.dart';
import 'registrer.dart';
import 'dart:convert';
import 'package:new_lavery_app/pages/bottom_nav_bar.dart';
import 'package:new_lavery_app/pages/home.dart';
import 'package:new_lavery_app/widgetss.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application de Connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => Home(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/register': (context) =>
            RegisterPage(), // Route pour la page d'inscription
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool show = false;

  login() async {
    setState(() {
      show = true;
    });
    var url =
        "https://feisholadigital.com/backend_lavery_app/connexion.php";
    var response = await http.post(Uri.parse(url), body: {
      'email': _emailOrPhoneController.text,
      'password': _passwordController.text
    });

    var data = json.decode(response.body);
    print(data);
    if (data == "Success") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 3, 78, 5),
        content: Text("Connexion Réussie"),
      ));

      final prefs = await SharedPreferences.getInstance();
      eya = true;
      prefs.setBool('isConnected', eya);

      user_email = _emailOrPhoneController.text;

      final userPref = await SharedPreferences.getInstance();

      userPref.setString('email', _emailOrPhoneController.text);

      show = false;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavBar(),
          ),
          (route) => false);
    } else {
      setState(() {
        show = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Attention"),
          content: Text(
              "L'email ou le mot de passe n'existe pas ! Veuillez réessayer"
                  .tr),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Ok"))
          ],
        ),
      );
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                h(20),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20.0,
                    top: 50.0,
                  ),
                  child: Text(
                    'Connectez-vous'.tr,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'bold',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(
                  'assets/images/m7.png', // Assurez-vous que cette image existe dans votre dossier assets
                  height: 250.0,
                ),
                SizedBox(height: 32.0),
                Container(
                  child: TextFormField(
                    controller: _emailOrPhoneController,
                    decoration: InputDecoration(
                      labelText: 'Email ou Numéro de téléphone'.tr,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'bold',
                          color: Color(0xCD000000)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email ou numéro de téléphone'
                            .tr;
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value) &&
                          !RegExp(r'^\+?0[0-9]{9}$').hasMatch(value)) {
                        return 'Veuillez entrer un email ou numéro de téléphone valide';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe'.tr,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'bold',
                        color: Color(0xCD000000)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: _isPasswordVisible ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe'.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                show
                    ? Center(
                        child: Container(
                            height: 60,
                            width: 60,
                            child: Lottie.asset(
                                "assets/images/auto_loading.json")))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Se connecter'.tr,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 17,
                                    color: Colors.white),
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
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/forgot-password');
                    },
                    child: Text(
                      'Mot de passe oublié?'.tr,
                      style: TextStyle(
                          fontFamily: 'regular',
                          color: Colors.black,
                          fontSize: 15),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Text(
                    'Vous n\'avez pas de compte ? Inscrivez-vous'.tr,
                    style: TextStyle(
                        fontFamily: 'regular',
                        color: Colors.black,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool show = false;
  inscription() async {
    setState(() {
      show = true;
    });
    var url =
        "https://feisholadigital.com/backend_new_lavery_app/updatePassword.php?email=a@gmail.com&new_password=${_passwordController.text}";
    var response = await http.post(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body == "ok") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Reinitialisation Réussie",
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
              "Erreur : Veuillez réessayer ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Réinitialiser votre mot de passe',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              h(15),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              show
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        inscription();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(
                                  'Email pour récupération: ${_emailController.text}');
                              Navigator.of(context).pushNamed('/home');
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Envoyer',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
