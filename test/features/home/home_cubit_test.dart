import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/features/home/data/model/student_card_model.dart';
import 'package:campus_hub/features/home/domain/academic_calendar_model.dart';
import 'package:campus_hub/features/home/domain/i_student_service.dart';
import 'package:campus_hub/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockStudentService extends Mock implements IStudentService {}

void main() {
  late _MockStudentService mockService;
  late HomeCubit cubit;

  final tStudentCard = StudentCardModel.mock();

  final tCalendarEvents = [
    AcademicCalendarModel(
      title: 'Vize Sınavları',
      startDate: DateTime(2025, 11, 10),
      endDate: DateTime(2025, 11, 21),
      category: AcademicCalendarCategory.sinav,
    ),
  ];

  setUp(() {
    mockService = _MockStudentService();
    cubit = HomeCubit(service: mockService);
  });

  tearDown(() => cubit.close());

  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'loadHomeData başarılıysa [HomeLoading, HomeLoaded] emit etmeli',
      build: () {
        when(
          () => mockService.getStudentCard(),
        ).thenAnswer((_) async => tStudentCard);
        when(
          () => mockService.getCalendarEvents(),
        ).thenAnswer((_) async => tCalendarEvents);
        return cubit;
      },
      act: (c) => c.loadHomeData(),
      expect: () => [
        const HomeLoading(),
        HomeLoaded(studentCard: tStudentCard, calendarEvents: tCalendarEvents),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'loadHomeData hata fırlatırsa [HomeLoading, HomeError] emit etmeli',
      build: () {
        when(
          () => mockService.getStudentCard(),
        ).thenThrow(Exception('network'));
        when(
          () => mockService.getCalendarEvents(),
        ).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadHomeData(),
      expect: () => [const HomeLoading(), isA<HomeError>()],
    );
  });
}
