/// Hızlı menü öğelerinin hedef sayfalarını temsil eden enum.
///
/// [MenuItemModel] artık `Widget page` yerine bu enum'u taşır.
/// Gerçek sayfa çözümlemesi [QuickMenuNavigator] tarafından yapılır;
/// böylece model katmanı Flutter widget'larına bağımlı olmaz.
enum QuickMenuRoute {
  attendance,
  examSchedule,
  academicCalendar,
  takenCourses,
  examResults,
  termAverages,
  transcript,
  courseSchedule,
  tuitionInfo,
  absenceStatus,
  academicStatus,
  curriculum,
  todos,
  academicAdvisor,
  preparatoryInfo,
}
