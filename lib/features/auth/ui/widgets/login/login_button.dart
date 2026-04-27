import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/util/constants/app_colors.dart';
import '../../../../../core/util/constants/app_spacing.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../../../core/router/app_router.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (_, curr) => curr is AuthSuccess || curr is AuthFailure,
      listener: (context, state) {
        if (state is AuthSuccess) context.go(AppRoutes.home);
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      buildWhen: (_, curr) => curr is AuthLoading || curr is AuthInitial,
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              ),
            ),
            onPressed: isLoading
                ? null
                : () => context.read<AuthCubit>().login(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
            child: isLoading
                ? const CircularProgressIndicator(color: AppColors.white)
                : Text('Login', style: AppTextStyles.button),
          ),
        );
      },
    );
  }
}
