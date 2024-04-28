// lib/blocs/login/login_state.dart

import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class UserLoginSuccessState extends LoginState {
  final String type;

  const UserLoginSuccessState({required this.type});

  @override
  List<Object> get props => [type];
}

class AgencyLoginSuccessState extends LoginState {
  final String type;

  const AgencyLoginSuccessState({required this.type});

  @override
  List<Object> get props => [type];
}

class LoginErrorState extends LoginState {
  final String message;

  const LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NavigateToAgencyPanel extends LoginState {}

class NavigateToUserDashboard extends LoginState {}
