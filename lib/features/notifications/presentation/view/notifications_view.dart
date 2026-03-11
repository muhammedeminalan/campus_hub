import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/mock/fixtures/notification_fixture.dart';
import 'package:campus_hub/features/notifications/domain/notification_item.dart';
import 'package:campus_hub/features/notifications/presentation/widgets/notification_empty_state.dart';
import 'package:campus_hub/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:campus_hub/shared/widgets/lists/app_list_view.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

  final ValueNotifier<List<NotificationItem>> _itemsNotifier = ValueNotifier(
    NotificationFixture.items,
  );

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
        return Scaffold(
          appBar: const CoreAppBar(title: AppStrings.notifications),
          body: AppListView<NotificationItem>(
            items: items,
            emptyWidget: const NotificationEmptyState(),
            padding: const .symmetric(
              vertical: AppSize.v8,
              horizontal: AppSize.v16,
            ),
            itemBuilder: (context, item, index) => NotificationTile(
              item: item,
              onDismissed: () => _dismiss(index),
            ),
          ),
        );
      },
    );
  }
}
