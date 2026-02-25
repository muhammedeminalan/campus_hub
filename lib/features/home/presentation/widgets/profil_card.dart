import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/home/data/model/student_card_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

// ---------------------------------------------------------------------------
// Style
// ---------------------------------------------------------------------------

/// [ProfilCard] için tüm görsel özellikler.
///
/// Varsayılan değerler orijinal tasarımı yansıtır.
/// Sadece değiştirmek istediğiniz parametreleri geçin.
///
/// **null olan Color alanları** → context tema renkleri ile doldurulur.
class ProfilCardStyle {
  const ProfilCardStyle({
    // --- Kart ---
    this.elevation = 8,
    this.shadowColor,
    this.shadowAlpha = 0.22,
    this.cardBorderRadius = AppSize.v28,
    // --- Header ---
    this.headerGradientColors,
    this.headerGradientEndAlpha = 0.60,
    this.headerGradientBegin = Alignment.topLeft,
    this.headerGradientEnd = Alignment.bottomRight,
    this.showDecorativeCircles = true,
    this.decorativeLargeCircleSize = AppSize.v128,
    this.decorativeSmallCircleSize = AppSize.v36,
    this.decorativeLargeCircleAlpha = 0.07,
    this.decorativeSmallCircleAlpha = 0.10,
    // --- Badge ---
    this.showBadge = true,
    this.badgeIconColor = Colors.white,
    this.badgeTextColor = Colors.white,
    this.badgeBgAlpha = 0.18,
    this.badgeBorderAlpha = 0.30,
    this.badgeBorderRadius = AppSize.v20,
    this.badgePaddingH = AppSize.v10,
    this.badgePaddingV = AppSize.v4,
    // --- Avatar ---
    this.avatarBorderColor,
    this.avatarBorderWidth = 4.0,
    // --- Öğrenci bilgileri ---
    this.nameColor,
    // --- Numara chip ---
    this.chipColor,
    this.chipBgAlpha = 0.10,
    this.chipBorderAlpha = 0.25,
    this.chipBorderRadius = AppSize.v24,
    this.chipLetterSpacing = 1.2,
    this.chipPaddingH = AppSize.v16,
    this.chipPaddingV = AppSize.v6,
    // --- Bilgi satırları ---
    this.infoIconColor,
    this.infoIconBgAlpha = 0.08,
    this.infoIconBorderRadius = AppSize.v8,
    // --- İstatistikler ---
    this.statClassColor,
    this.statAnoColor,
    this.statAgnoColor,
    this.statIconSize = AppSize.v20,
    this.statIconBgAlpha = 0.12,
    // --- Alt bilgi (footer) ---
    this.footerOpacity = 0.35,
    this.footerIconSize = AppSize.v12,
  });

  // Kart
  final double elevation;

  /// null → `context.primaryColor.withValues(alpha: shadowAlpha)`
  final Color? shadowColor;
  final double shadowAlpha;
  final double cardBorderRadius;

  // Header
  /// null → `[primaryColor, primaryColor.withValues(alpha: headerGradientEndAlpha)]`
  final List<Color>? headerGradientColors;
  final double headerGradientEndAlpha;
  final AlignmentGeometry headerGradientBegin;
  final AlignmentGeometry headerGradientEnd;
  final bool showDecorativeCircles;
  final double decorativeLargeCircleSize;
  final double decorativeSmallCircleSize;
  final double decorativeLargeCircleAlpha;
  final double decorativeSmallCircleAlpha;

  // Badge
  final bool showBadge;
  final Color badgeIconColor;
  final Color badgeTextColor;
  final double badgeBgAlpha;
  final double badgeBorderAlpha;
  final double badgeBorderRadius;
  final double badgePaddingH;
  final double badgePaddingV;

  // Avatar
  /// null → `context.colorScheme.surface`
  final Color? avatarBorderColor;
  final double avatarBorderWidth;

  // Öğrenci bilgileri
  /// null → varsayılan tema text rengi
  final Color? nameColor;

