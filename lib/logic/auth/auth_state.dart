abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class SignupLoading extends AuthState {}

final class SignupError extends AuthState {
  final String message;

  SignupError(this.message);
}

final class SignupSuccess extends AuthState {}
