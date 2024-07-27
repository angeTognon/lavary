import 'package:flutter/material.dart';
import 'package:new_lavery_app/lang.dart';
import 'package:new_lavery_app/pages/bottom_nav_bar.dart';
import 'package:new_lavery_app/pages/etape1/login.dart';
import 'package:new_lavery_app/pages/etape1/onboarding.dart';
import 'package:new_lavery_app/pages/etape1/registrer.dart';
/*import 'package:new_lavery_app/sreens/pages/bottom_nav_bar.dart';*/
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
bool isFirstRun = false;
bool isFirstCall = false;

String currentUserId = "";
bool eya = false;
bool clientC = false;
bool etatCompte = false;
String currentUserEmail = "";
String userName = "";
String imagPath = "";
String user_email = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefss = await SharedPreferences.getInstance();
  final isClient = prefss.getBool('isClient') ?? false;

  final prefsss = await SharedPreferences.getInstance();
  final isActivated = prefsss.getBool('isActivated') ?? false;

  final prefs = await SharedPreferences.getInstance();
  final isConnected = prefs.getBool('isConnected') ?? false;

  final userPref = await SharedPreferences.getInstance();
  user_email = userPref.getString('email') ?? "";

  eya = isConnected;
  clientC = isClient;
  etatCompte = isActivated;
  runApp(Phoenix(child: MyApp(isConnected: isConnected)));
}

class MyApp extends StatefulWidget {
  final isConnected;
  MyApp({required this.isConnected});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _checkFirstRun() async {
    // verifier si l'utlisateur est connecté ou pas
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      isFirstRun = ifr;
    });
  }

  void _checkFirstCall() async {
    bool ifc = await IsFirstRun.isFirstCall();
    setState(() {
      isFirstCall = ifc;
    });
  }

  @override
  void initState() {
    _checkFirstRun();
    _checkFirstCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: Locale('fr', 'FR'),
      title: 'Lavery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isFirstCall
          ? OnboardingScreen()
          : isFirstCall == false && eya == false
              ? LoginPage()
              : MyBottomNavBar(),
      // home: isFirstCall? OnboardingScreen() : isFirstCall== false && eya==false?  LoginPage() : MyBottomNavBar(),

      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/forgot-password': (context) =>
            ForgotPasswordPage(), //Page de recuperation mot de passe
      },
    );
  }
}
