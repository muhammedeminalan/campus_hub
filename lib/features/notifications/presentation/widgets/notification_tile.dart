import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/notifications/domain/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.item,
    required this.onDismissed,
  });

  final NotificationItem item;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('${item.title}_${item.time}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: _buildDismissBackground(context),
      child: _buildCard(context),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
    return Icon(
          Icons.delete_outline_rounded,
          color: context.onPrimaryColor,
          size: AppSize.v24,
        )
        .paddingOnly(right: AppSize.v24)
        .alignRight
        .container(color: context.errorColor, borderRadius: AppSize.v16);
  }

  Widget _buildCard(BuildContext context) {
    return [
          _buildIconBox(context),
          AppSize.v12.w,
          _buildContent(context).expanded(),
        ]
        .row(crossAxisAlignment: .start)
        .paddingAll(AppSize.v16)
        .container(
          color: context.surfaceColor,
          borderRadius: AppSize.v16,
          border: Border.all(
            color: context.surfaceColor.withValues(alpha: 0.6),
          ),
        )
        .paddingSymmetric(v: AppSize.v6);
  }

  Widget _buildIconBox(BuildContext context) {
    return Icon(
          Icons.notifications_outlined,
          color: context.primaryColor,
          size: AppSize.v20,
        ).center
        .sized(width: AppSize.v44, height: AppSize.v44)
        .container(
          color: context.primaryColor.withAlpha(AppSize.v48.toInt()),
          borderRadius: AppSize.v12,
        );
  }

  Widget _buildContent(BuildContext context) {
    return [
      [
        item.title.text.titleSmall(context).bold.expanded(),
        AppSize.v8.w,
        item.time.text.bodySmall(context),
      ].row(crossAxisAlignment: .start),
      AppSize.v4.h,
      Text(
        item.body,
        style: context.textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
          height: 1.45,
        ),
      ),
    ].column(crossAxisAlignment: .start);
  }
}
