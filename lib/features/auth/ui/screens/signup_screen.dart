import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnicraft/features/cart/cubit/cart_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../widgets/login/login_logo.dart';
import '../widgets/signup/signup_button.dart';
import '../widgets/signup/signup_confirm_password_field.dart';
import '../widgets/signup/signup_email_field.dart';
import '../widgets/signup/signup_full_name_field.dart';
import '../widgets/signup/signup_password_field.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';
import '../../../wishlist/cubit/wishlist_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, FurniAuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.read<WishlistCubit>().loadFromSupabase();
          context.read<CartCubit>().loadFromSupabase();
          context.go(AppRoutes.home);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => context.go(AppRoutes.login),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                const LoginLogo(),
                const SizedBox(height: AppSpacing.sm),

                Text('Create Account', style: AppTextStyles.headingLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Fill in your details to get started',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                const SignupFullNameField(),
                const SizedBox(height: AppSpacing.md),
                const SignupEmailField(),
                const SizedBox(height: AppSpacing.md),
                const SignupPasswordField(),
                const SizedBox(height: AppSpacing.md),
                const SignupConfirmPasswordField(),
                const SizedBox(height: AppSpacing.xl),

                const SignupButton(),
                const SizedBox(height: AppSpacing.lg),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.login),
                      child: Text(
                        'Sign In',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
