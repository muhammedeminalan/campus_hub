import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import '../../../../core/constants/app_sizes.dart';

class LabeledIconRow extends StatelessWidget {
  const LabeledIconRow({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
  });
  final String label;
  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return [
          label.text.bold.alignLeft,
          Wonzy.button.icon(
            onPressed: onPressed,
            iconData: icon,
            size: AppSize.v24,
          ),
        ]
        .row(crossAxisAlignment: .center, mainAxisAlignment: .spaceBetween)
        .paddingSymmetric(h: AppSize.v16);
  }
}
