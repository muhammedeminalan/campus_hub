import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/home/data/model/student_card_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Öğrenci kimlik kartı ekranı.
/// [StudentCardModel] alır; tüm veri modelden okunur.
class ProfilCard extends StatelessWidget {
  const ProfilCard({super.key, required this.student});

  final StudentCardModel student;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: context.primaryColor.withValues(alpha: 0.22),
      shape: RoundedRectangleBorder(borderRadius: AppSize.v28.radius),
      clipBehavior: .antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          // Ekran genişliğine göre ölçeklenen boyutlar – farklı cihazlarda bozulmaz
          final avatarSize = (w * 0.28).clamp(88.0, AppSize.v112);
          final headerHeight = (w * 0.40).clamp(128.0, AppSize.v160);
          return [
            _header(
              context,
              headerHeight: headerHeight,
              avatarSize: avatarSize,
            ),
            (avatarSize / 2).h, // Avatar alt taşma boşluğu
            [
              _studentInfo(context),
              AppSize.v16.h,
              context.divider(),
              AppSize.v16.h,
              _statsRow(context),
              AppSize.v16.h,
              context.divider(),
              AppSize.v10.h,
              _cardFooter(context),
              AppSize.v14.h,
            ].column().paddingHorizontal(AppSize.v20),
          ].column();
        },
      ),
    ).paddingSymmetric(h: AppSize.v16, v: AppSize.v20);
  }

  // ---------------------------------------------------------------------------
  // Header – gradient arka plan + badge + avatar
  // ---------------------------------------------------------------------------

  Widget _header(
    BuildContext context, {
    required double headerHeight,
    required double avatarSize,
  }) {
    return Stack(
      clipBehavior: .none,
      alignment: .bottomCenter,
      children: [
        // Gradient arka plan + dekoratif daireler
        const SizedBox.expand()
            .container(
              height: headerHeight,
              gradient: LinearGradient(
                colors: [
                  context.primaryColor,
                  context.primaryColor.withValues(alpha: 0.60),
                ],
                begin: .topLeft,
                end: .bottomRight,
              ),
            )
            .stack([
              // Sağ alt büyük dekoratif daire
              const SizedBox.square(dimension: AppSize.v128)
                  .container(
                    color: Colors.white.withValues(alpha: 0.07),
                    shape: BoxShape.circle,
                  )
                  .marginOnly(right: AppSize.v12)
                  .alignBottom
                  .alignRight,
              // Sağ alt küçük dekoratif daire
              const SizedBox.square(dimension: AppSize.v36)
                  .container(
                    color: Colors.white.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  )
                  .marginOnly(right: AppSize.v72, bottom: AppSize.v20)
                  .alignBottom
                  .alignRight,
            ]),

        // CampusHub verified badge – sağ üst
        Positioned(
          top: AppSize.v12,
          right: AppSize.v16,
          child: _headerBadge(context),
        ),

        // Avatar – header alt kenarından yarısı kadar dışa taşıyor
        Positioned(
          bottom: -(avatarSize / 2),
          child: _avatar(context, avatarSize),
        ),
      ],
    );
  }

  /// Sağ üstte küçük "CampusHub ✓" rozeti.
  Widget _headerBadge(BuildContext context) {
    return [
          const Icon(
            Icons.verified_rounded,
            size: AppSize.v12,
            color: Colors.white,
          ),
          AppSize.v4.w,
          AppStrings.appName.text.color(Colors.white).labelSmall(context),
        ]
        .row(mainAxisSize: MainAxisSize.min)
        .paddingSymmetric(h: AppSize.v10, v: AppSize.v4)
        .container(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: AppSize.v20,
          border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
        );
  }

  /// Yuvarlak profil fotoğrafı; border rengi Card yüzeyiyle eşleşir.
  Widget _avatar(BuildContext context, double size) {
    return student.avatarPath.asAssetImage().circleAvatar(
      size: size,
      borderColor: context.colorScheme.surface,
      borderWidth: 4,
    );
  }

  // ---------------------------------------------------------------------------
  // Öğrenci bilgileri
  // ---------------------------------------------------------------------------

  /// Ad, numara chip'i ve kurum bilgileri.
  Widget _studentInfo(BuildContext context) {
    return [
      student.name.text.bold.titleLarge(context),
      AppSize.v8.h,
      _numberChip(context),
      AppSize.v14.h,
      // Üniversite – bina/kurum ikonu
      _infoRow(context, Icons.account_balance_outlined, student.university),
      AppSize.v6.h,
      // Fakülte – organizasyon binası ikonu
      _infoRow(context, Icons.domain_outlined, student.faculty),
      AppSize.v6.h,
      // Bölüm – açık kitap/eğitim ikonu
      _infoRow(context, Icons.auto_stories_outlined, student.department),
    ].column();
  }

  /// Öğrenci numarasını pill/chip içinde gösterir.
  Widget _numberChip(BuildContext context) {
    return [
          Icon(
            Icons.badge_outlined,
            size: AppSize.v14,
            color: context.primaryColor,
          ),
          AppSize.v6.w,
          student.studentNo.text.semiBold
              .color(context.primaryColor)
              .letterSpacing(1.2)
              .labelLarge(context),
        ]
        .row(mainAxisSize: MainAxisSize.min)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v6)
        .container(
          color: context.primaryColor.withValues(alpha: 0.10),
          borderRadius: AppSize.v24,
          border: Border.all(
            color: context.primaryColor.withValues(alpha: 0.25),
          ),
        );
  }

  /// İkon renkli kutu içinde + metin; uzun metinler [expanded] ile taşmaz.
  Widget _infoRow(BuildContext context, IconData icon, String label) {
    return [
      Icon(icon, size: AppSize.v14, color: context.primaryColor)
          .paddingSymmetric(h: AppSize.v6, v: AppSize.v6)
          .container(
            color: context.primaryColor.withValues(alpha: 0.08),
            borderRadius: AppSize.v8,
          ),
      AppSize.v10.w,
      label.text.bodyMedium(context).expanded(),
    ].row();
  }

  // ---------------------------------------------------------------------------
  // İstatistikler
  // ---------------------------------------------------------------------------

  /// Sınıf, ANO ve AGNO – her biri kendi accent rengiyle.
  Widget _statsRow(BuildContext context) {
    return [
      // Sınıf – katmanlar/yıllar ikonu, primary renk
      _statItem(
        context,
        Icons.school_outlined,
        student.studentClass,
        AppStrings.studentClass,
        context.primaryColor,
      ),
      _verticalDivider(context),
      // ANO – not/grade ikonu, secondary (teal) renk
      _statItem(
        context,
        Icons.date_range,
        student.ano,
        AppStrings.ano,
        context.colorScheme.secondary,
      ),
      _verticalDivider(context),
      // AGNO – kupa/başarı ikonu, altın/ödül rengi
      _statItem(
        context,
        Icons.trending_up,
        student.agno,
        AppStrings.agno,
        AppColors.warning,
      ),
    ].row(mainAxisAlignment: MainAxisAlignment.spaceEvenly);
  }

  Widget _verticalDivider(BuildContext context) {
    return VerticalDivider(
      width: 1,
      color: context.colorScheme.outline,
    ).sized(height: AppSize.v48);
  }

  /// Tek istatistik öğesi: yuvarlak renkli ikon → değer → etiket.
  Widget _statItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color accentColor,
  ) {
    return [
      Icon(icon, size: AppSize.v20, color: accentColor)
          .paddingSymmetric(h: AppSize.v8, v: AppSize.v8)
          .container(
            color: accentColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
      AppSize.v6.h,
      value.text.bold.titleMedium(context),
      label.text
          .color(context.onSurfaceColor.withValues(alpha: 0.45))
          .labelSmall(context),
    ].column();
  }

  // ---------------------------------------------------------------------------
  // Alt bilgi
  // ---------------------------------------------------------------------------

  /// Tarih (sol) ve uygulama adı (sağ) – ikonlu ve soluk.
  Widget _cardFooter(BuildContext context) {
    final subtleColor = context.onSurfaceColor.withValues(alpha: 0.35);
    return [
      [
        Icon(
          Icons.calendar_month_outlined,
          size: AppSize.v12,
          color: subtleColor,
        ),
        AppSize.v4.w,
        student.date.text.color(subtleColor).labelSmall(context),
      ].row(mainAxisSize: MainAxisSize.min),
      [
        Icon(Icons.hub_outlined, size: AppSize.v12, color: subtleColor),
        AppSize.v4.w,
        AppStrings.appName.text.color(subtleColor).labelSmall(context),
      ].row(mainAxisSize: MainAxisSize.min),
    ].row(mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}

// Widget extension – Stack ekleme kolaylığı
extension _StackExtension on Widget {
  Widget stack(List<Widget> children) => Stack(children: [this, ...children]);
}
