import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/auth/auth_cubit.dart';
import 'package:syri_trip/logic/auth/auth_state.dart';
import 'package:syri_trip/presentation/auth/widgets/input_filed_for_auth.dart';
import 'package:syri_trip/presentation/auth/widgets/label_for_auth.dart';

class ColumnFiledForAuth extends StatelessWidget {
  const ColumnFiledForAuth({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            LabelForAuth(size: size, text: "الاسم الكامل"),
            SizedBox(height: size.height * 0.01093),
            InputFiledForAuth(
              controller: context.read<AuthCubit>().name,
              text: "الرجاء ادخال الاسم بالعربية",
              keyboardType: TextInputType.text,
              textDirection: TextDirection.rtl,
            ),

            SizedBox(height: size.height * 0.04),
            LabelForAuth(size: size, text: "الايميل"),
            SizedBox(height: size.height * 0.01093),
            InputFiledForAuth(
              controller: context.read<AuthCubit>().email,
              text: "الرجاء ادخال الايميل",
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
            ),

            SizedBox(height: size.height * 0.04),
            LabelForAuth(size: size, text: "رقم الهاتف"),
            SizedBox(height: size.height * 0.01093),
            InputFiledForAuth(
              controller: context.read<AuthCubit>().phoneNumber,
              text: "الرجاء ادخال رقم هاتفك",
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
            ),

            SizedBox(height: size.height * 0.04),
            LabelForAuth(size: size, text: "كلمة السر"),
            SizedBox(height: size.height * 0.01093),
            InputFiledForAuth(
              controller: context.read<AuthCubit>().password,
              text: "الرجاء ادخال كلمة السر",
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              iconButton: IconButton(
                onPressed: () {},
                icon: Icon(Icons.remove_red_eye),
              ),
            ),
          ],
        );
      },
    );
  }
}
