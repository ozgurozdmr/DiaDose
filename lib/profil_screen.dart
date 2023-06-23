import 'package:flutter/material.dart';
import 'package:bitirme_proje/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _kilogramController = TextEditingController();
  final TextEditingController _otherIllnessesController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Kullanıcı bilgileri
  String _name = '';
  String _surname = '';
  String _email = '';
  String _password = '';
  String _birthDate = '';
  String _kilogram = '';
  String _otherIllnesses = '';

  bool _passwordVisible = false; // Şifrenin görünürlüğünü kontrol etmek için

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _birthDateController.dispose();
    _kilogramController.dispose();
    _otherIllnessesController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    // Kullanıcı verilerini veritabanından al
    int patientId = 1; // Örnek olarak varsayılan bir hasta ID'si
    Map<String, dynamic> userData = await DatabaseHelper().getHastaBilgi(patientId);

    if (userData != null) {
      setState(() {
        _name = userData['name'];
        _surname = userData['surname'];
        _email = userData['email'];
        _password = userData['password'];
        _birthDate = userData['birth_date'] ?? '';
        _kilogram = userData['kilogram'] ?? '';
        _otherIllnesses = userData['other_illnesses'] ?? '';
      });
    }
  }

  Future<void> _updateProfile() async {
    String name = _nameController.text;
    String surname = _surnameController.text;
    String email = _emailController.text;
    String birthDate = _birthDateController.text;
    String kilogram = _kilogramController.text;
    String otherIllnesses = _otherIllnessesController.text;

    // Verilerin boş geçilememesi kontrolü
    if (name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        birthDate.isEmpty ||
        kilogram.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Eksik Bilgi'),
            content: const Text('Lütfen tüm alanları doldurun.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Güncelleme işlemi
    int patientId = 1; // Örnek olarak varsayılan bir hasta ID'si
    Map<String, dynamic> updatedHastaBilgi = {
      'id': patientId,
      'name': name,
      'surname': surname,
      'email': email,
      'birth_date': birthDate,
      'kilogram': kilogram,
      'other_illnesses': otherIllnesses,
    };

    await DatabaseHelper().updatePatientInfo(updatedHastaBilgi);


    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profil Güncellendi'),
          content: const Text('Profil bilgileriniz başarıyla güncellendi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2DE2F2),
                Color(0xFF3BC7E7),
                Color(0xFF5D86CC),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ad',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Soyad',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _birthDateController,
                decoration: const InputDecoration(
                  labelText: 'Doğum Tarihi',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _kilogramController,
                decoration: const InputDecoration(
                  labelText: 'Kilogram',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _otherIllnessesController,
                decoration: const InputDecoration(
                  labelText: 'Diğer Hastalıklar',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
               const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Şifre',
                      filled: true,
                    fillColor: Colors.white,
                    ),
                    obscureText: !_passwordVisible,
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ],
            ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Güncelle'),
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