import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';
import 'package:campus_hub/features/curriculum/domain/i_curriculum_service.dart';
import 'package:campus_hub/features/curriculum/domain/usecases/filter_curriculum_by_category_use_case.dart';
import 'package:campus_hub/features/curriculum/presentation/cubit/curriculum_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCurriculumService extends Mock implements ICurriculumService {}

void main() {
  late _MockCurriculumService mockService;
  late CurriculumCubit cubit;

  final tCurriculums = [
    const CurriculumModel(
      id: '1',
      courseCode: 'YBS101',
      courseName: 'Giriş',
      classLevel: 1,
      semester: 1,
      credit: 3,
      akts: 5,
      isCompulsory: true,
    ),
    const CurriculumModel(
      id: '2',
      courseCode: 'YBS102',
      courseName: 'Programlama',
      classLevel: 1,
      semester: 2,
      credit: 4,
      akts: 6,
      isCompulsory: true,
    ),
    const CurriculumModel(
      id: '3',
      courseCode: 'YBS201',
      courseName: 'Veri Tabanı',
      classLevel: 2,
      semester: 1,
      credit: 4,
      akts: 6,
      isCompulsory: true,
    ),
  ];

  setUp(() {
    mockService = _MockCurriculumService();
    cubit = CurriculumCubit(
      service: mockService,
      filterUseCase: const FilterCurriculumByCategoryUseCase(),
    );
  });

  tearDown(() => cubit.close());

  group('CurriculumCubit', () {
    blocTest<CurriculumCubit, CurriculumState>(
      'loadData başarılıysa [CurriculumLoading, CurriculumLoaded] emit etmeli',
      build: () {
        when(
          () => mockService.getClassLevels(),
        ).thenAnswer((_) async => [1, 2]);
        when(() => mockService.getAll()).thenAnswer((_) async => tCurriculums);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [
        const CurriculumLoading(),
        isA<CurriculumLoaded>().having(
          (state) => state.selectedClassLevel,
          'selectedClassLevel',
          1,
        ),
      ],
    );

    blocTest<CurriculumCubit, CurriculumState>(
      'loadData hata alırsa [CurriculumLoading, CurriculumError] emit etmeli',
      build: () {
        when(
          () => mockService.getClassLevels(),
        ).thenThrow(Exception('network'));
        when(() => mockService.getAll()).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const CurriculumLoading(), isA<CurriculumError>()],
    );

    blocTest<CurriculumCubit, CurriculumState>(
      'selectClassLevel seçimi sonrası dönem ve liste güncellenmeli',
      build: () {
        when(
          () => mockService.getClassLevels(),
        ).thenAnswer((_) async => [1, 2]);
        when(() => mockService.getAll()).thenAnswer((_) async => tCurriculums);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.selectClassLevel(2);
      },
      expect: () => [
        const CurriculumLoading(),
        isA<CurriculumLoaded>(),
        isA<CurriculumLoaded>().having(
          (state) => state.selectedClassLevel,
          'selectedClassLevel',
          2,
        ),
      ],
      verify: (c) {
        final state = c.state as CurriculumLoaded;
        expect(state.filteredCurriculums.every((e) => e.classLevel == 2), true);
      },
    );

    blocTest<CurriculumCubit, CurriculumState>(
      'selectSemester seçimi sonrası filtrelenmiş müfredat güncellenmeli',
      build: () {
        when(
          () => mockService.getClassLevels(),
        ).thenAnswer((_) async => [1, 2]);
        when(() => mockService.getAll()).thenAnswer((_) async => tCurriculums);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.selectSemester(2);
      },
      verify: (c) {
        final state = c.state as CurriculumLoaded;
        expect(state.selectedSemester, 2);
        expect(state.filteredCurriculums.length, 1);
        expect(state.filteredCurriculums.first.id, '2');
      },
    );

    blocTest<CurriculumCubit, CurriculumState>(
      'resetFilters çağrısı varsayılan sınıf ve dönemi geri yüklemeli',
      build: () {
        when(
          () => mockService.getClassLevels(),
        ).thenAnswer((_) async => [1, 2]);
        when(() => mockService.getAll()).thenAnswer((_) async => tCurriculums);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.selectClassLevel(2);
        c.resetFilters();
      },
      verify: (c) {
        final state = c.state as CurriculumLoaded;
        expect(state.selectedClassLevel, 1);
        expect(state.selectedSemester, 1);
      },
    );
  });
}
