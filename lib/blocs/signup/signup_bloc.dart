// lib/blocs/signup/signup_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tataguid/blocs/signup/signup_event.dart';
import 'package:tataguid/blocs/signup/signup_state.dart';

import '../../repository/auth_repo.dart';

class SignupBloc extends Bloc<SignupEvents, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(LogoutState()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }
  Logger _logger = Logger();

  String? email;
  String? password;
  String? name;
  String? agencyName;
  String? type;
  String? language;
  String? country;
  String? location;
  String? description;

  void _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoadingState()); // Emit loading state before API call
    _logger.i(event );
    try {
      var data = await authRepository.signUp(
        name: event.name,
        agencyName: event.agencyName,
        email: event.email,
        password: event.password,
        type: event.type,
        language: event.language,
        country: event.country,
        location: event.location,
        description: event.description,
      );
      _logger.i(data );
      // Use a switch statement for type-safe handling:
      switch (event.type) {
        case 'agency': // Updated to match the type string
          emit(AgencySignupSuccessState());
          break; // Handle successful user signup
        case 'user': // Updated to match the type string
          emit(UserSignupSuccessState());
          break; // Handle successful agency signup
        default:
          emit(SignupErrorState('Invalid user type: ${event.type}'));
          break; // Handle invalid type case
      }
    } catch (error) {
      _logger.e(error);
      emit(SignupErrorState(error.toString())); // Emit error state with message
    }
  }
}
