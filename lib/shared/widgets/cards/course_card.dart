import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CourseCard — Ders bilgilerini modern kart tasarımıyla gösteren StatelessWidget.
// Gradyan başlık, not göstergesi, ikon satırları ve pill rozet içerir.
// ─────────────────────────────────────────────────────────────────────────────
class CourseCard extends StatelessWidget {
  final String title;
  final String grade; // henüz hesaplanmadıysa "--" geçilir
  final String classInfo; // örn. "2.Sınıf - YBS 208 (1)"
  final String instructor;
  final int credit;
  final int akts;
  final void Function() onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.grade,
    required this.classInfo,
    required this.instructor,
    required this.credit,
    required this.akts,
    required this.onTap,
  });

  // ── Not rengi hesaplama ───────────────────────────────────────────────────
  // Sayısal not → eşik tabanlı, harf notu → sabit eşleme (Dart 3 switch expr.)
  Color get _gradeColor {
    if (grade == '--') return AppColors.textHint;

    final n = double.tryParse(grade);

    // Sayısal not: eşik değerlerine göre renk ataması
    if (n != null) {
      return switch (n) {
        >= 85 => AppColors.success,
        >= 70 => AppColors.primary,
        >= 55 => AppColors.warning,
        _ => AppColors.error,
      };
    }

    // Harf notu: geçer / orta / başarısız eşlemeleri
    return switch (grade) {
      'AA' || 'BA' => AppColors.success,
      'BB' || 'CB' => AppColors.primary,
      'CC' || 'DC' => AppColors.warning,
      _ => AppColors.error,
    };
  }

  // ── Ana yapı: Kart çerçevesi ──────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .zero,
      clipBehavior: .antiAlias, // gradient köşeleri için gerekli
      elevation: AppSize.v2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.v16),
      ),
      child: [
        _buildHeader(context), // gradient başlık bölümü
        _buildContent(), // not + bilgi bölümü
      ].column(crossAxisAlignment: .stretch),
    ).onTap(onTap);
  }

  // ── Üst bölüm: primary→primaryLight gradyan üzeri ders simgesi + adı ─────
  Widget _buildHeader(BuildContext context) {
    return [
          // Yarı şeffaf kapsayıcı içinde kitap ikonu
          Icon(
                Icons.menu_book_rounded,
                color: context.onPrimaryColor,
                size: AppSize.v16,
              )
              .paddingAll(AppSize.v6)
              .container(
                color: context.onPrimaryColor.withValues(alpha: 0.18),
                borderRadius: AppSize.v8,
              ),

          // Ders adı — taşarsa üç nokta ile kısaltılır
          title.text.semiBold
              .fontSize(AppSize.v16)
              .color(context.onPrimaryColor)
              .ellipsis
              .expanded(),
        ]
        .row(spacing: AppSize.v10)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v14)
        .container(
          gradient: LinearGradient(
            colors: [context.primaryColor, AppColors.primaryDark],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        );
  }

  // ── Alt bölüm: Not dairesi solda, ders bilgileri sağda ───────────────────
  Widget _buildContent() {
    return [
      _buildGradeCircle(),
      _buildInfoColumn().expanded(),
    ].row(spacing: AppSize.v16).paddingAll(AppSize.v16);
  }

  // ── Not dairesi: Nota göre renklendirilen çerçeve + metin ─────────────────
  // Renk: >= 85 yeşil · >= 70 mavi · >= 55 sarı · < 55 kırmızı · '--' gri
  Widget _buildGradeCircle() {
    final color = _gradeColor;
    return grade.text.bold
        .fontSize(AppSize.v16)
        .color(color)
        .center
        .sized(width: AppSize.v64, height: AppSize.v64)
        .container(
          shape: .circle,
          color: color.withValues(alpha: 0.08),
          border: .all(color: color, width: 2.5),
        );
  }

  // ── Bilgi sütunu: Sınıf satırı, öğretmen satırı, rozet satırı ────────────
  Widget _buildInfoColumn() {
    return [
      _buildInfoRow(Icons.class_outlined, classInfo), // şube / sınıf
      _buildInfoRow(Icons.person_outline_rounded, instructor), // öğretim üyesi
      [
        _buildBadge('$credit Kredi', AppColors.primary), // kredi rozeti
        _buildBadge('$akts AKTS', AppColors.secondary), // AKTS rozeti
      ].row(spacing: AppSize.v6),
    ].column(crossAxisAlignment: .start, spacing: AppSize.v6);
  }

  // ── İkon + metin satırı yardımcısı (sınıf ve öğretmen paylaşır) ──────────
  Widget _buildInfoRow(IconData icon, String label) {
    return [
      Icon(icon, size: AppSize.v14, color: AppColors.textSecondary),
      label.text
          .fontSize(AppSize.v14)
          .color(AppColors.textPrimary)
          .ellipsis
          .expanded(),
    ].row(spacing: AppSize.v4);
  }

  // ── Pill rozet: Renkli dolgu + eşleşen şeffaf kenarlık ───────────────────
  Widget _buildBadge(String label, Color color) {
    return label.text.semiBold
        .fontSize(AppSize.v12)
        .color(color)
        .paddingSymmetric(h: AppSize.v8, v: AppSize.v4)
        .container(
          color: color.withValues(alpha: 0.1),
          borderRadius: AppSize.v20,
          border: Border.all(color: color.withValues(alpha: 0.35)),
        );
  }
}
