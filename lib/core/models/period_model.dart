/// Dönem bilgisini taşıyan model.
///
/// [id]   → API filtrelemede kullanılan tanımlayıcı.
/// [name] → UI'da gösterilen dönem adı (ör. "2023-2024 Güz").
class PeriodModel {
  final String id;
  final String name;

  const PeriodModel({required this.id, required this.name});

  /// Geliştirme / demo aşamasında kullanılan örnek dönem listesi.
  /// Gerçek API entegrasyonunda bu getter kaldırılır.
  static List<PeriodModel> get mockList => const [
        PeriodModel(id: '1', name: '2022-2023 Güz'),
        PeriodModel(id: '2', name: '2022-2023 Bahar'),
        PeriodModel(id: '3', name: '2023-2024 Güz'),
        PeriodModel(id: '4', name: '2023-2024 Bahar'),
        PeriodModel(id: '5', name: '2024-2025 Güz'),
        PeriodModel(id: '6', name: '2024-2025 Bahar'),
      ];
}
