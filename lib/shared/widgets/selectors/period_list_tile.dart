import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

/// Dönem seçim listesinde her bir dönemi temsil eden tile widget'ı.
/// Seçili durumda renk, ikon ve ağırlık değişimi ile görsel geri bildirim sağlar.
class PeriodListTile extends StatelessWidget {
  const PeriodListTile({
    super.key,
    required this.period,
    required this.isSelected,
    required this.onTap,
  });

  /// Gösterilecek dönem metni (ör. "2025-2026 Güz Dönemi")
  final String period;

  /// Bu dönem şu an seçili mi
  final bool isSelected;

  /// Tile'a tıklandığında tetiklenen callback
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.calendar_month_outlined,
        size: AppSize.v20,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title:
          (isSelected
                  ? period.text.semiBold.color(AppColors.primary)
                  : period.text.color(AppColors.textPrimary))
              .titleMedium(context),
      trailing: isSelected
          ? const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
              size: AppSize.v20,
            )
          : null,
      tileColor: isSelected
          ? AppColors.primary.withValues(alpha: 0.07)
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AppSize.v10.radius),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSize.v8,
        vertical: AppSize.v4,
      ),
      onTap: onTap,
    );
  }
}
