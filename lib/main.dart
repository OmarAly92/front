// lib/main.dart


// import 'package:clientproject/pages/onboarding_page.dart';
// import 'package:clientproject/repository/auth_repo.dart';
// import 'package:clientproject/ui/LoginUi.dart';
// import 'package:clientproject/ui/get_contacts.dart';
// import 'package:tataguid/storage/token_storage.dart';
// import 'package:clientproject/ui/post_contacts.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tataguid/blocs/login/login_bloc.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_bloc.dart';
import 'package:tataguid/blocs/signup/signup_bloc.dart';
import 'package:tataguid/pages/onboarding_page.dart';
import 'package:tataguid/repository/auth_repo.dart';
import 'package:provider/provider.dart';
import 'package:tataguid/repository/password_reset_repo.dart';
import 'package:tataguid/ui/LoginUi.dart';
import 'package:tataguid/ui/get_contacts.dart';
import 'package:tataguid/ui/post_contacts.dart';
import 'package:tataguid/ui/signup_option.dart';
import 'blocs/signup/signup_bloc.dart';

void main() => runApp(TataGuid());

class TataGuid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final TokenStorage tokenStorage = TokenStorage();
    final AuthRepository authRepository = AuthRepository();
    final ForgotPasswordRepository forgotPasswordRepository = ForgotPasswordRepository();


    return MultiProvider(
      providers: [
        Provider<AuthRepository>.value(value: authRepository),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: authRepository),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(authRepository: authRepository),
        ),
        BlocProvider<ResetPasswordBloc>(
      create: (context) => ResetPasswordBloc(forgotPasswordRepository: forgotPasswordRepository),
    ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login_ui',
        routes: {
          '/': (context) => OnboardingPage(),
          '/user_dashboard': (context) => UserPage(), // Replace with your user dashboard widget
          '/agency_panel': (context) => AgencyPanelScreen(), // Replace with your agency panel widget
          '/login_ui': (context) => LoginUi(), // Replace with your agency panel widget
        },
        onGenerateRoute: (settings) {
          // Handle platform-specific error route
          if (Platform.isAndroid || Platform.isIOS) {
            return MaterialPageRoute(
              builder: (context) => PlatformErrorScreen(),
            );
          }
          return null;
        },
      ),
    );
  }
}

class PlatformErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Error'),
      ),
      body: Center(
        child: Text(
          'Unsupported operation: Platform._operatingSystem',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
