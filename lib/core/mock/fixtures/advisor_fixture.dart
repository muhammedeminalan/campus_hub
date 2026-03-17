import 'package:campus_hub/features/academic_advisor/data/model/advisor_model.dart';

/// Akademik danışman örnek verileri.
///
/// Gerçek API entegrasyonunda bu dosya kaldırılır veya test fixture'ına taşınır.
/// [IAcademicAdvisorService] mock implementasyonu bu class'a referans verir.
abstract final class AdvisorFixture {
  static const AdvisorModel advisor = AdvisorModel(
    id: '1',
    name: 'Prof. Dr. Ayşe Kaya',
    title: 'Prof. Dr.',
    email: 'ayse.kaya@gumushane.edu.tr',
    phone: '+90 456 233 74 00 / 3210',
    office: 'İİBF Binası - Kat 2 - Oda 204',
    department: 'Yönetim Bilişim Sistemleri',
    officeHours: [
      AdvisorOfficeHour(day: 'Pazartesi', timeRange: '10:00 - 12:00'),
      AdvisorOfficeHour(day: 'Çarşamba', timeRange: '14:00 - 16:00'),
      AdvisorOfficeHour(day: 'Cuma', timeRange: '10:00 - 11:00'),
    ],
  );
}
