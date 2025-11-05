import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  String nameForShow = "";

  int? userId;

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
    final prefs = await SharedPreferences.getInstance();
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
      final data = jsonDecode(response.body);
      String message = data['message'];

      if (response.statusCode == 200) {
        final user = data['user'];
        userId = user['id'];
        nameForShow = user['name'];
        await prefs.setInt('userId', userId!);
        await prefs.setString('nameForShow', nameForShow);
        emit(SignupSuccess(message));
      } else {
        emit(SignupError(message));
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
      final data = jsonDecode(response.body);
      final String message = data['message'];
      if (response.statusCode == 200) {
        emit(LoginSuccess(message));
      } else {
        emit(LoginError(message));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    nameForShow = prefs.getString('nameForShow') ?? "";
    return nameForShow;
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
