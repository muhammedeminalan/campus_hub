import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String grade; // not hesaplanmadıysa "--" geçilir
  final String classInfo; // "2.Sınıf - YBS 208 (1)"
  final String instructor;
  final int credit;
  final int akts;

  const CourseCard({
    super.key,
    required this.title,
    required this.grade,
    required this.classInfo,
    required this.instructor,
    required this.credit,
    required this.akts,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Hafif gölge ile kart görünümü
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst başlık alanı — koyu mavi arka plan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFF2E6DA4),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Alt sarı çizgi — tasarımda ince bir ayraç var
          Container(height: 3, color: const Color(0xFFE8A838)),

          // İçerik alanı
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Not dairesi — not yoksa "--" gösterir
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE8A838),
                      width: 2.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    grade,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Ders bilgileri
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classInfo,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        instructor,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Kredi ve AKTS yan yana
                      Text(
                        'Kredi : $credit    AKTS : $akts',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ],
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
