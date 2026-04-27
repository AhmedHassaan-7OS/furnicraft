import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  bool _passwordVisible = false;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    emit(AuthPasswordVisible(isVisible: _passwordVisible));
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    if (email.isNotEmpty && password.isNotEmpty) {
      emit(const AuthSuccess());
    } else {
      emit(const AuthFailure(message: 'Invalid email or password'));
    }
  }

  void resetState() => emit(const AuthInitial());
}
