/// Akademik danışman görüşme saati bilgisi.
class AdvisorOfficeHour {
  final String day;
  final String timeRange;

  const AdvisorOfficeHour({required this.day, required this.timeRange});
}

/// Akademik danışman domain modeli.
///
/// Öğrencinin atanmış akademik danışmanına ait tüm iletişim ve program
/// bilgilerini taşır.
class AdvisorModel {
  final String id;
  final String name;
  final String title;
  final String email;
  final String phone;
  final String office;
  final String department;
  final List<AdvisorOfficeHour> officeHours;

  const AdvisorModel({
    required this.id,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.office,
    required this.department,
    required this.officeHours,
  });
}
