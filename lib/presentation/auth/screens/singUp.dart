import 'package:flutter/material.dart';
import 'package:syri_trip/presentation/auth/widgets/auth_toggle_button.dart';
import 'package:syri_trip/presentation/auth/widgets/column_filed_for_auth.dart';
import 'package:syri_trip/presentation/auth/widgets/input_filed_for_auth.dart';
import 'package:syri_trip/presentation/auth/widgets/label_for_auth.dart';

class SingUp extends StatelessWidget {
  const SingUp({super.key});

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
                ElevatedButton(
                  onPressed: () {},
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
