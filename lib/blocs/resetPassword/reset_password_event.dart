// lib/blocs/reset_password_event.bloc
import 'package:equatable/equatable.dart';

// @immutable
abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendVerificationCode extends ResetPasswordEvent {
  final String email;

  SendVerificationCode({required this.email});

  @override
  List<Object> get props => [email];
}

class VerifyResetCode extends ResetPasswordEvent {
  final String email;
  final String verificationCode;

  VerifyResetCode({required this.email, required this.verificationCode});
  @override
  List<Object> get props => [email, verificationCode];
}

class ChangePassword extends ResetPasswordEvent {
  final String email;
  final String token;
  final String newPassword;
  final String oldPassword;

  ChangePassword(
      {required this.email,
      required this.token,
      required this.newPassword,
      required this.oldPassword});

  @override
  List<Object> get props => [email, token, newPassword, oldPassword];
}

class ResetCodeVerificationError extends ResetPasswordEvent {
  final String errorMessage;

  ResetCodeVerificationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
