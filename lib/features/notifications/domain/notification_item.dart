class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
  });

  final String title;
  final String body;
  final String time;
  final bool isRead;
}
