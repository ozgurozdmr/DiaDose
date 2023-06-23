import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bitirme_proje/database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  int _loginAttempts = 0;
  final int _maxLoginAttempts = 3;

  DatabaseHelper _databaseHelper = DatabaseHelper();

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    bool isAuthenticated = await _databaseHelper.authenticateUser(email, password);

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _loginAttempts++;
      });

      if (_loginAttempts >= _maxLoginAttempts) {
        WidgetsBinding.instance!.addPostFrameCallback((_) => exit(0));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _login(context),
                child: const Text('Giriş Yap'),
                
              ),
              const SizedBox(height: 16.0),
              Text(
                _loginAttempts >= _maxLoginAttempts
                    ? '3 kez yanlış giriş yapıldı. Uygulama kapanacak!'
                    : (_loginAttempts > 0 ? 'Kullanıcı adı veya şifre hatalı!' : ''),
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Hesabınız yoksa Kayıt Olun'),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = const Color(0xFF2DE2F2);

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.7, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.5);
    path.close();
    canvas.drawPath(path, paint);

    paint.color = const Color(0xFF3BC7E7);

    final path2 = Path();
    path2.moveTo(size.width, 0);
    path2.lineTo(size.width, size.height);
    path2.lineTo(size.width * 0.3, size.height * 0.7);
    path2.lineTo(size.width * 0.3, size.height * 0.3);
    path2.close();
    canvas.drawPath(path2, paint);

    paint.color = const Color(0xFF5D86CC);

    final path3 = Path();
    path3.moveTo(0, size.height);
    path3.lineTo(size.width, size.height);
    path3.lineTo(size.width * 0.7, size.height * 0.5);
    path3.lineTo(size.width * 0.3, size.height * 0.5);
    path3.close();
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

