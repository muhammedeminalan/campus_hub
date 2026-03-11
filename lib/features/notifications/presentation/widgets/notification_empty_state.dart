import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.notifications_off_outlined,
        size: AppSize.v64,
        color: context.primaryColor,
      ),
      AppSize.v12.h,
      "Bildirim yok".text.bodyLarge(context),
    ].column(mainAxisSize: .min).center;
  }
}
