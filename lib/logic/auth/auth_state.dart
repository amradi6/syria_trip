abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class SignupLoading extends AuthState {}

final class SignupError extends AuthState {
  final String message;

  SignupError(this.message);
}

final class SignupSuccess extends AuthState {
  final String message;

  SignupSuccess(this.message);
}

final class LoginLoading extends AuthState {}

final class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

final class LoginSuccess extends AuthState {
  final String message;

  LoginSuccess(this.message);
}


class PasswordVisibilityChangedForSignup extends AuthState {
  final bool isHidden;

  PasswordVisibilityChangedForSignup(this.isHidden);
}

class PasswordVisibilityChangedForLogin extends AuthState {
  final bool isHidden;

  PasswordVisibilityChangedForLogin(this.isHidden);
}
