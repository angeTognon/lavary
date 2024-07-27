import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_lavery_app/widgetss.dart';
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Map<String, dynamic>> _pages = [
    {
      "title": "Bienvenue sur notre application\nde pressing!".tr,
      'description': 'Nous vous aidons à gérer tous vos besoins de pressing.'.tr,
      'image': 'assets/images/m1.jpg',
    },
    {
      'title': 'Profitez de nos services de qualité'.tr,
      'description': 'Avec nous, vous pouvez compter sur un service rapide et fiable.'.tr,
      'image': 'assets/images/m2.png',
    },
    {
      'title': 'Commencez dès maintenant'.tr,
      'description': 'Téléchargez notre application et lancez votre première commande.'.tr,
      'image': 'assets/images/m11.png',
    },
  ];
bool en =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120.0,left: 15,right:15), // Ajustez cette valeur pour monter les images
                        child: Container(
                          height: 300,width: 300,
                          child: Image.asset(
                            _pages[index]['image'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 200.0, // Ajustez cette valeur pour placer les titres et descriptions plus bas ou plus haut
              left: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  Text(
                    _pages[_currentPage]['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'bold',
                      color: Colors.black
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    _pages[_currentPage]['description'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage == 0
                      ? SizedBox.shrink()
                      : InkWell(
                    onTap: () {

                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,// Fond bleu
                          foregroundColor: Colors.white, // Texte blanc
                        ),
                        child: Text('Précédent'),
                      ),
                    ),
                  ),
                  _currentPage == _pages.length - 1
                      ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor, // Fond bleu
                          foregroundColor: Colors.white, // Texte blanc
                        ),
                        child: Text('Commencer'),
                      ),
                    ),
                  )
                      : InkWell(
                    onTap: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Suivant'),
                      ),
                    ),
                  ),


                ],
              ),
            ),
            Positioned(
              bottom: 64.0, // Ajustez cette valeur pour placer les indicateurs de page plus bas ou plus haut
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => _currentPage == index
                      ? _buildPageIndicator(true)
                      : _buildPageIndicator(false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: isCurrentPage ? 12.0 : 8.0,
      width: isCurrentPage ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.blue : Color.fromARGB(108, 61, 60, 60),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}