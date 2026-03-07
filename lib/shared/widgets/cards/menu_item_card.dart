import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

class MenuitemCard extends StatelessWidget {
  const MenuitemCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return [
          Icon(icon, size: AppSize.v24, color: context.primaryColor)
              .paddingAll(AppSize.v10)
              .container(
                shape: .circle,
                color: context.primaryColor.withValues(alpha: 0.1),
              ),
          label.text.alignCenter.labelMedium(context).fontSize(AppSize.v12),
        ]
        .column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: AppSize.v8,
        )
        .paddingAll(AppSize.v12)
        .asCard()
        .onTap(onPressed);
  }
}
