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
  bool isAgency = false;
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
    _logger.i(event);
    // Log the event details with values
    _logger.i('''
      Email: ${event.email}
      Password: ${event.password} (hidden for security)
      Name: ${event.name}
      Agency Name: ${event.agencyName}
      Type: ${event.type}
      Language: ${event.language}
      Country: ${event.country}
      Location: ${event.location}
      Description: ${event.description}
    ''');
    // Check for missing agency-specific fields before sending data
    if (isAgency && (event.agencyName.isEmpty || event.location.isEmpty || event.description.isEmpty)) {
      emit(SignupErrorState("Please fill in all required fields!"));
      return; // Exit the method if data is missing
    }
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
      _logger.i(data);
      // Use a switch statement for type-safe handling:
      switch (event.type) {
        case 'agency': // Updated to match the type string
          emit(AgencySignupSuccessState());
          clearData();
          break; // Handle successful user signup
        case 'user': // Updated to match the type string
          emit(UserSignupSuccessState());
          clearData();
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

  void clearData() {
    isAgency = false;
    email = null;
    password = null;
    name = null;
    agencyName = null;
    type = null;
    language = null;
    country = null;
    location = null;
    description = null;
  }
}
