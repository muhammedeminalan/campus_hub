import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/features/home/domain/academic_calendar_model.dart';
import 'package:campus_hub/features/home/presentation/model/academic_calendar_display_x.dart';
import 'package:flutter/material.dart';

import 'calendar_event_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CalendarEventList — Etkinlikleri PageView carousel ile, scale + opacity
// scroll animasyonu ve animasyonlu sayfa noktalarıyla listeler.
//
// Her kategori kendi accent rengini alır; ortadaki kart öne çıkar,
// yanlardakiler kademeli solar ve küçülür.
// ─────────────────────────────────────────────────────────────────────────────
class CalendarEventList extends StatefulWidget {
  const CalendarEventList({super.key, required this.events});

  final List<AcademicCalendarModel> events;

  @override
  State<CalendarEventList> createState() => _CalendarEventListState();
}

class _CalendarEventListState extends State<CalendarEventList> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) setState(() => _currentPage = page);
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: AppSize.v96,
          child: AnimatedBuilder(
            animation: _pageController,
            builder: (_, _) {
              return PageView.builder(
                controller: _pageController,
                padEnds: false,
                itemCount: widget.events.length,
                itemBuilder: (context, index) {
                  // Sayfa konumuna göre uzaklık hesapla
                  final double page =
                      _pageController.hasClients && _pageController.page != null
                      ? _pageController.page!
                      : _currentPage.toDouble();

                  final distance = (index - page).abs().clamp(0.0, 1.0);
                  final curved = distance * distance; // ease-in t²

                  final scale = 1.0 - curved * 0.07;
                  final opacity = (1.0 - curved * 0.50).clamp(0.0, 1.0);

                  final item = widget.events[index];
                  final isFirst = index == 0;
                  final isLast = index == widget.events.length - 1;

                  return Padding(
                    padding: EdgeInsets.only(
                      left: isFirst ? AppSize.v16 : AppSize.v6,
                      right: isLast ? AppSize.v16 : AppSize.v6,
                    ),
                    child: Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: CalendarEventCard(
                          day: item.day,
                          month: item.monthName,
                          title: item.title,
                          dateRange: item.dateRange,
                          accentColor: item.category.accentColor,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: AppSize.v10),
        _PageDots(count: widget.events.length, current: _currentPage),
      ],
    );
  }
}

// ── Animasyonlu sayfa noktaları ───────────────────────────────────────────────
class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final inactive = Theme.of(
      context,
    ).colorScheme.outline.withValues(alpha: 0.35);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: AppSize.v2 + 1),
          width: isActive ? AppSize.v16 : AppSize.v6,
          height: AppSize.v6,
          decoration: BoxDecoration(
            color: isActive ? primary : inactive,
            borderRadius: BorderRadius.circular(AppSize.v4),
          ),
        );
      }),
    );
  }
}

// ── Kategori → accent rengi ───────────────────────────────────────────────────
extension _CategoryColor on AcademicCalendarCategory {
  Color get accentColor => switch (this) {
    AcademicCalendarCategory.sinav => AppColors.error,
    AcademicCalendarCategory.kayit => AppColors.info,
    AcademicCalendarCategory.ders => AppColors.success,
    AcademicCalendarCategory.harc => AppColors.warning,
    AcademicCalendarCategory.tatil => AppColors.secondary,
    AcademicCalendarCategory.mezuniyet => AppColors.primaryDark,
    AcademicCalendarCategory.diger => AppColors.textSecondary,
  };
}
