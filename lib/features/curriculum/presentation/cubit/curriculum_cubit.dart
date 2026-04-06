import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';
import 'package:campus_hub/features/curriculum/domain/i_curriculum_service.dart';
import 'package:campus_hub/features/curriculum/domain/usecases/filter_curriculum_by_category_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'curriculum_state.dart';

class CurriculumCubit extends Cubit<CurriculumState> {
  final ICurriculumService _service;
  final FilterCurriculumByCategoryUseCase _filterUseCase;

  CurriculumCubit({
    required ICurriculumService service,
    FilterCurriculumByCategoryUseCase? filterUseCase,
  }) : _service = service,
       _filterUseCase =
           filterUseCase ?? const FilterCurriculumByCategoryUseCase(),
       super(const CurriculumInitial());

  /// Müfredat verilerini yükler ve varsayılan kategori seçimini oluşturur.
  Future<void> loadData() async {
    emit(const CurriculumLoading());

    try {
      final (classLevelsFromService, allCurriculums) = await (
        _service.getClassLevels(),
        _service.getAll(),
      ).wait;

      final classLevels = _normalizeClassLevels(
        classLevelsFromService,
        allCurriculums,
      );
      final selectedClassLevel = _resolveDefaultClassLevel(classLevels);
      final semesters = _resolveSemestersByClass(
        allCurriculums,
        selectedClassLevel,
      );
      final selectedSemester = _resolveDefaultSemester(semesters);

      final filteredCurriculums = _filterUseCase(
        allCurriculums,
        classLevel: selectedClassLevel,
        semester: selectedSemester,
      );

      emit(
        CurriculumLoaded(
          classLevels: classLevels,
          semesters: semesters,
          allCurriculums: allCurriculums,
          filteredCurriculums: filteredCurriculums,
          selectedClassLevel: selectedClassLevel,
          selectedSemester: selectedSemester,
        ),
      );
    } catch (e, st) {
      debugPrint('CurriculumCubit.loadData hatası: $e\n$st');
      emit(CurriculumError(message: e.toString()));
    }
  }

  /// Seçili sınıf seviyesini değiştirir ve dönem listesini buna göre günceller.
  void selectClassLevel(int classLevel) {
    final current = state;
    if (current is! CurriculumLoaded) return;

    final semesters = _resolveSemestersByClass(
      current.allCurriculums,
      classLevel,
    );

    final selectedSemester = semesters.contains(current.selectedSemester)
        ? current.selectedSemester
        : (semesters.isNotEmpty ? semesters.first : null);

    final filteredCurriculums = _filterUseCase(
      current.allCurriculums,
      classLevel: classLevel,
      semester: selectedSemester,
    );

    emit(
      current.copyWith(
        selectedClassLevel: classLevel,
        semesters: semesters,
        selectedSemester: selectedSemester,
        filteredCurriculums: filteredCurriculums,
      ),
    );
  }

  /// Seçili dönemi günceller ve müfredat listesini yeniden filtreler.
  void selectSemester(int semester) {
    final current = state;
    if (current is! CurriculumLoaded) return;

    final filteredCurriculums = _filterUseCase(
      current.allCurriculums,
      classLevel: current.selectedClassLevel,
      semester: semester,
    );

    emit(
      current.copyWith(
        selectedSemester: semester,
        filteredCurriculums: filteredCurriculums,
      ),
    );
  }

  /// Filtreleri başlangıç değerine döndürür.
  void resetFilters() {
    final current = state;
    if (current is! CurriculumLoaded) return;

    final selectedClassLevel = _resolveDefaultClassLevel(current.classLevels);
    final semesters = _resolveSemestersByClass(
      current.allCurriculums,
      selectedClassLevel,
    );
    final selectedSemester = _resolveDefaultSemester(semesters);

    final filteredCurriculums = _filterUseCase(
      current.allCurriculums,
      classLevel: selectedClassLevel,
      semester: selectedSemester,
    );

    emit(
      current.copyWith(
        selectedClassLevel: selectedClassLevel,
        semesters: semesters,
        selectedSemester: selectedSemester,
        filteredCurriculums: filteredCurriculums,
      ),
    );
  }

  List<int> _normalizeClassLevels(
    List<int> classLevelsFromService,
    List<CurriculumModel> allCurriculums,
  ) {
    final normalized = <int>{
      ...classLevelsFromService,
      ...allCurriculums.map((curriculum) => curriculum.classLevel),
    }.toList()..sort();

    return normalized;
  }

  int? _resolveDefaultClassLevel(List<int> classLevels) {
    return classLevels.isNotEmpty ? classLevels.first : null;
  }

  int? _resolveDefaultSemester(List<int> semesters) {
    return semesters.isNotEmpty ? semesters.first : null;
  }

  List<int> _resolveSemestersByClass(
    List<CurriculumModel> allCurriculums,
    int? classLevel,
  ) {
    if (classLevel == null) return const [];

    final semesters =
        allCurriculums
            .where((curriculum) => curriculum.classLevel == classLevel)
            .map((curriculum) => curriculum.semester)
            .toSet()
            .toList()
          ..sort();

    return semesters;
  }
}
