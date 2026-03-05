import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/exam_results/data/model/exam_result_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ExamType — Sınav türünü temsil eder; renk ve etiket bilgisini taşır.
// ─────────────────────────────────────────────────────────────────────────────
enum ExamType {
  vize('Vize'),
  finalExam('Final'),
  butunleme('Bütünleme');

  const ExamType(this.label);

  final String label;

  Color chipColor(BuildContext context) => switch (this) {
        ExamType.vize => AppColors.info,
        ExamType.finalExam => context.primaryColor,
        ExamType.butunleme => AppColors.warning,
      };

  static ExamType fromLabel(String label) => ExamType.values.firstWhere(
        (e) => e.label == label,
        orElse: () => ExamType.vize,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// GradeColorMixin — Harf notuna göre renk döndürür.
// ─────────────────────────────────────────────────────────────────────────────
mixin GradeColorMixin {
  Color gradeColor(String letterGrade) => switch (letterGrade) {
        'AA' || 'BA' => AppColors.success,
        'BB' || 'CB' => AppColors.primary,
        'CC' || 'DC' => AppColors.warning,
        'FF' => AppColors.error,
        _ => AppColors.textHint,
      };
}

// ─────────────────────────────────────────────────────────────────────────────
// ExamResultCard — Bir derse ait tüm sınavları tek kartta gösterir.
// Kart sağ üst köşesinde harf notunu gösteren üçgen badge bulunur.
// Vize / Final chip toggle ile aktif sınav değiştirilir.
// ─────────────────────────────────────────────────────────────────────────────
class ExamResultCard extends StatefulWidget {
  const ExamResultCard({
    super.key,
    required this.courseTitle,
    required this.exams,
  });

  final String courseTitle;
  final List<ExamResultModel> exams;

  @override
  State<ExamResultCard> createState() => _ExamResultCardState();
}

class _ExamResultCardState extends State<ExamResultCard> with GradeColorMixin {
  late ExamResultModel _active;

  @override
  void initState() {
    super.initState();
    _active = widget.exams.first;
  }

  Color get _gradeColor => gradeColor(_active.letterGrade);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .zero,
      clipBehavior: .antiAlias,
      elevation: AppSize.v2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.v16),
      ),
      child: Stack(
        children: [
          [
            _buildHeader(context),
            _buildExamTabs(context),
            _buildContent(),
          ].column(crossAxisAlignment: .stretch),
          Positioned(
            top: 0,
            right: 0,
            child: _CornerBadge(grade: _active.letterGrade, color: _gradeColor),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return [
          Icon(Icons.edit_document,
                  color: context.onPrimaryColor, size: AppSize.v16)
              .paddingAll(AppSize.v6)
              .container(
                color: context.onPrimaryColor.withValues(alpha: 0.18),
                borderRadius: AppSize.v8,
              ),
          // Köşe badge alanı için sağda boşluk bırakılır (badge 56px geniş).
          widget.courseTitle.text.semiBold
              .fontSize(AppSize.v16)
              .color(context.onPrimaryColor)
              .ellipsis
              .paddingOnly(right: AppSize.v44)
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

  Widget _buildExamTabs(BuildContext context) {
    return widget.exams
        .map(
          (exam) => _ExamChip(
            examType: ExamType.fromLabel(exam.examType),
            isSelected: exam.examType == _active.examType,
            onTap: () => setState(() => _active = exam),
          ),
        )
        .toList()
        .row(spacing: AppSize.v8)
        .paddingSymmetric(h: AppSize.v16, v: AppSize.v10);
  }

  Widget _buildContent() {
    final color = _gradeColor;
    final scoreText =
        _active.score >= 0 ? _active.score.toStringAsFixed(0) : '--';

    return [
      scoreText.text.bold
          .fontSize(AppSize.v18)
          .color(color)
          .center
          .sized(width: AppSize.v64, height: AppSize.v64)
          .container(
            shape: .circle,
            color: color.withValues(alpha: 0.08),
            border: .all(color: color, width: 2.5),
          ),
      [
        [
          _GradeBadge(grade: _active.letterGrade, color: color),
          _CreditBadge(credit: _active.credit),
        ].row(spacing: AppSize.v8),
        if (_active.score >= 0) _ProgressBar(score: _active.score, color: color),
      ].column(crossAxisAlignment: .start, spacing: AppSize.v10).expanded(),
    ].row(spacing: AppSize.v16).paddingAll(AppSize.v16);
  }
}

// ── Köşe üçgen badge ─────────────────────────────────────────────────────────
class _CornerBadge extends StatelessWidget {
  const _CornerBadge({required this.grade, required this.color});

  final String grade;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TopRightTriangleClipper(),
      child: Container(
        width: AppSize.v64,
        height: AppSize.v64,
        color: color,
        alignment: const Alignment(0.65, -0.65),
        child: grade.text.bold.fontSize(AppSize.v12).color(AppColors.onPrimary),
      ),
    );
  }
}

class _TopRightTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height)
    ..close();

  @override
  bool shouldReclip(_) => false;
}

// ── Vize / Final toggle chip ──────────────────────────────────────────────────
class _ExamChip extends StatelessWidget {
  const _ExamChip({
    required this.examType,
    required this.isSelected,
    required this.onTap,
  });

  final ExamType examType;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = examType.chipColor(context);
    return examType.label.text.semiBold
        .fontSize(AppSize.v12)
        .color(isSelected ? AppColors.onPrimary : color)
        .paddingSymmetric(h: AppSize.v14, v: AppSize.v6)
        .container(
          color: isSelected ? color : color.withValues(alpha: 0.08),
          borderRadius: AppSize.v20,
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.4),
          ),
        )
        .onTap(onTap);
  }
}

// ── Harf notu pill rozeti ─────────────────────────────────────────────────────
class _GradeBadge extends StatelessWidget {
  const _GradeBadge({required this.grade, required this.color});

  final String grade;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return [
      Icon(Icons.grade_rounded, size: AppSize.v14, color: color),
      grade.text.semiBold.fontSize(AppSize.v14).color(color),
    ]
        .row(spacing: AppSize.v4)
        .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
        .container(
          color: color.withValues(alpha: 0.1),
          borderRadius: AppSize.v20,
          border: Border.all(color: color.withValues(alpha: 0.35)),
        );
  }
}

// ── Kredi pill rozeti ─────────────────────────────────────────────────────────
class _CreditBadge extends StatelessWidget {
  const _CreditBadge({required this.credit});

  final int credit;

  @override
  Widget build(BuildContext context) {
    return '$credit Kredi'.text.semiBold
        .fontSize(AppSize.v12)
        .color(AppColors.secondary)
        .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
        .container(
          color: AppColors.secondary.withValues(alpha: 0.1),
          borderRadius: AppSize.v20,
          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.35)),
        );
  }
}

// ── Ham puan ilerleme çubuğu ──────────────────────────────────────────────────
class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.score, required this.color});

  final double score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return [
      'Puan: ${score.toStringAsFixed(0)}/100'.text
          .fontSize(AppSize.v12)
          .color(AppColors.textSecondary),
      ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.v4),
        child: LinearProgressIndicator(
          value: (score / 100).clamp(0.0, 1.0),
          minHeight: AppSize.v6,
          backgroundColor: AppColors.surfaceVariant,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    ].column(crossAxisAlignment: .start, spacing: AppSize.v4);
  }
}
