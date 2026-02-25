import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../constants/app_sizes.dart';

class MenuitemCard extends StatelessWidget {
  const MenuitemCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });
  final String label;
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return [
          Icon(icon, size: AppSize.v28),
          AppSize.v8.h,
          label.text.alignCenter.labelMedium(context).fontSize(AppSize.v12),
        ]
        .column(crossAxisAlignment: .center, mainAxisAlignment: .center)
        .paddingAll(AppSize.v12)
        .asCard()
        .onTap(onPressed);
  }
}
