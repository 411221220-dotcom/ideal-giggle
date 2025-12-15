import 'package:equatable/equatable.dart';

/// Events for authentication
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Check authentication status
class AuthCheckRequested extends AuthEvent {}

/// Sign in with email and password
class AuthSignInRequested extends AuthEvent {
  const AuthSignInRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// Sign up with email and password
class AuthSignUpRequested extends AuthEvent {
  const AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;

  @override
  List<Object?> get props => [email, password, name];
}

/// Sign out
class AuthSignOutRequested extends AuthEvent {}

/// Reset password
class AuthResetPasswordRequested extends AuthEvent {
  const AuthResetPasswordRequested({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
