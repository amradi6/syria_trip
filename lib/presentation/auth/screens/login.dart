import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/auth/auth_cubit.dart';
import 'package:syri_trip/logic/auth/auth_state.dart';
import 'package:syri_trip/presentation/auth/widgets/column_filed_for_login.dart';
import 'package:syri_trip/presentation/main/screens/show_company.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
              vertical: size.height * 0.087,
            ),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is LoginSuccess){
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text(
                         state.message,
                         textDirection: TextDirection.rtl,
                       ),
                       showCloseIcon: true,
                       closeIconColor: Colors.red,
                     ),
                   );
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowCompany(),));
                }
                else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'حدث خطأ: ${state.message}',
                        textDirection: TextDirection.rtl,
                      ),
                      showCloseIcon: true,
                      closeIconColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(children: [ColumnFiledForLogin(size: size)]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
