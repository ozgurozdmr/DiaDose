import 'package:bitirme_proje/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_proje/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Bir süre bekledikten sonra yeni sayfaya yönlendirmek için Timer kullanabilirsiniz
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffefcff), // Splash ekranının arka plan rengi
      body: Center(
        child: Image.asset(
          'images/DiaDoseLogo.png' // Splash arka plan resmi
        ),
      ),
    );
  }
}
