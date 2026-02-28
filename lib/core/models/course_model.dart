/// Ders bilgisini taşıyan model.
///
/// [periodId] → [PeriodModel.id] ile eşleşir; dönem filtrelemesinde kullanılır.
/// [grade]    → Henüz belirlenmemişse "--" geçilir.
class CourseModel {
  final String id;
  final String title;
  final String grade;
  final String classInfo;
  final String instructor;
  final int credit;
  final int akts;
  final String periodId;

  const CourseModel({
    required this.id,
    required this.title,
    required this.grade,
    required this.classInfo,
    required this.instructor,
    required this.credit,
    required this.akts,
    required this.periodId,
  });

  /// Geliştirme / demo aşamasında kullanılan örnek ders listesi.
  /// [periodId] değerleri [PeriodModel.mockList] id'leriyle eşleşir.
  /// Gerçek API entegrasyonunda bu getter kaldırılır.
  static List<CourseModel> get mockList => const [
        // ── 2023-2024 Güz (periodId: '3') ──────────────────────────────────
        CourseModel(
          id: '1',
          title: 'Yazılım Mühendisliği',
          grade: 'BB',
          classInfo: '2.Sınıf - YBS 208 (1)',
          instructor: 'Dr. Öğr. Üyesi Ahmet Yılmaz',
          credit: 3,
          akts: 5,
          periodId: '3',
        ),
        CourseModel(
          id: '2',
          title: 'Veri Tabanı Yönetimi',
          grade: 'AA',
          classInfo: '2.Sınıf - YBS 212 (2)',
          instructor: 'Prof. Dr. Fatma Demir',
          credit: 4,
          akts: 6,
          periodId: '3',
        ),
        CourseModel(
          id: '3',
          title: 'Nesneye Yönelik Programlama',
          grade: 'CB',
          classInfo: '2.Sınıf - YBS 204 (1)',
          instructor: 'Doç. Dr. Mehmet Kaya',
          credit: 3,
          akts: 5,
          periodId: '3',
        ),
        // ── 2023-2024 Bahar (periodId: '4') ─────────────────────────────────
        CourseModel(
          id: '4',
          title: 'Algoritma ve Veri Yapıları',
          grade: 'BA',
          classInfo: '2.Sınıf - YBS 206 (3)',
          instructor: 'Dr. Öğr. Üyesi Zeynep Çelik',
          credit: 4,
          akts: 6,
          periodId: '4',
        ),
        // ── 2024-2025 Güz (periodId: '5') ───────────────────────────────────
        CourseModel(
          id: '5',
          title: 'İşletim Sistemleri',
          grade: 'FF',
          classInfo: '3.Sınıf - YBS 302 (2)',
          instructor: 'Prof. Dr. Ali Şahin',
          credit: 3,
          akts: 5,
          periodId: '5',
        ),
        CourseModel(
          id: '6',
          title: 'Bilgisayar Ağları',
          grade: 'CC',
          classInfo: '3.Sınıf - YBS 306 (1)',
          instructor: 'Doç. Dr. Ayşe Kılıç',
          credit: 3,
          akts: 4,
          periodId: '5',
        ),
      ];
}
