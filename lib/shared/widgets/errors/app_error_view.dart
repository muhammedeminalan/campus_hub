import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// HomeView, CoursesView ve ExamResults'taki tekrarlanan hata UI'ını
/// tek bir widget'ta toplar.
///
/// Kullanım:
/// ```dart
/// AppErrorView(
///   message: 'Veriler yüklenemedi',
///   subMessage: 'Lütfen tekrar deneyin.',
///   onRetry: () => context.read<MyCubit>().loadData(),
/// )
/// ```
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.onRetry,
    this.message,
    this.subMessage,
  });

  /// "Yeniden Dene" butonuna basılınca tetiklenir.
  final VoidCallback onRetry;

  /// Başlık mesajı; verilmezse [AppStrings.genericError] gösterilir.
  final String? message;

  /// Başlığın altında küçük yazıyla gösterilecek ek açıklama.
  final String? subMessage;

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.error_outline,
        size: AppSize.v64,
        color: context.onSurfaceColor.withValues(alpha: 0.4),
      ),
      AppSize.v16.h,
      (message ?? AppStrings.genericError).text.titleMedium(context).center,
      if (subMessage != null) ...[
        AppSize.v8.h,
        subMessage!.text
            .bodySmall(context)
            .color(context.onSurfaceColor.withValues(alpha: 0.5))
            .center,
      ],
      AppSize.v24.h,
      TextButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh),
        label: AppStrings.retry.text,
      ),
    ].column(mainAxisAlignment: .center).center;
  }
}
