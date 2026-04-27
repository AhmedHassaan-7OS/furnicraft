import 'package:flutter/material.dart';
import '../../../../../core/util/constants/app_text_styles.dart';

class LoginForgotPassword extends StatelessWidget {
  const LoginForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: Text('Forgot Password?', style: AppTextStyles.link),
      ),
    );
  }
}
