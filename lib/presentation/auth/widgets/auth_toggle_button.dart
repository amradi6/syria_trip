import 'package:flutter/material.dart';

class AuthToggleButton extends StatefulWidget {
  const AuthToggleButton({super.key});

  @override
  State<AuthToggleButton> createState() => _AuthToggleButtonState();
}

class _AuthToggleButtonState extends State<AuthToggleButton> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.041),
      child: Container(
        height: size.height * 0.043,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontWeight: _selectedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'اشتراك',
                      style: TextStyle(
                        fontWeight: _selectedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
