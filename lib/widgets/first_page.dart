// lib/widgets/first_page.dartq

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tataguid/blocs/resetPassword/reset_password_bloc.dart'; // Import ResetPasswordBloc

import 'package:tataguid/blocs/resetPassword/reset_password_event.dart' as resetEvent;

import 'package:tataguid/blocs/resetPassword/reset_password_state.dart' as resetState;
import 'package:tataguid/storage/token_storage.dart';
import 'package:tataguid/widgets/Forget_Textfield.dart';

import 'package:tataguid/widgets/second_page.dart'; // Import SecondPage

import 'package:tataguid/widgets/continue_button.dart';


class ForgotPasswordFirstPage extends StatelessWidget {
  final double screenHeight;

  final TextEditingController forgetEmail;
  final int currPageIndex;
  final PageController pageController;
  final Function(String) onSubmit; // Define onSubmit function

  const ForgotPasswordFirstPage({
    Key? key,
    required this.screenHeight,
    required this.forgetEmail,
    required this.currPageIndex,
    required this.pageController,
    required double screenWidth,
    required List otpList,
    required GlobalKey<FormState> formKey,
    required this.onSubmit, // Add onSubmit parameter

    // required Null Function(dynamic email) onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResetPasswordBloc resetPasswordBloc =
        BlocProvider.of<ResetPasswordBloc>(context);

    return BlocProvider.value(
      value: resetPasswordBloc,
      child: BlocListener<ResetPasswordBloc, resetState.ResetPasswordState>(
        listener: (context, state) {
          if (state is resetState.ResetCodeVerificationError) {
            // Show float message if email doesn't exist
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('The email entered does not exist.'),
              ),
            );
          } else if (state is resetState.VerificationCodeSent) {
            // Navigate to the second page if email exists and verification code sent
            pageController.animateToPage(
              1,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Forgot password",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: screenHeight * 0.035),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Enter your email for the verification process we will send 6 digits code to your email.",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: screenHeight * 0.02),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text("E-mail",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: screenHeight * 0.017)),
            SizedBox(height: screenHeight * 0.02),
            ForgetField("Enter your email address", forgetEmail,
                TextInputType.emailAddress, Icons.visibility_off),
            SizedBox(height: screenHeight * 0.02),
            BuildContinueButton(
              currpageindx: currPageIndex,
              pageController: pageController,
              onPressed: () async {
                final trimmedEmail = forgetEmail.text.trim();
                if (trimmedEmail.isNotEmpty) {
                  onSubmit(trimmedEmail); // Add email validation and submission
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter your email.'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
