// lib/ripository/password_reset_repo.dart

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:tataguid/storage/token_storage.dart';

class ForgotPasswordRepository {
  static const String baseUrl = 'http://localhost:8080/auth';

  Future<void> sendPasswordResetLink(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sendpasswordlink'), // Replace with your endpoint

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 201) {
        // Success - handle success scenario (e.g., show success message)

        print('Password reset link sent successfully');
      } else {
        // Handle error (e.g., display error message based on response)

        final data = jsonDecode(response.body);

        throw Exception(data['message'] ??
            'Failed to send reset link'); // Use error message from backend if available
      }
    } catch (e) {
      throw Exception('Error sending password link: $e');
    }
  }

  Future<bool> verifyResetCode(
       String email, String verificationCode) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-reset-code'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'verificationCode': verificationCode,
        }),
      );
      // Print verificationCode before making the API call
      print('Verification code: $verificationCode');
      if (verificationCode.isEmpty) {
        print('Verification code is empty');

        throw Exception('Verification code is empty');
      }


      if (response.statusCode == 200) {
        // Success - verification code is valid
        print('Verification code is valid');
        return true;
      } else {
        final data = jsonDecode(response.body);
        print('Verification code error: ${data['message']}');
        throw Exception(data['message'] ?? 'Invalid verification code');
      }
    } catch (e) {
      print('Error verifying reset code: $e');

      rethrow; // Rethrow the exception for handling in the UI
    }
  }

 Future<void> changePassword(String email, String token, String oldPassword,
    String newPassword, {required Duration timeout}) async {
      print('email: $email');
      print('token $token');
      print('oldPassword: $oldPassword');
      print('newPassword: $newPassword');
  
    var res = await http.post(
      Uri.parse("$baseUrl/change-password/$email/$token"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    ).timeout(Duration(seconds: 10)); // Adjust timeout duration as needed

    print('Response status code: ${res.statusCode}'); // Debug logging

    if (res.statusCode == 200) {
    final data = json.decode(res.body);
    print('Response data: $data');
 if (data['message'] != null) {
      // Handle successful response
      print(data['message']); // Optional: Log or handle the message
      // Store the user type for later use
      await TokenStorage.storeUserType(data['userType']);
    } else {
      throw Exception('Failed to change password');
    }
  } else {
    throw Exception('Failed to change password');
  }

}
}
