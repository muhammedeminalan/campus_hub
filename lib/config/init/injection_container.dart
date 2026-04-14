import 'package:campus_hub/config/theme/app_theme.dart';
import 'package:campus_hub/core/cache/shared_prefs_service.dart';
import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/i_token_provider.dart';
import 'package:campus_hub/core/contracts/storage/i_secure_storage.dart';
import 'package:campus_hub/core/mock/services/mock_academic_advisor_service.dart';
import 'package:campus_hub/core/mock/services/mock_absence_service.dart';
import 'package:campus_hub/core/mock/services/mock_course_service.dart';
import 'package:campus_hub/core/mock/services/mock_curriculum_service.dart';
import 'package:campus_hub/core/mock/services/mock_exam_result_service.dart';
import 'package:campus_hub/core/mock/services/mock_preparatory_info_service.dart';
import 'package:campus_hub/core/mock/services/mock_student_service.dart';
import 'package:campus_hub/core/mock/services/mock_todo_service.dart';
import 'package:campus_hub/core/services/auth/firebase_auth_service.dart';
import 'package:campus_hub/core/services/network/dio_service.dart';
import 'package:campus_hub/core/services/storage/secure_storage_service.dart';
import 'package:campus_hub/features/academic_advisor/domain/i_academic_advisor_service.dart';
import 'package:campus_hub/features/academic_advisor/presentation/cubit/academic_advisor_cubit.dart';
import 'package:campus_hub/features/absence_status/domain/i_absence_service.dart';
import 'package:campus_hub/features/absence_status/domain/usecases/calculate_absence_summary_use_case.dart';
import 'package:campus_hub/features/absence_status/presentation/cubit/absence_status_cubit.dart';
import 'package:campus_hub/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:campus_hub/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:campus_hub/features/bottom_navigation/cubit/navigation_cubit.dart';
import 'package:campus_hub/features/courses/domain/i_course_service.dart';
import 'package:campus_hub/features/courses/domain/usecases/filter_courses_by_period_use_case.dart';
import 'package:campus_hub/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:campus_hub/features/curriculum/domain/i_curriculum_service.dart';
import 'package:campus_hub/features/curriculum/domain/usecases/filter_curriculum_by_category_use_case.dart';
import 'package:campus_hub/features/curriculum/presentation/cubit/curriculum_cubit.dart';
import 'package:campus_hub/features/exam_results/domain/i_exam_result_service.dart';
import 'package:campus_hub/features/exam_results/domain/usecases/group_exam_results_by_course_use_case.dart';
import 'package:campus_hub/features/exam_results/presentation/cubit/exam_results_cubit.dart';
import 'package:campus_hub/features/home/domain/i_student_service.dart';
import 'package:campus_hub/features/home/presentation/cubit/home_cubit.dart';
import 'package:campus_hub/features/preparatory_info/domain/i_preparatory_info_service.dart';
import 'package:campus_hub/features/preparatory_info/domain/usecases/calculate_preparatory_progress_use_case.dart';
import 'package:campus_hub/features/preparatory_info/presentation/cubit/preparatory_info_cubit.dart';
import 'package:campus_hub/features/todos/domain/i_todo_service.dart';
import 'package:campus_hub/features/todos/domain/usecases/filter_todos_use_case.dart';
import 'package:campus_hub/features/todos/presentation/cubit/todos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // --- Theme ---
  sl.registerLazySingleton<ThemeData>(() => AppTheme.light);

  // --- Cache (plain) ---
  final sharedPrefsService = SharedPrefsService.instance;
  await sharedPrefsService.init();
  sl.registerLazySingleton<SharedPrefsService>(() => sharedPrefsService);

  // --- Secure Storage ---
  sl.registerLazySingleton<ISecureStorage>(() => SecureStorageService());

  // --- Network ---
  sl.registerLazySingleton<DioService>(() => DioService());

  // --- Auth ---
  // FirebaseAuthService, AuthBase + ITokenProvider her ikisini de karşılar.
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  sl.registerLazySingleton<AuthBase>(() => sl<FirebaseAuthService>());
  sl.registerLazySingleton<ITokenProvider>(() => sl<FirebaseAuthService>());

  // DioService'e auth bağımlılıklarını enjekte et (token + 401 signOut).
  sl<DioService>().configure(
    tokenProvider: sl<ITokenProvider>(),
    authBase: sl<AuthBase>(),
  );

  // --- Auth Use Cases ---
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(authBase: sl<AuthBase>()),
  );
  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(authBase: sl<AuthBase>()),
  );

  // --- Courses ---
  // Firebase'e geçince: MockCourseService() → FirebaseCourseService()
  sl.registerLazySingleton<ICourseService>(() => MockCourseService());
  sl.registerLazySingleton<FilterCoursesByPeriodUseCase>(
    () => const FilterCoursesByPeriodUseCase(),
  );
  sl.registerFactory<CoursesCubit>(
    () => CoursesCubit(
      service: sl<ICourseService>(),
      filterUseCase: sl<FilterCoursesByPeriodUseCase>(),
    ),
  );

  // --- Curriculum ---
  // Firebase'e geçince: MockCurriculumService() → FirebaseCurriculumService()
  sl.registerLazySingleton<ICurriculumService>(() => MockCurriculumService());
  sl.registerLazySingleton<FilterCurriculumByCategoryUseCase>(
    () => const FilterCurriculumByCategoryUseCase(),
  );
  sl.registerFactory<CurriculumCubit>(
    () => CurriculumCubit(
      service: sl<ICurriculumService>(),
      filterUseCase: sl<FilterCurriculumByCategoryUseCase>(),
    ),
  );

  // --- Exam Results ---
  // Firebase'e geçince: MockExamResultService() → FirebaseExamResultService()
  sl.registerLazySingleton<IExamResultService>(() => MockExamResultService());
  sl.registerLazySingleton<GroupExamResultsByCourseUseCase>(
    () => const GroupExamResultsByCourseUseCase(),
  );
  sl.registerFactory<ExamResultsCubit>(
    () => ExamResultsCubit(
      service: sl<IExamResultService>(),
      groupUseCase: sl<GroupExamResultsByCourseUseCase>(),
    ),
  );

  // --- Academic Advisor ---
  // Firebase'e geçince: MockAcademicAdvisorService() → FirebaseAcademicAdvisorService()
  sl.registerLazySingleton<IAcademicAdvisorService>(
    () => MockAcademicAdvisorService(),
  );
  sl.registerFactory<AcademicAdvisorCubit>(
    () => AcademicAdvisorCubit(service: sl<IAcademicAdvisorService>()),
  );

  // --- Student ---
  // Firebase'e geçince: MockStudentService() → FirebaseStudentService()
  sl.registerLazySingleton<IStudentService>(() => MockStudentService());
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(service: sl<IStudentService>()),
  );

  // --- Absence Status ---
  // Firebase'e geçince: MockAbsenceService() → FirebaseAbsenceService()
  sl.registerLazySingleton<IAbsenceService>(() => MockAbsenceService());
  sl.registerLazySingleton<CalculateAbsenceSummaryUseCase>(
    () => const CalculateAbsenceSummaryUseCase(),
  );
  sl.registerFactory<AbsenceStatusCubit>(
    () => AbsenceStatusCubit(
      service: sl<IAbsenceService>(),
      summaryUseCase: sl<CalculateAbsenceSummaryUseCase>(),
    ),
  );

  // --- Todos ---
  // Firebase'e geçince: MockTodoService() → FirebaseTodoService()
  sl.registerLazySingleton<ITodoService>(() => MockTodoService());
  sl.registerLazySingleton<FilterTodosUseCase>(
    () => const FilterTodosUseCase(),
  );
  sl.registerFactory<TodosCubit>(
    () => TodosCubit(
      service: sl<ITodoService>(),
      filterUseCase: sl<FilterTodosUseCase>(),
    ),
  );

  // --- Preparatory Info ---
  // Firebase'e geçince: MockPreparatoryInfoService() → FirebasePreparatoryInfoService()
  sl.registerLazySingleton<IPreparatoryInfoService>(
    () => MockPreparatoryInfoService(),
  );
  sl.registerLazySingleton<CalculatePreparatoryProgressUseCase>(
    () => const CalculatePreparatoryProgressUseCase(),
  );
  sl.registerFactory<PreparatoryInfoCubit>(
    () => PreparatoryInfoCubit(
      service: sl<IPreparatoryInfoService>(),
      calculateUseCase: sl<CalculatePreparatoryProgressUseCase>(),
    ),
  );

  // --- Bloc ---
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(signInUseCase: sl<SignInUseCase>()),
  );

  // --- Cubit ---
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());
}
