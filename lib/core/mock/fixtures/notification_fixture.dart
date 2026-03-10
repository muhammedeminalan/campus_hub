import 'package:campus_hub/features/notifications/domain/notification_item.dart';

/// Geliştirme / demo aşamasında kullanılan bildirim örnek verileri.
///
/// Gerçek API entegrasyonunda bu dosya kaldırılır veya test fixture'ına taşınır.
abstract final class NotificationFixture {
  static final List<NotificationItem> items = [
    const NotificationItem(
      title: 'Sınav Programı Güncellendi',
      body: 'Veri Yapıları sınavı 15 Mart\'a alındı.',
      time: 'Az önce',
    ),
    const NotificationItem(
      title: 'Not Girişi Tamamlandı',
      body: 'Yazılım Mühendisliği notlarınız işlendi.',
      time: '1 saat önce',
    ),
    const NotificationItem(
      title: 'Burs Başvuruları Açıldı',
      body: 'KYK burs başvuruları 20 Mart\'a kadar.',
      time: '3 saat önce',
      isRead: true,
    ),
    const NotificationItem(
      title: 'Kariyer Fuarı',
      body: 'Yarın 10:00\'da Konferans Salonu\'nda.',
      time: 'Dün',
    ),
    const NotificationItem(
      title: 'Devamsızlık Uyarısı',
      body: 'İşletim Sistemleri dersinde sınıra yaklaştınız.',
      time: '2 gün önce',
      isRead: true,
    ),
  ];
}
