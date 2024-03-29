import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.isPasswordField = false,
    this.showHidePassword,
  });

  final TextEditingController controller;
  final String hintText;
  final String icon;
  final bool obscureText;
  final bool isPasswordField;
  final Function? showHidePassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset(
              icon,
              height: 12.0,
              width: 12.0,
            ),
          ),
          suffixIcon: isPasswordField
              ? InkWell(
                  onTap: () {
                    showHidePassword?.call();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(
                      obscureText
                          ? 'assets/images/hide.png'
                          : 'assets/images/visible.png',
                      height: 12.0,
                      width: 12.0,
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ),
      ),
    );
  }
}
