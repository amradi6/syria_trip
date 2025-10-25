import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/auth/auth_cubit.dart';
import 'package:syri_trip/logic/auth/auth_state.dart';
import 'package:syri_trip/presentation/auth/widgets/auth_toggle_button.dart';
import 'package:syri_trip/presentation/auth/widgets/column_filed_for_auth.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.036,
              vertical: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.directions_bus_rounded,
                  size: 80,
                  color: Colors.blue,
                ),
                SizedBox(height: size.height * 0.010),
                const Text(
                  "اهلا وسهلا بك في تطبيق رحلات سوريا",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.0054),
                const Text(
                  "هذا التطبيق هو بوابتك لحجز الرحل بسهولة",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: size.height * 0.0218),
                const AuthToggleButton(),
                SizedBox(height: size.height * 0.027),
                ColumnFiledForAuth(size: size),
                SizedBox(height: size.height * 0.032),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if(state is SignupSuccess){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إنشاء الحساب بنجاح 🎉')),
                      );
                    } else if (state is SignupError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('حدث خطأ: ${state.message}')),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SignupLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blueAccent),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        context.read<AuthCubit>().signup(
                          email: context.read<AuthCubit>().email.text,
                          password: context.read<AuthCubit>().password.text,
                          name: context.read<AuthCubit>().name.text,
                          phone: context.read<AuthCubit>().phoneNumber.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        elevation: 5,
                        fixedSize: Size(
                          size.height * 0.32811,
                          size.width * 0.12156,
                        ),
                      ),
                      child: Text(
                        "انشئ حسابك ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
