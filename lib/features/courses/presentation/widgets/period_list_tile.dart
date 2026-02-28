import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/core_utils.dart';

import '../../../../core/constants/app_sizes.dart';

/// Dönem seçim listesinde her bir dönem satırını temsil eden tile widget'ı.
/// Seçili durumda renk, ikon ve ağırlık değişimi ile görsel geri bildirim sağlar.
class PeriodListTile extends StatelessWidget {
  /// Gösterilecek dönem metni (ör. "2025-2026 Güz Dönemi")
  final String period;

  /// Bu dönem şu an seçili mi
  final bool isSelected;

  /// Tile'a tıklandığında tetiklenen callback
  final VoidCallback onTap;

  const PeriodListTile({
    super.key,
    required this.period,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /// Seçili duruma göre renklenen takvim ikonu
      leading: Icon(
        Icons.calendar_month_outlined,
        size: AppSize.v20,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),

      /// Seçili satırda primary renk + kalın yazı, diğerlerinde normal
      title: (isSelected
              ? period.text.semiBold.color(AppColors.primary)
              : period.text.color(AppColors.textPrimary))
          .titleMedium(context),

      /// Yalnızca seçili satırda gösterilen onay ikonu
      trailing: isSelected
          ? const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
              size: AppSize.v20,
            )
          : null,

      /// Seçili satır için hafif primary arka plan tonu
      tileColor: isSelected
          ? AppColors.primary.withValues(alpha: 0.07)
          : Colors.transparent,

      /// Tile kenarlarını yuvarlatır
      shape: RoundedRectangleBorder(
        borderRadius: AppSize.v10.radius,
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSize.v8,
        vertical: AppSize.v4,
      ),

      onTap: onTap,
    );
  }
}
