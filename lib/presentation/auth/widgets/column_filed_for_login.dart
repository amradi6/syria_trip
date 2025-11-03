import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/auth/auth_cubit.dart';
import 'package:syri_trip/logic/auth/auth_state.dart';
import 'package:syri_trip/presentation/auth/widgets/auth_toggle_button.dart';
import 'package:syri_trip/presentation/auth/widgets/input_filed_for_auth.dart';
import 'package:syri_trip/presentation/auth/widgets/label_for_auth.dart';

class ColumnFiledForLogin extends StatelessWidget {
  const ColumnFiledForLogin({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "اهلا وسهلا بعودتك",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: size.height * 0.0218),
        const Text(
          "يمكنك الاشتراك اذا قمت فعلا بتسجيل الدخول",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: size.height * 0.0218),
        AuthToggleButton(selectedIndex: 1),

        Padding(
          padding: EdgeInsets.only(top: size.height * 0.0546),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: size.height * 0.027),
              LabelForAuth(size: size, text: "الايميل"),
              SizedBox(height: size.height * 0.01093),
              InputFiledForAuth(
                controller: context.read<AuthCubit>().emailForLogin,
                text: "الرجاء ادخال الايميل",
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.ltr,
              ),

              SizedBox(height: size.height * 0.05),
              LabelForAuth(size: size, text: "كلمة السر"),
              SizedBox(height: size.height * 0.01093),
              InputFiledForAuth(
                controller: context.read<AuthCubit>().passwordForLogin,
                text: "الرجاء ادخال كلمة السر",
                keyboardType: TextInputType.visiblePassword,
                isHidden: context.read<AuthCubit>().isHiddenForLogin,
                iconButton: IconButton(
                  onPressed: () {
                    context
                        .read<AuthCubit>()
                        .togglePasswordVisibilityForLogin();
                  },
                  icon: context.read<AuthCubit>().isHiddenForLogin
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.08),

        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return LinearProgressIndicator();
            }
            return ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().login(
                  email: context.read<AuthCubit>().emailForLogin.text,
                  password: context.read<AuthCubit>().passwordForLogin.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                elevation: 5,
                fixedSize: Size(size.height * 0.32811, size.width * 0.12156),
              ),
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            );
          },
        ),
      ],
    );
  }
}
