import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../widgets/login/login_logo.dart';
import '../widgets/login/login_email_field.dart';
import '../widgets/login/login_password_field.dart';
import '../widgets/login/login_forgot_password.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/login_divider.dart';
import '../widgets/login/login_social_button.dart';
import '../widgets/login/login_signup_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const LoginLogo(),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginEmailField(controller: _emailController),
                    const SizedBox(height: AppSpacing.md),
                    LoginPasswordField(controller: _passwordController),
                    const SizedBox(height: AppSpacing.sm),
                    const LoginForgotPassword(),
                    const SizedBox(height: AppSpacing.md),
                    LoginButton(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const LoginDivider(),
                    const SizedBox(height: AppSpacing.md),
                    LoginSocialButton(
                      label: 'Login with Google',
                      icon: Icons.g_mobiledata,
                      iconColor: Colors.red,
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    LoginSocialButton(
                      label: 'Login with Apple',
                      icon: Icons.apple,
                      iconColor: AppColors.black,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const LoginSignUpLink(),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
