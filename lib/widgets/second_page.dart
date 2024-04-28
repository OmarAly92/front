// lib/widgets/second_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_bloc.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_event.dart' as resetEvent; // Use 'as resetEvent' for disambiguation
import 'package:tataguid/blocs/resetPassword/reset_password_state.dart' as resetState; // Use 'as resetState' for disambiguation
import 'package:tataguid/storage/token_storage.dart';
import 'package:tataguid/widgets/continue_button.dart';
import 'package:tataguid/widgets/otp_textfield.dart';

class ForgotPasswordSecondPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final List<String> otpList;
  final GlobalKey<FormState> formKey;
  final int currPageIndex;
  final PageController pageController;
  final TextEditingController forgetEmail;
  final TextEditingController verificationCodeController;

  const ForgotPasswordSecondPage({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.otpList,
    required this.formKey,
    required this.currPageIndex,
    required this.pageController,
    required this.forgetEmail,
    required this.verificationCodeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResetPasswordBloc resetPasswordBloc =
        BlocProvider.of<ResetPasswordBloc>(
            context); // Create instance of ResetPasswordBloc

    return BlocProvider.value(
      value: resetPasswordBloc,
      child: Scaffold(
        body: BlocListener<ResetPasswordBloc, resetState.ResetPasswordState>(
          listener: (context, state) {
            // Handle state changes if needed
            if (state is resetState.ResetCodeVerified) {
              // Navigate to the third page if verification code is valid
              pageController.animateToPage(
                2,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            } else if (state is resetState.ResetCodeVerificationError) {
              // Show error message for verification code error
              if (state.errorMessage == 'Invalid verification code') {
                // Show error message for incorrect verification code
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('The verification code is incorrect.'),
                      behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state.errorMessage == 'Verification code is empty') {
                // Show error message for empty verification code
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter the verification code.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                // Show generic error message for other errors
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
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
                    "Enter 6 Digits Code",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.035,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Enter the 6 digits code that you received on your email.",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      fontSize: screenHeight * 0.02,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Builder(
                    builder: (context) {
                      return otp(
                        context, // BuildContext
                        screenWidth, // double
                        otpList, // List<String>
                        formKey,
                        verificationCodeController, // TextEditingController
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  BuildContinueButton(
                    currpageindx: currPageIndex,
                    pageController: pageController,
                    onPressed: () async {
                      final token = await TokenStorage.getToken();
                      switch (token != null) {
                        case true:
                          final trimmedCode =
                              verificationCodeController.text.trim();
                          switch (trimmedCode.isEmpty) {
                            case true:
                              // Show snackbar for empty verification code
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please enter the verification code.'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              break;
                            default:
                              // Verify the reset code
                              resetPasswordBloc.add(
                                resetEvent.VerifyResetCode(
                                  verificationCode: trimmedCode,
                                  email: forgetEmail.text,
                                ),
                              );
                          }
                          break;
                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to retrieve user token.'),
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
