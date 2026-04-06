import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';
import 'package:campus_hub/features/curriculum/domain/i_curriculum_service.dart';
import 'package:campus_hub/features/curriculum/presentation/cubit/curriculum_cubit.dart';
import 'package:campus_hub/features/curriculum/presentation/view/curriculum_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeCurriculumService implements ICurriculumService {
  @override
  Future<List<CurriculumModel>> getAll() async => _items;

  @override
  Future<CurriculumModel?> getById(String id) async {
    return _items.where((item) => item.id == id).firstOrNull;
  }

  @override
  Future<List<int>> getClassLevels() async => [1, 2];

  @override
  Future<List<CurriculumModel>> getCurriculumsByCategory({
    required int classLevel,
    required int semester,
  }) async {
    return _items
        .where(
          (item) => item.classLevel == classLevel && item.semester == semester,
        )
        .toList();
  }

  static const _items = <CurriculumModel>[
    CurriculumModel(
      id: 'c1',
      courseCode: 'YBS101',
      courseName: 'YBS Giriş',
      classLevel: 1,
      semester: 1,
      credit: 3,
      akts: 5,
      isCompulsory: true,
    ),
    CurriculumModel(
      id: 'c2',
      courseCode: 'YBS201',
      courseName: 'Veri Tabanı',
      classLevel: 2,
      semester: 1,
      credit: 4,
      akts: 6,
      isCompulsory: true,
    ),
    CurriculumModel(
      id: 'c3',
      courseCode: 'YBS202',
      courseName: 'Bitirme Projesi II',
      classLevel: 2,
      semester: 2,
      credit: 2,
      akts: 5,
      isCompulsory: true,
    ),
  ];
}

void main() {
  late CurriculumCubit cubit;

  setUp(() {
    cubit = CurriculumCubit(service: _FakeCurriculumService());
  });

  tearDown(() async {
    await cubit.close();
  });

  testWidgets('bottom sheet filtreleri uygular ve listeyi günceller', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: CurriculumView(cubit: cubit)));

    await tester.pumpAndSettle();

    final initialSelected = tester.widget<Text>(
      find.byKey(const ValueKey('curriculum_selected_category_text')),
    );
    expect(initialSelected.data, '1. Sınıf • 1. Dönem');

    await tester.tap(
      find.byKey(const ValueKey('curriculum_filter_open_button')),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('curriculum_filter_apply_button')),
      findsOneWidget,
    );

    await tester.tap(find.text('2. Sınıf'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('2. Dönem'));
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const ValueKey('curriculum_filter_apply_button')),
    );
    await tester.pumpAndSettle();

    final updatedSelected = tester.widget<Text>(
      find.byKey(const ValueKey('curriculum_selected_category_text')),
    );
    expect(updatedSelected.data, '2. Sınıf • 2. Dönem');
    expect(find.text('Bitirme Projesi II'), findsOneWidget);
    expect(find.text('YBS Giriş'), findsNothing);
  });
}
