import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/academic_advisor/data/model/advisor_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Danışman görüşme saatlerini gün + saat aralığı şeklinde gösteren kart.
class AdvisorOfficeHoursCard extends StatelessWidget {
  const AdvisorOfficeHoursCard({super.key, required this.advisor});

  final AdvisorModel advisor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: AppSize.v2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.v16),
      ),
      child: [
        _buildCardHeader(context),
        const Divider(height: 1),
        _buildOfficeHoursList(context),
      ].column(crossAxisAlignment: CrossAxisAlignment.stretch),
    );
  }

  // ── Kart başlığı: ikon + etiket ───────────────────────────────────────────
  Widget _buildCardHeader(BuildContext context) {
    return [
      Icon(
        Icons.schedule_outlined,
        size: AppSize.v20,
        color: context.primaryColor,
      ),
      AppStrings.officeHoursLabel.text.semiBold
          .fontSize(AppSize.v16)
          .color(AppColors.textPrimary),
    ]
        .row(spacing: AppSize.v10)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v14);
  }

  // ── Görüşme saatleri listesi ──────────────────────────────────────────────
  Widget _buildOfficeHoursList(BuildContext context) {
    return [
      for (int i = 0; i < advisor.officeHours.length; i++) ...[
        if (i > 0) const Divider(height: 1, indent: AppSize.v16),
        _buildOfficeHourRow(context, advisor.officeHours[i]),
      ],
    ].column(crossAxisAlignment: CrossAxisAlignment.stretch);
  }

  // ── Tek satır: gün adı solda, saat rozeti sağda ───────────────────────────
  Widget _buildOfficeHourRow(BuildContext context, AdvisorOfficeHour hour) {
    return [
      hour.day.text.semiBold
          .fontSize(AppSize.v14)
          .color(AppColors.textPrimary)
          .expanded(),
      hour.timeRange.text.semiBold
          .fontSize(AppSize.v12)
          .color(context.primaryColor)
          .paddingSymmetric(h: AppSize.v10, v: AppSize.v4)
          .container(
            color: context.primaryColor.withValues(alpha: 0.08),
            borderRadius: AppSize.v20,
            border: Border.all(
              color: context.primaryColor.withValues(alpha: 0.25),
            ),
          ),
    ]
        .row(crossAxisAlignment: CrossAxisAlignment.center)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v12);
  }
}
