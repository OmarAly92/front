// lib/blocs/signup/signup_state.dart

import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class LogoutState extends SignupState {}
class SignupInitState extends SignupState {}

class SignupLoadingState extends SignupState {}
class SignupSuccessState extends  SignupState{}
class SignupErrorState extends SignupState {
  final String message;

  const SignupErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class UserSignupSuccessState extends SignupState {}

class AgencySignupSuccessState extends SignupState {}


