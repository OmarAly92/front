// lib/blocs/reset_password_bloc

import 'dart:async';
// import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_event.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_state.dart';
import 'package:tataguid/repository/password_reset_repo.dart';
import 'package:tataguid/storage/token_storage.dart';
import 'package:tataguid/ui/get_contacts.dart';
import 'package:tataguid/ui/post_contacts.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ForgotPasswordRepository forgotPasswordRepository;

  ResetPasswordBloc({required this.forgotPasswordRepository})
      : super(ResetPasswordInitial()) {
    on<SendVerificationCode>((event, emit) async {
      emit(await _mapSendVerificationCodeToState(event));
    });

    on<VerifyResetCode>((event, emit) async {
      emit(await _mapVerifyResetCodeToState(event));
    });

    on<ChangePassword>((event, emit) async {
      final result = await _mapChangePasswordToState(event);
      if (result is PasswordChanged) {
        // Navigate to the appropriate screen based on the user type
        if (result.userType == 'user') {
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(builder: (context) => UserPage()),
          );
        } else if (result.userType == 'agency') {
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(builder: (context) => AgencyPanelScreen()),
          );
        }
      }
    } as EventHandler<ChangePassword, ResetPasswordState>);
    
  }

  // @override
  Stream<ResetPasswordState> mapEventToState(
    ResetPasswordEvent event,
    Emitter<ResetPasswordState> emit,
  ) async* {
    if (event is SendVerificationCode) {
      emit(await _mapSendVerificationCodeToState(event));
    } else if (event is VerifyResetCode) {
      emit(await _mapVerifyResetCodeToState(event));
    } else if (event is ChangePassword) {
      emit(await _mapChangePasswordToState(event));
    }
  }

  Future<ResetPasswordState> _mapSendVerificationCodeToState(
    SendVerificationCode event,
  ) async {
    // Implement sending verification code logic here
    print('Send verification code button pressed: Email: ${event.email}');
    try {
      await forgotPasswordRepository.sendPasswordResetLink(event.email);
      return VerificationCodeSent();
    } catch (e) {
      return ResetPasswordError(error: e.toString()); // Emit error state
    }
  }

  Future<ResetPasswordState> _mapVerifyResetCodeToState(
    VerifyResetCode event,
  ) async {
    // Implement verification code logic here
    try {
      final result = await forgotPasswordRepository.verifyResetCode(
          event.email, event.verificationCode);

      return result
          ? ResetCodeVerified()
          : ResetPasswordError(error: 'Invalid verification code');
    } catch (e) {
      return ResetPasswordError(error: e.toString());
    }
  }

  Future<ResetPasswordState> _mapChangePasswordToState(
    ChangePassword event,
  ) async {
    try {
      await forgotPasswordRepository.changePassword(
        event.email,
        event.newPassword,
        event.oldPassword,
        event.token,
        timeout: Duration(seconds: 30), // Increase timeout duration
      );
      // Get the user type
      final userType = await TokenStorage.getUserType();
      return PasswordChanged(userType: userType);
    } catch (e) {
      if (e is Exception && e.toString().contains('401')) {
        return ResetPasswordError(
            error: 'Invalid credentials. Please check your email and token.');
      } else {
        return ResetPasswordError(error: e.toString());
      }
    }
  }
}
