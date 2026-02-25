import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../../core/constants/app_sizes.dart';

class LabeledIconRow extends StatelessWidget {
  const LabeledIconRow({
    super.key,
    required this.lable,
    required this.icon,
    this.onPressed,
  });
  final String lable;
  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return [
          lable.text.bold.alignLeft,
          CostumIconButton(
            onPressed: onPressed,
            iconData: icon,
            size: AppSize.v24,
          ),
        ]
        .row(crossAxisAlignment: .center, mainAxisAlignment: .spaceBetween)
        .paddingSymmetric(h: AppSize.v16);
  }
}
