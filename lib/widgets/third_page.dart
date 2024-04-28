// lib/widgets/third_page.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_bloc.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_event.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_state.dart';
import 'package:tataguid/repository/auth_repo.dart';
import 'package:tataguid/repository/password_reset_repo.dart';
import 'package:tataguid/storage/token_storage.dart';
import 'Forget_Textfield.dart';
import 'continue_button.dart';

class ForgotPasswordThirdPage extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final int currPageIndex;
  final TextEditingController forgetEmail;
  final PageController pageController;
  final double screenHeight;
  final double screenWidth;

  const ForgotPasswordThirdPage({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.currPageIndex,
    required this.forgetEmail,
    required this.pageController,
    required List otpList,
    required GlobalKey<FormState> formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResetPasswordBloc resetPasswordBloc =
        BlocProvider.of<ResetPasswordBloc>(context);

    return BlocProvider.value(
      value: resetPasswordBloc,
      child: Scaffold(
        body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is PasswordChanged) {
              // Navigate to success page or show success message
              // ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password changed successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is ResetPasswordError) {
              // Handle error state
              // ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Reset password",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.035),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Set the new password for your account so you can login and access all the features.",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                        fontSize: screenHeight * 0.02),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.017),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ForgetField(
                    "Enter your password",
                    passwordController,
                    TextInputType.visiblePassword,
                    Icons.visibility_off,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.017),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ForgetField(
                    "Enter your new password",
                    confirmPasswordController,
                    TextInputType.visiblePassword,
                    Icons.visibility_off,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  BuildContinueButton(
                    currpageindx: currPageIndex,
                    pageController: pageController,
                    onPressed: () async {
                      final token = await TokenStorage.getToken();
                      if (token != null) {
                        if (passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          // Handle empty fields
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill in all fields.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          try {
                            resetPasswordBloc.add(ChangePassword(
                              email: forgetEmail.text,
                              oldPassword: passwordController.text,
                              newPassword: confirmPasswordController.text,
                              token: token,
                            ));
                            // Wait for the password change to complete
                            await Future.delayed(
                                Duration(seconds: 1)); // Adjust delay as needed
                            // Re-login with the new password
                            final authRepository = AuthRepository();
                            final loginResponse = await authRepository.login(
                              forgetEmail.text,
                              confirmPasswordController.text,
                            );
                            // Store the new token
                            await TokenStorage.storeToken(loginResponse.token);
                            // Navigate to the success page
                            Navigator.pushReplacementNamed(context, 'user_dashboard');
                          } catch (e) {
                            // Handle errors
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error changing password: $e'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Please log in to reset your password.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
