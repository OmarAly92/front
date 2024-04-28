// lib/blocs/login/login_bloc.dart

// import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:tataguid/storage/token_storage.dart';
import '../../repository/auth_repo.dart';
import './login_event.dart';
import './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitState()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    print(
        'Login button pressed: Email: ${event.email}, Password: ${event.password}');
    emit(LoginLoadingState()); // Emit loading state before API call

    try {
      final response = await authRepository.login(event.email, event.password);

      TokenStorage.storeToken(response.token);

      if (response.type == "user") {
        emit(UserLoginSuccessState(type: 'user')); // Navigate to user dashboard
        emit(NavigateToUserDashboard());
      } else if (response.type == "agency") {
        emit(AgencyLoginSuccessState(
            type: 'agency')); // Navigate to agency panel
        emit(NavigateToAgencyPanel());
      } else {
        emit(LoginErrorState("unsupported user type!"));
      }
    } catch (e) {
      print('Error occurred during login: $e');
      emit(LoginErrorState("An error occurred: $e"));
    }
  }

  @override
  void onEvent(LoginEvent event) {
    super.onEvent(event);
    if (event is LoginButtonPressed) {
      print(
          'LoginButtonPressed event received: Email: ${event.email}, Password: ${event.password}');
    }
  }
}
