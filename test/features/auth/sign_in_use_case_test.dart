import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/auth_exception.dart';
import 'package:campus_hub/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthBase extends Mock implements AuthBase {}

void main() {
  late _MockAuthBase mockAuth;
  late SignInUseCase useCase;

  setUp(() {
    mockAuth = _MockAuthBase();
    useCase = SignInUseCase(authBase: mockAuth);
  });

  group('SignInUseCase', () {
    const tEmail = 'test@example.com';
    const tPassword = 'p@ssw0rd';
    const tUid = 'uid-123';

    test('geçerli giriş bilgilerinde uid döndürmeli', () async {
      when(
        () => mockAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => tUid);

      final result = await useCase(email: tEmail, password: tPassword);
      expect(result, tUid);
    });

    test('bos email icin AuthException firlatmali', () {
      expect(
        () => useCase(email: '', password: tPassword),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'E-posta alani bos birakilamaz.',
          ),
        ),
      );
      verifyNever(
        () => mockAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    });

    test('bos sifre icin AuthException firlatmali', () {
      expect(
        () => useCase(email: tEmail, password: ''),
        throwsA(isA<AuthException>()),
      );
    });

    test('AuthBase exception\'i tekrar firlatmali', () async {
      when(
        () => mockAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenThrow(const AuthException('Gecersiz kimlik bilgileri.'));

      expect(
        () => useCase(email: tEmail, password: tPassword),
        throwsA(isA<AuthException>()),
      );
    });
  });
}
