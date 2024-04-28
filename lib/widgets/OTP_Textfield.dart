// lib/widgets/OTP_Textfield.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget otp(
  BuildContext context,
  double screenWidth,
  List<String> otplist,
  GlobalKey<FormState> formKey,
  TextEditingController verificationCodeController,
) {
  List<TextEditingController> controllers =
      List.generate(6, (i) => TextEditingController());

  return Form(
    key: formKey,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 0; i < 6; i++)
          SizedBox(
            width: screenWidth * 0.12,
            child: TextFormField(
              controller: controllers[i],
              onChanged: (value) {
                if (value.length <= 1) {
                  // Handle backspace/deletion
                  if (i > 0 && value.isEmpty) {
                    FocusScope.of(context).previousFocus();
                  }
                }
                if (value.isNotEmpty) {
                  FocusScope.of(context).nextFocus();
                  String currentCode = controllers
                      .map((controller) => controller.text)
                      .join('');
                  verificationCodeController.text = currentCode;
                  if (currentCode.length == 7) {
                    // Optional: Handle full code entered (e.g., focus out)
                    FocusScope.of(context).unfocus();
                  }
                }
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: Theme.of(context).textTheme.titleLarge,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a digit';
                }
                return null;
              },
            ),
          ),
      ],
    ),
  );
}
