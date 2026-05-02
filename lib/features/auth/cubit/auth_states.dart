import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

abstract class FurniAuthState {
  const FurniAuthState();
}

class AuthInitial extends FurniAuthState {}

class AuthLoading extends FurniAuthState {}

class AuthAuthenticated extends FurniAuthState {
  final User user;
  const AuthAuthenticated(this.user);
}

class AuthError extends FurniAuthState {
  final String message;
  const AuthError(this.message);
}
