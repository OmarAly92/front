// lib/ui/LoginUi.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tataguid/blocs/login/login_bloc.dart';
import 'package:tataguid/blocs/login/login_event.dart';
import 'package:tataguid/blocs/login/login_state.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_event.dart';
import 'package:tataguid/components/my_button.dart';
import 'package:tataguid/components/my_textfield.dart';
import 'package:tataguid/components/square_tile.dart';
import 'package:tataguid/ui/SignUpUi.dart';
import '../widgets/first_page.dart';
import '../widgets/second_page.dart';
import '../widgets/third_page.dart';
import 'package:tataguid/blocs/resetPassword/reset_password_bloc.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController emailController =
      TextEditingController(text: 'mrabet@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '12345678');
  late LoginBloc authBloc;
  String errorMessage = '';

  late double
      screenWidth; // screen width takes the size.width to create responsive design and you can change easily
  late double screenHeight; // same as for screenheight

  // used for forget password
  List<String> otplist =
      []; // otp list is used for 4 digit otp that you will send on users email
  GlobalKey<FormState> formKey =
      GlobalKey(); // formkey handles the email and password textformfield
  PageController pageController =
      PageController(); // page controller handles the animation when you tap continue button

  // these are the 3 controller that handles the textformfield when user fill the information like email and password and new password
  TextEditingController forget_email = TextEditingController(
      text:
          'raserfinblade@gmail.com'); // forget_email just extract value with the help of this controller
  TextEditingController password =
      TextEditingController(text: '987654321'); // same as for password
  TextEditingController confirmPasswordController =
      TextEditingController(text: '987654321'); // same as for confirm password
  TextEditingController verificationCode =
      TextEditingController(); // same as for confirm password
  TextEditingController confirmPass =
      TextEditingController(); // same as for confirm password

  // just use controllername.value.toString() then you just use this string for further process
  late ResetPasswordBloc resetPasswordBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<LoginBloc>(context);
    resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    forget_email.dispose();
    verificationCode.dispose();
    password.dispose();
    confirmPass.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _loginButtonPressed() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter email and password.';
      });
    } else {
      authBloc.add(LoginButtonPressed(email: email, password: password));
    }
  }

  void _clearErrorMessage() {
    setState(() {
      errorMessage = '';
    });
  }

  void shifting(int currpageindx) {
    setState(() {
      currpageindx += 1;
      print(currpageindx);
      pageController.animateToPage(currpageindx,
          duration: Duration(microseconds: 300), curve: Curves.easeIn);
    });
  }

  // Function to send verification code upon user email submission (ForgotPasswordFirstPage)
  void sendVerificationCode(String email) {
    resetPasswordBloc.add(SendVerificationCode(email: email));
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            if (state.type == 'user') {
              Navigator.pushNamed(context, '/user_dashboard');
            }
          } else if (state is AgencyLoginSuccessState) {
            Navigator.pushNamed(context, '/agency_panel');
          } else if (state is LoginErrorState) {
            // Handle error state
          } else if (state is NavigateToUserDashboard) {
            Navigator.pushNamed(context, '/user_dashboard');
          } else if (state is NavigateToAgencyPanel) {
            Navigator.pushNamed(context, '/agency_panel');
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Icon(Icons.supervised_user_circle,
                        size: screenWidth * 0.4, color: Colors.blue),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: screenHeight * 0.03),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    obscureText: false,
                    onChanged: _clearErrorMessage,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    onChanged: _clearErrorMessage,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          _showBottomWidget(context);
                        },
                        child: Text(
                          "Forget password ?",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w700),
                        )),
                  ),
                  MyButton(
                    onPressed: _loginButtonPressed,
                    text: 'Log In',
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        imagePath: 'assets/images/google.png',
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      SquareTile(
                        imagePath: 'assets/images/apple.png',
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomWidget(BuildContext context) {
    // when user will click on ----"forget password "---- then a bottom widget opens from bottom of the screen

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      // this is the widget that i created seperatly
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              ForgotPasswordFirstPage(
                screenHeight: screenHeight,
                forgetEmail: forget_email,
                currPageIndex: 0,
                pageController: pageController,
                screenWidth: screenWidth,
                otpList: [],
                formKey: formKey,
                onSubmit: (email) {
                  resetPasswordBloc.add(SendVerificationCode(email: email));
                },
              ), // forget password first page where you fill email
              ForgotPasswordSecondPage(
                screenHeight: screenHeight,
                forgetEmail: forget_email,
                currPageIndex: 1,
                pageController: pageController,
                screenWidth: screenWidth,
                otpList: [],
                formKey: formKey,
                verificationCodeController: verificationCode,
              ), // second page where you enter otp that will send on users email
              ForgotPasswordThirdPage(
                screenHeight: screenHeight,
                forgetEmail: forget_email,
                currPageIndex: 2,
                pageController: pageController,
                screenWidth: screenWidth,
                otpList: [],
                formKey: formKey, 
                passwordController: password,
                confirmPasswordController: confirmPass,
              ), // second page where you enter otp that will send on users email
            ],
          ),
        );
      },
    );
  }
}
