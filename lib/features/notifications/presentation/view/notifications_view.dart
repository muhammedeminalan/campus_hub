import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/mock/fixtures/notification_fixture.dart';
import 'package:campus_hub/features/notifications/domain/notification_item.dart';
import 'package:campus_hub/features/notifications/presentation/widgets/notification_empty_state.dart';
import 'package:campus_hub/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

  final ValueNotifier<List<NotificationItem>> _itemsNotifier = ValueNotifier(
    NotificationFixture.items,
  );

  void _markAllRead() {
    _itemsNotifier.value = _itemsNotifier.value
        .map(
          (n) => NotificationItem(
            title: n.title,
            body: n.body,
            time: n.time,
            isRead: true,
          ),
        )
        .toList();
  }

  void _dismiss(int index) {
    final updated = List<NotificationItem>.from(_itemsNotifier.value)
      ..removeAt(index);
    _itemsNotifier.value = updated;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<NotificationItem>>(
      valueListenable: _itemsNotifier,
      builder: (context, items, _) {
        final unreadCount = items.where((n) => !n.isRead).length;
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: CoreAppBar(
            title: AppStrings.notifications,
            actions: [
              if (unreadCount > 0)
                TextButton(
                  onPressed: _markAllRead,
                  child: const Text(
                    'Tümünü oku',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
            ],
          ),
          body: items.isEmpty
              ? const NotificationEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSize.v8,
                    horizontal: AppSize.v16,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) => NotificationTile(
                    item: items[index],
                    onDismissed: () => _dismiss(index),
                  ),
                ),
        );
      },
    );
  }
}
