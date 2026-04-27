abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthPasswordVisible extends AuthState {
  final bool isVisible;
  const AuthPasswordVisible({required this.isVisible});
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});
}
