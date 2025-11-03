import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/auth/auth_state.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final TextEditingController _name = TextEditingController();

  final TextEditingController _emailForSignup = TextEditingController();

  final TextEditingController _passwordForSignup = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _emailForLogin = TextEditingController();

  final TextEditingController _passwordForLogin = TextEditingController();

  bool isHidden = false;

  bool isHidden1 = false;

  TextEditingController get name => _name;

  TextEditingController get email => _emailForSignup;

  TextEditingController get password => _passwordForSignup;

  TextEditingController get phoneNumber => _phoneNumber;

  TextEditingController get emailForLogin => _emailForLogin;

  TextEditingController get passwordForLogin => _passwordForLogin;

  bool get isHiddenForSignup => isHidden;

  bool get isHiddenForLogin => isHidden1;

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

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      final url = Uri.parse("http://10.0.2.2:8080/auth/login");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (response.statusCode == 200) {
        emit(LoginSuccess(response.body));
      } else {
        emit(LoginError(response.body));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  void togglePasswordVisibilityForSignup() {
    isHidden = !isHidden;
    emit(PasswordVisibilityChangedForSignup(isHidden));
  }

  void togglePasswordVisibilityForLogin() {
    isHidden1 = !isHidden1;
    emit(PasswordVisibilityChangedForSignup(isHidden1));
  }
}
