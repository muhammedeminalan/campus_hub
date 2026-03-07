import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Seçili dönemi başlık satırı olarak gösteren, tıklanınca dönem seçim
/// sheet'ini açmak için kullanılan dokunulabilir widget.
class PeriodSelector extends StatelessWidget {
  const PeriodSelector({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final PeriodModel selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return [
          Icon(
            Icons.calendar_month_outlined,
            size: AppSize.v20,
            color: context.primaryColor,
          ),
          selected.name.text.semiBold
              .fontSize(AppSize.v14)
              .color(AppColors.textPrimary)
              .expanded(),
          Icon(Icons.filter_list_alt, color: context.primaryColor),
        ]
        .row(spacing: AppSize.v12)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v14)
        .container(
          color: AppColors.surface,
          borderRadius: AppSize.v12,
          border: Border.all(color: AppColors.border),
        )
        .onTap(onTap);
  }
}