  // Numara chip
  /// null → `context.primaryColor`
  final Color? chipColor;
  final double chipBgAlpha;
  final double chipBorderAlpha;
  final double chipBorderRadius;
  final double chipLetterSpacing;
  final double chipPaddingH;
  final double chipPaddingV;

  // Bilgi satırları
  /// null → `context.primaryColor`
  final Color? infoIconColor;
  final double infoIconBgAlpha;
  final double infoIconBorderRadius;

  // İstatistikler
  /// null → `context.primaryColor`
  final Color? statClassColor;

  /// null → `context.colorScheme.secondary`
  final Color? statAnoColor;

  /// null → `AppColors.warning`
  final Color? statAgnoColor;
  final double statIconSize;
  final double statIconBgAlpha;

  // Footer
  final double footerOpacity;
  final double footerIconSize;
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// Öğrenci kimlik kartı ekranı.
/// [StudentCardModel] alır; tüm veri modelden okunur.
/// [style] ile görsel özellikler tamamen özelleştirilebilir.
class ProfilCard extends StatelessWidget {
  const ProfilCard({
    super.key,
    required this.student,
    this.style = const ProfilCardStyle(),
    this.width,
    this.height,
  });

  final StudentCardModel student;
  final ProfilCardStyle style;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: style.elevation,
      shadowColor: style.shadowColor ??
          context.primaryColor.withValues(alpha: style.shadowAlpha),
      shape: RoundedRectangleBorder(
        borderRadius: style.cardBorderRadius.radius,
      ),
      clipBehavior: .antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final avatarSize = (w * 0.28).clamp(88.0, AppSize.v112);
          final headerHeight = (w * 0.40).clamp(128.0, AppSize.v160);
          return [
            _header(context, headerHeight: headerHeight, avatarSize: avatarSize),
            (avatarSize / 2).h,
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
    ).sized(width: width, height: height);
  }

  // ---------------------------------------------------------------------------
  // Header – gradient arka plan + badge + avatar
  // ---------------------------------------------------------------------------

