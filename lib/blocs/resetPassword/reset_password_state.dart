// lib/blocs/reset_password_state.bloc

// lib/blocs/reset_password_state.dart

import 'package:equatable/equatable.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class VerificationCodeSent extends ResetPasswordState {}

class ResetCodeVerified extends ResetPasswordState {}

class ResetCodeVerificationError extends ResetPasswordState {
  final String errorMessage;

  ResetCodeVerificationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class PasswordChanged extends ResetPasswordState {
  final userType;

  PasswordChanged({required this.userType});

  @override
  List<Object> get props => [userType];
}

class ResetPasswordError extends ResetPasswordState {
  final String error;

  ResetPasswordError({required this.error});

  @override
  List<Object> get props => [error];
}
