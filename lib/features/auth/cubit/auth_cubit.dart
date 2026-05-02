import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<FurniAuthState> {
  AuthCubit() : super(AuthInitial());

  final _client = Supabase.instance.client;

  // Form fields (held locally; not in state to avoid rebuilds on every keystroke)
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _fullName = '';

  void onEmailChanged(String v) => _email = v;
  void onPasswordChanged(String v) => _password = v;
  void onConfirmPasswordChanged(String v) => _confirmPassword = v;
  void onFullNameChanged(String v) => _fullName = v;

  Future<void> signIn() async {
    if (_email.isEmpty || _password.isEmpty) {
      emit(const AuthError('Please fill in all fields'));
      return;
    }
    emit(AuthLoading());
    try {
      final response = await _client.auth.signInWithPassword(
        email: _email,
        password: _password,
      );
      if (response.user != null) {
        emit(AuthAuthenticated(response.user!));
      } else {
        emit(const AuthError('Sign in failed'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp() async {
    if (_email.isEmpty || _password.isEmpty || _fullName.isEmpty) {
      emit(const AuthError('Please fill in all fields'));
      return;
    }
    if (_password != _confirmPassword) {
      emit(const AuthError('Passwords do not match'));
      return;
    }
    if (_password.length < 6) {
      emit(const AuthError('Password must be at least 6 characters'));
      return;
    }
    emit(AuthLoading());
    try {
      final response = await _client.auth.signUp(
        email: _email,
        password: _password,
        data: {'full_name': _fullName},
      );
      if (response.user != null) {
        emit(AuthAuthenticated(response.user!));
      } else {
        emit(const AuthError('Registration failed. Please try again.'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    emit(AuthInitial());
  }

  bool get isAuthenticated => _client.auth.currentUser != null;
}
