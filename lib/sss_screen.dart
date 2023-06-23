import 'package:flutter/material.dart';

class SSSScreen extends StatelessWidget {
  final List<Map<String, String>> faqList = [
    {
      'soru': 'Neden DiaDose kullanmalıyım?',
      'cevap': 'DiaDose sizin sağlık asistanınızdır.'
    },
    {
      'soru': 'DiaDose ile nasıl kan şekeri ölçebilirim?',
      'cevap': 'DiaDose uygulamasının "Kan Şekeri Ölçümü" bölümünden ölçüm yapabilirsiniz.'
    },
    // Diğer soru-cevap çiftlerini buraya ekleyebilirsiniz
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sıkça Sorulan Sorular'),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sıkça Sorulan Sorular',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Polarband Front',
                color: Color(0xFFF464A7),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: faqList.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(
                      faqList[index]['soru']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          faqList[index]['cevap']!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
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
