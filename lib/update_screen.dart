import 'package:flutter/material.dart';
import 'database_helper.dart';

class UpdateScreen extends StatelessWidget {
  final String date;
  final int patientId;

  UpdateScreen({required this.date, required this.patientId});

  final TextEditingController bloodSugarController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController insulinDoseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Güncelle'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Bugün ki kan şekerinizi giriniz:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: bloodSugarController,
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
                const Text(
                  'Bugün ki kilonuzu giriniz:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Bugünkü kilo değerinizi girin',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Güncel insülin dozunuzu giriniz:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: insulinDoseController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Güncel insülin dozu girin',
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
                    final bloodSugar = int.parse(bloodSugarController.text);
                    final weight = double.parse(weightController.text);
                    final insulinDose = int.parse(insulinDoseController.text);

                    await DatabaseHelper().updateMeasurements(date, bloodSugar);
                    await DatabaseHelper().updatePatientWeight(patientId, weight);
                    await DatabaseHelper().updatePatientInsulinDose(patientId, insulinDose);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verileriniz Güncellenmiştir'),
                      ),
                    );
                  },
                  child: const Text(
                    'Güncelle',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2DE2F2),
                    onPrimary: const Color(0xFFfefcff),
                  ),
                ),
              ],
            ),
          ),
        ],
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
