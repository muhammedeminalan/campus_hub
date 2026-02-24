import 'package:campus_hub/core/constants/app_assets.dart';
import 'package:campus_hub/core/constants/app_strings.dart';

/// Öğrenci kimlik kartında gösterilen tüm veriler.
///
/// [ProfilCard] bu modeli alır; ileride Firebase / API'dan map'lenebilir.
class StudentCardModel {
  const StudentCardModel({
    required this.name,         // Öğrenci adı soyadı
    required this.studentNo,    // Öğrenci numarası
    required this.university,   // Üniversite adı
    required this.faculty,      // Fakülte adı
    required this.department,   // Bölüm adı
    required this.studentClass, // Sınıf (1-4)
    required this.ano,          // Dönemlik not ortalaması
    required this.agno,         // Genel akademik not ortalaması
    required this.date,         // Kart yayım / güncelleme tarihi
    required this.avatarPath,   // Profil fotoğrafı asset yolu
  });

  final String name;
  final String studentNo;
  final String university;
  final String faculty;
  final String department;
  final String studentClass;
  final String ano;
  final String agno;
  final String date;
  final String avatarPath;

  /// Geliştirme / demo aşamasında kullanılan varsayılan öğrenci verisi.
  /// Gerçek veri geldiğinde bu factory kaldırılır veya test fixture'ına taşınır.
  factory StudentCardModel.mock() => const StudentCardModel(
        name: AppStrings.studentCardName,
        studentNo: AppStrings.studentCardNo,
        university: AppStrings.studentCardUniversity,
        faculty: AppStrings.studentCardFaculty,
        department: AppStrings.studentCardDepartment,
        studentClass: AppStrings.studentCardClass,
        ano: AppStrings.studentCardANO,
        agno: AppStrings.studentCardAGNO,
        date: AppStrings.studentCardDateTime,
        avatarPath: AppAssets.avatar,
      );
}
