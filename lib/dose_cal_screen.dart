import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DoseCalScreen extends StatefulWidget {
  @override
  _DoseCalScreenState createState() => _DoseCalScreenState();
}

class _DoseCalScreenState extends State<DoseCalScreen> {
  int gks = 0;
  int gkid = 0;
  double unite = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doz Hesaplama'),
      ),
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Güncel Kan Şekerini Giriniz',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    gks = int.tryParse(value) ?? 0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Kan şekeri değeri girin',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final databasePath = await getDatabasesPath();
                    final database = await openDatabase(
                      join(databasePath, 'bitirme.db'),
                      version: 1,
                    );

                    final patientsTable = await database.query('patients');
                    if (patientsTable.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text('Lütfen bilgilerinizi güncelleyin'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    final Map<String, dynamic>? patient = patientsTable.first;
                    gkid = patient != null ? patient['insulin_dose'] as int? ?? 0 : 0;

                    setState(() {
                      unite = (gks - 140) / (1800 / gkid);
                      unite = unite > 4 ? 4 : unite;
                    });

                    if (unite <= 0) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Doz Hesaplama Sonucu'),
                            content: Text('Ekstra doz uygulamanıza gerek yoktur.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Doz Hesaplama Sonucu'),
                            content: Text('${unite.toStringAsFixed(2)} ünite kadar insülin yapın lütfen.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } catch (e) {
                    print('Veritabanı hatası: $e');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: Text(
                    'Doz Hesapla',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFEFCFF),
                  onPrimary: const Color(0xFFF569A6),
                  padding: const EdgeInsets.all(16.0), // Butonun boyutunu ayarlamak için padding eklendi
                ),
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
