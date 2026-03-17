import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/academic_advisor/data/model/advisor_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Danışman iletişim bilgilerini (e-posta, telefon, oda) gösteren kart.
class AdvisorContactCard extends StatelessWidget {
  const AdvisorContactCard({super.key, required this.advisor});

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
        _buildContactRows(context),
      ].column(crossAxisAlignment: CrossAxisAlignment.stretch),
    );
  }

  // ── Kart başlığı: ikon + etiket ───────────────────────────────────────────
  Widget _buildCardHeader(BuildContext context) {
    return [
      Icon(
        Icons.contact_page_outlined,
        size: AppSize.v20,
        color: context.primaryColor,
      ),
      AppStrings.contactInfo.text.semiBold
          .fontSize(AppSize.v16)
          .color(AppColors.textPrimary),
    ]
        .row(spacing: AppSize.v10)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v14);
  }

  // ── İletişim satırları ────────────────────────────────────────────────────
  Widget _buildContactRows(BuildContext context) {
    return [
      _buildContactRow(
        icon: Icons.email_outlined,
        label: advisor.email,
        color: context.primaryColor,
      ),
      const Divider(height: 1, indent: AppSize.v48),
      _buildContactRow(
        icon: Icons.phone_outlined,
        label: advisor.phone,
        color: AppColors.success,
      ),
      const Divider(height: 1, indent: AppSize.v48),
      _buildContactRow(
        icon: Icons.location_on_outlined,
        label: advisor.office,
        color: AppColors.warning,
      ),
    ].column(crossAxisAlignment: CrossAxisAlignment.stretch);
  }

  // ── Tek iletişim satırı: renkli ikon kutusu + metin ───────────────────────
  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return [
      Icon(icon, size: AppSize.v20, color: color)
          .paddingAll(AppSize.v10)
          .container(
            color: color.withValues(alpha: 0.1),
            borderRadius: AppSize.v10,
          ),
      label.text.fontSize(AppSize.v14).color(AppColors.textPrimary).expanded(),
    ]
        .row(spacing: AppSize.v12)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v12);
  }
}
