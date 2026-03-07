import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/models/exam_result_model.dart';
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
// Header'da ders adı + aktif sınav skoru, altında tab chip'leri ve
// animasyonlu içerik alanı (not + kredi + puan çubuğu) yer alır.
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

  /// [type] için gerçek veri varsa onu, yoksa score: -1 / grade: '--' placeholder döner.
  ExamResultModel _examFor(ExamType type) {
    return widget.exams.firstWhere(
      (e) => ExamType.fromLabel(e.examType) == type,
      orElse: () => ExamResultModel(
        id: 'placeholder_${type.label}',
        courseTitle: widget.courseTitle,
        examType: type.label,
        score: -1,
        letterGrade: '--',
        credit: widget.exams.first.credit,
        periodId: widget.exams.first.periodId,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _active = _examFor(ExamType.vize);
  }

  Color get _gradeColor => gradeColor(_active.letterGrade);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.v20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: AppSize.v12,
            offset: Offset(0, AppSize.v4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          _buildExamTabs(context),
          _buildBody(),
        ],
      ),
    );
  }

  // ── Gradyan başlık: ders adı (sol) + skor dairesi (sağ) ──────────────────
  Widget _buildHeader(BuildContext context) {
    final scoreText = _active.score >= 0
        ? _active.score.toStringAsFixed(0)
        : '--';
    final gradeColor = _gradeColor;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.primaryColor, AppColors.primaryDark],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v14,
        AppSize.v14,
        AppSize.v14,
      ),
      child: Row(
        children: [
          // İkon
          Container(
            padding: const EdgeInsets.all(AppSize.v6),
            decoration: BoxDecoration(
              color: context.onPrimaryColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppSize.v8),
            ),
            child: Icon(
              Icons.edit_document,
              color: context.onPrimaryColor,
              size: AppSize.v16,
            ),
          ),
          const SizedBox(width: AppSize.v10),
          // Ders adı
          Expanded(
            child: Text(
              widget.courseTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSize.v16,
                fontWeight: FontWeight.w600,
                color: context.onPrimaryColor,
              ),
            ),
          ),
          const SizedBox(width: AppSize.v10),
          // Skor + harf notu dairesi
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: anim,
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: _ScoreBubble(
              key: ValueKey(_active.examType),
              scoreText: scoreText,
              grade: _active.letterGrade,
              gradeColor: gradeColor,
            ),
          ),
        ],
      ),
    );
  }

  // ── Sınav sekmeleri ───────────────────────────────────────────────────────
  Widget _buildExamTabs(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v10,
        AppSize.v16,
        AppSize.v8,
      ),
      child: Row(
        spacing: AppSize.v8,
        children: ExamType.values.map((type) {
          final isSelected = ExamType.fromLabel(_active.examType) == type;
          return _ExamChip(
            examType: type,
            isSelected: isSelected,
            onTap: () => setState(() => _active = _examFor(type)),
          );
        }).toList(),
      ),
    );
  }

  // ── Animasyonlu içerik: rozet + kredi + puan çubuğu ──────────────────────
  Widget _buildBody() {
    final color = _gradeColor;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        ),
      ),
      child: KeyedSubtree(
        key: ValueKey(_active.examType),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSize.v16,
            AppSize.v4,
            AppSize.v16,
            AppSize.v16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSize.v10,
            children: [
              Row(
                spacing: AppSize.v8,
                children: [
                  _GradeBadge(grade: _active.letterGrade, color: color),
                  _CreditBadge(credit: _active.credit),
                ],
              ),
              if (_active.score >= 0)
                _ProgressBar(score: _active.score, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Header skor dairesi ───────────────────────────────────────────────────────
class _ScoreBubble extends StatelessWidget {
  const _ScoreBubble({
    super.key,
    required this.scoreText,
    required this.grade,
    required this.gradeColor,
  });

  final String scoreText;
  final String grade;
  final Color gradeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.v48,
      height: AppSize.v48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.12),
        border: Border.all(
          color: gradeColor.withValues(alpha: 0.85),
          width: 2.5,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 0,
        children: [
          Text(
            scoreText,
            style: TextStyle(
              fontSize: AppSize.v14,
              fontWeight: FontWeight.w800,
              color: gradeColor,
              height: 1.1,
            ),
          ),
          Text(
            grade,
            style: TextStyle(
              fontSize: AppSize.v10,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.80),
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Vize / Final / Bütünleme chip ─────────────────────────────────────────────
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected ? color : color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSize.v20),
        border: Border.all(
          color: isSelected ? color : color.withValues(alpha: 0.35),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.v12,
        vertical: AppSize.v6,
      ),
      child: Text(
        examType.label,
        style: TextStyle(
          fontSize: AppSize.v12,
          fontWeight: FontWeight.w600,
          color: isSelected ? AppColors.onPrimary : color,
        ),
      ),
    ).onTap(onTap);
  }
}

// ── Harf notu pill rozeti ─────────────────────────────────────────────────────
class _GradeBadge extends StatelessWidget {
  const _GradeBadge({required this.grade, required this.color});

  final String grade;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.v10,
        vertical: AppSize.v6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSize.v20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSize.v4,
        children: [
          Icon(Icons.grade_rounded, size: AppSize.v14, color: color),
          Text(
            grade,
            style: TextStyle(
              fontSize: AppSize.v14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Kredi pill rozeti ─────────────────────────────────────────────────────────
class _CreditBadge extends StatelessWidget {
  const _CreditBadge({required this.credit});

  final int credit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.v10,
        vertical: AppSize.v6,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSize.v20),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.35)),
      ),
      child: Text(
        '$credit Kredi',
        style: const TextStyle(
          fontSize: AppSize.v12,
          fontWeight: FontWeight.w600,
          color: AppColors.secondary,
        ),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSize.v6,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Puan',
              style: TextStyle(
                fontSize: AppSize.v12,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '${score.toStringAsFixed(0)} / 100',
              style: TextStyle(
                fontSize: AppSize.v12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.v4),
          child: LinearProgressIndicator(
            value: (score / 100).clamp(0.0, 1.0),
            minHeight: AppSize.v8,
            backgroundColor: AppColors.surfaceVariant,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
