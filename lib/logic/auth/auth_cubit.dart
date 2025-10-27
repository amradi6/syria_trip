import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/auth/auth_state.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  TextEditingController get name => _name;

  TextEditingController get email => _email;

  TextEditingController get password => _password;

  TextEditingController get phoneNumber => _phoneNumber;

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      emit(SignupLoading());
      final uri = Uri.parse("http://10.0.2.2:8080/auth/signup");
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "name": name,
          "phoneNumber": phone,
        }),
      );
      if (response.statusCode == 200) {
        emit(SignupSuccess(response.body));
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String errorMessage = data['message'] ?? "حدث خطأ غير معروف";
        emit(SignupError(errorMessage));
      }
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}
