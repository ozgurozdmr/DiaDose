import 'package:flutter/material.dart';
import 'package:bitirme_proje/homepage.dart';
import 'package:bitirme_proje/login_screen.dart';
import 'package:bitirme_proje/register_screen.dart';
import 'package:bitirme_proje/splash_screen.dart';
import 'package:bitirme_proje/settings_screen.dart';
import 'package:bitirme_proje/sss_screen.dart';
import 'package:bitirme_proje/dose_cal_screen.dart';
import 'package:bitirme_proje/nasilsin_screen.dart';
import 'package:bitirme_proje/update_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'package:bitirme_proje/profil_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'bitirme.db');

  print('Veritabanı Yolu: $dbPath');

  DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.initDatabase(); // Veritabanını başlat

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String selectedDate = ''; // Seçili tarihi burada tanımlayın
  final int patientId = 0; // Hasta kimliğini burada tanımlayın

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF45D1FD),
        brightness: Brightness.light, // Aydınlık tema
        // Diğer tema özelliklerini buraya ekleyebilirsiniz
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Karanlık tema
        // Diğer tema özelliklerini buraya ekleyebilirsiniz
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsScreen(),
        '/sss': (context) => SSSScreen(),
        '/dose_cal': (context) => DoseCalScreen(),
        '/nasilsin': (context) => NasilsinScreen(),
        '/update': (context) => UpdateScreen(date: selectedDate, patientId: patientId),
        '/profil': (context) => ProfilScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/register') {
          return MaterialPageRoute(
            builder: (context) => RegisterScreen(),
            fullscreenDialog: true,
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      },
    );
  }
}
