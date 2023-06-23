import 'package:flutter/material.dart';

class NasilsinScreen extends StatefulWidget {
  @override
  _NasilsinScreenState createState() => _NasilsinScreenState();
}

class _NasilsinScreenState extends State<NasilsinScreen> {
  int rating1 = 0;
  int rating2 = 0;
  int rating3 = 0;

  Widget buildStar(int index, int rating) {
    return GestureDetector(
      onTap: () {
        setState(() {
          rating = index;
        });
      },
      child: Icon(
        Icons.star,
        color: index <= rating ? const Color(0xFFFF12FB) : const Color(0xFFFEFCFF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nasılsın?'),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kendini nasıl hissediyorsun?',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    buildStar(i, rating1),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Bugün iyi misin?',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    buildStar(i, rating2),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'DiaDose\'den memnun musun?',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    buildStar(i, rating3),
                ],
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