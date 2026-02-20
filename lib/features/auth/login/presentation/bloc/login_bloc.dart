import 'package:campus_hub/core/contracts/auth/auth_base.dart';
import 'package:campus_hub/core/contracts/auth/auth_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBase _authService;

  LoginBloc({required AuthBase authService})
    : _authService = authService,
      super(const LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      final uid = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess(uid: uid));
    } on AuthException catch (e) {
      emit(LoginFailure(message: e.message));
    } catch (_) {
      emit(const LoginFailure(message: 'Bir hata oluştu.'));
    }
  }
}
