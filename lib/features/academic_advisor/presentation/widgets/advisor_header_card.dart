import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/academic_advisor/data/model/advisor_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Akademik danışmanın profil başlık kartı.
///
/// Gradyan arkaplan üzerinde avatar, ad, unvan ve bölüm bilgisini gösterir.
/// [CourseCard] ile tutarlı kart şekli ve gölge değerleri kullanır.
class AdvisorHeaderCard extends StatelessWidget {
  const AdvisorHeaderCard({super.key, required this.advisor});

  final AdvisorModel advisor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: AppSize.v2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.v16),
      ),
      child: [
        _buildGradientHeader(context),
        _buildDepartmentRow(context),
      ].column(crossAxisAlignment: CrossAxisAlignment.stretch),
    );
  }

  // ── Gradient üst bölüm: avatar + isim + unvan ─────────────────────────────
  Widget _buildGradientHeader(BuildContext context) {
    return [
      _buildAvatar(context),
      _buildNameSection(context).expanded(),
    ]
        .row(
          spacing: AppSize.v16,
          crossAxisAlignment: CrossAxisAlignment.center,
        )
        .paddingSymmetric(h: AppSize.v20, v: AppSize.v24)
        .container(
          gradient: LinearGradient(
            colors: [context.primaryColor, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
  }

  // ── Yuvarlak avatar: kişi ikonu ───────────────────────────────────────────
  Widget _buildAvatar(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.v32,
      backgroundColor: context.onPrimaryColor.withValues(alpha: 0.2),
      child: Icon(
        Icons.person_rounded,
        size: AppSize.v40,
        color: context.onPrimaryColor,
      ),
    );
  }

  // ── İsim ve unvan sütunu ──────────────────────────────────────────────────
  Widget _buildNameSection(BuildContext context) {
    return [
      advisor.name.text.bold
          .fontSize(AppSize.v18)
          .color(context.onPrimaryColor),
      AppSize.v4.h,
      advisor.title.text
          .fontSize(AppSize.v14)
          .color(context.onPrimaryColor.withValues(alpha: 0.85)),
    ].column(crossAxisAlignment: CrossAxisAlignment.start);
  }

  // ── Alt bölüm: bölüm adı satırı ──────────────────────────────────────────
  Widget _buildDepartmentRow(BuildContext context) {
    return [
      const Icon(
        Icons.school_outlined,
        size: AppSize.v16,
        color: AppColors.textSecondary,
      ),
      advisor.department.text
          .fontSize(AppSize.v14)
          .color(AppColors.textSecondary)
          .expanded(),
    ]
        .row(spacing: AppSize.v8)
        .paddingSymmetric(h: AppSize.v20, v: AppSize.v12);
  }
}