  Widget _header(
    BuildContext context, {
    required double headerHeight,
    required double avatarSize,
  }) {
    final gradientColors = style.headerGradientColors ??
        [
          context.primaryColor,
          context.primaryColor.withValues(alpha: style.headerGradientEndAlpha),
        ];

    Widget headerBg = const SizedBox.expand().container(
      height: headerHeight,
      gradient: LinearGradient(
        colors: gradientColors,
        begin: style.headerGradientBegin,
        end: style.headerGradientEnd,
      ),
    );

    if (style.showDecorativeCircles) {
      headerBg = headerBg.stack([
        SizedBox.square(dimension: style.decorativeLargeCircleSize)
            .container(
              color: Colors.white.withValues(alpha: style.decorativeLargeCircleAlpha),
              shape: BoxShape.circle,
            )
            .marginOnly(right: AppSize.v12)
            .alignBottom
            .alignRight,
        SizedBox.square(dimension: style.decorativeSmallCircleSize)
            .container(
              color: Colors.white.withValues(alpha: style.decorativeSmallCircleAlpha),
              shape: BoxShape.circle,
            )
            .marginOnly(right: AppSize.v72, bottom: AppSize.v20)
            .alignBottom
            .alignRight,
      ]);
    }

    return Stack(
      clipBehavior: .none,
      alignment: .bottomCenter,
      children: [
        headerBg,
        if (style.showBadge)
          Positioned(
            top: AppSize.v12,
            right: AppSize.v16,
            child: _headerBadge(context),
          ),
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
          Icon(
            Icons.verified_rounded,
            size: AppSize.v12,
            color: style.badgeIconColor,
          ),
          AppSize.v4.w,
          AppStrings.appName.text
              .color(style.badgeTextColor)
              .labelSmall(context),
        ]
        .row(mainAxisSize: MainAxisSize.min)
        .paddingSymmetric(h: style.badgePaddingH, v: style.badgePaddingV)
        .container(
          color: Colors.white.withValues(alpha: style.badgeBgAlpha),
          borderRadius: style.badgeBorderRadius,
          border: Border.all(
            color: Colors.white.withValues(alpha: style.badgeBorderAlpha),
          ),
        );
  }

  /// Yuvarlak profil fotoğrafı; border rengi Card yüzeyiyle eşleşir.
  Widget _avatar(BuildContext context, double size) {
    return student.avatarPath.asAssetImage().circleAvatar(
      size: size,
      borderColor: style.avatarBorderColor ?? context.colorScheme.surface,
      borderWidth: style.avatarBorderWidth,
    );
  }

  // ---------------------------------------------------------------------------
  // Öğrenci bilgileri
  // ---------------------------------------------------------------------------

  /// Ad, numara chip'i ve kurum bilgileri.
  Widget _studentInfo(BuildContext context) {
    final nameText = style.nameColor != null
        ? student.name.text.bold.color(style.nameColor!).titleLarge(context)
        : student.name.text.bold.titleLarge(context);

    return [
      nameText,
      AppSize.v8.h,
      _numberChip(context),
      AppSize.v14.h,
      _infoRow(context, Icons.account_balance_outlined, student.university),
      AppSize.v6.h,
      _infoRow(context, Icons.domain_outlined, student.faculty),
      AppSize.v6.h,
      _infoRow(context, Icons.auto_stories_outlined, student.department),
    ].column();
  }

  /// Öğrenci numarasını pill/chip içinde gösterir.
  Widget _numberChip(BuildContext context) {
    final color = style.chipColor ?? context.primaryColor;
    return [
          Icon(Icons.badge_outlined, size: AppSize.v14, color: color),
          AppSize.v6.w,
          student.studentNo.text.semiBold
              .color(color)
              .letterSpacing(style.chipLetterSpacing)
              .labelLarge(context),
        ]
        .row(mainAxisSize: MainAxisSize.min)
        .paddingSymmetric(h: style.chipPaddingH, v: style.chipPaddingV)
        .container(
          color: color.withValues(alpha: style.chipBgAlpha),
          borderRadius: style.chipBorderRadius,
          border: Border.all(color: color.withValues(alpha: style.chipBorderAlpha)),
        );
  }

  /// İkon renkli kutu içinde + metin; uzun metinler [expanded] ile taşmaz.
  Widget _infoRow(BuildContext context, IconData icon, String label) {
    final color = style.infoIconColor ?? context.primaryColor;
    return [
      Icon(icon, size: AppSize.v14, color: color)
          .paddingSymmetric(h: AppSize.v6, v: AppSize.v6)
          .container(
            color: color.withValues(alpha: style.infoIconBgAlpha),
            borderRadius: style.infoIconBorderRadius,
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
      _statItem(
        context,
        Icons.school_outlined,
        student.studentClass,
        AppStrings.studentClass,
        style.statClassColor ?? context.primaryColor,
      ),
      _verticalDivider(context),
      _statItem(
        context,
        Icons.date_range,
        student.ano,
        AppStrings.ano,
        style.statAnoColor ?? context.colorScheme.secondary,
      ),
      _verticalDivider(context),
      _statItem(
        context,
        Icons.trending_up,
        student.agno,
        AppStrings.agno,
        style.statAgnoColor ?? AppColors.warning,
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
      Icon(icon, size: style.statIconSize, color: accentColor)
          .paddingSymmetric(h: AppSize.v8, v: AppSize.v8)
          .container(
            color: accentColor.withValues(alpha: style.statIconBgAlpha),
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
    final subtleColor =
        context.onSurfaceColor.withValues(alpha: style.footerOpacity);
    return [
      [
        Icon(
          Icons.calendar_month_outlined,
          size: style.footerIconSize,
          color: subtleColor,
        ),
        AppSize.v4.w,
        student.date.text.color(subtleColor).labelSmall(context),
      ].row(mainAxisSize: MainAxisSize.min),
      [
        Icon(Icons.hub_outlined, size: style.footerIconSize, color: subtleColor),
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
