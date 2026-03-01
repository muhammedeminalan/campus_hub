import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/auth_exception.dart';
import 'package:campus_hub/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:campus_hub/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthBase extends Mock implements AuthBase {}

void main() {
  late _MockAuthBase mockAuth;
  late LoginBloc bloc;

  setUp(() {
    mockAuth = _MockAuthBase();
    bloc = LoginBloc(signInUseCase: SignInUseCase(authBase: mockAuth));
  });

  tearDown(() => bloc.close());

  const tEmail = 'test@example.com';
  const tPassword = 'secret123';
  const tUid = 'user-uid-42';

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      'baslangic durumu LoginInitial olmali',
      build: () => bloc,
      expect: () => [],
      verify: (_) => expect(bloc.state, const LoginInitial()),
    );

    blocTest<LoginBloc, LoginState>(
      'basarili giriste LoginLoading + LoginSuccess emit etmeli',
      build: () {
        when(
          () => mockAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => tUid);
        return bloc;
      },
      act: (b) =>
          b.add(const LoginRequested(email: tEmail, password: tPassword)),
      expect: () => [const LoginLoading(), const LoginSuccess(uid: tUid)],
    );

    blocTest<LoginBloc, LoginState>(
      'AuthException durumunda LoginLoading + LoginFailure emit etmeli',
      build: () {
        when(
          () => mockAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(const AuthException('Hatali sifre.'));
        return bloc;
      },
      act: (b) =>
          b.add(const LoginRequested(email: tEmail, password: tPassword)),
      expect: () => [
        const LoginLoading(),
        const LoginFailure(message: 'Hatali sifre.'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'beklenmedik hata durumunda LoginLoading + LoginFailure emit etmeli',
      build: () {
        when(
          () => mockAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(Exception('network'));
        return bloc;
      },
      act: (b) =>
          b.add(const LoginRequested(email: tEmail, password: tPassword)),
      expect: () => [
        const LoginLoading(),
        const LoginFailure(message: 'Beklenmeyen bir hata olustu.'),
      ],
    );
  });
}
