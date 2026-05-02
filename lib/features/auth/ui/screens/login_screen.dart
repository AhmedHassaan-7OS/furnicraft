import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnicraft/features/cart/cubit/cart_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
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
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';
import '../../../wishlist/cubit/wishlist_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                // ── Back button ──────────────────────────────────────
                GestureDetector(
                  onTap: () => context.go(AppRoutes.welcome),
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

                // ── Existing login widgets (keep ALL of them) ─────────
                const LoginLogo(),
                const SizedBox(height: AppSpacing.xl),
                const LoginEmailField(),
                const SizedBox(height: AppSpacing.md),
                const LoginPasswordField(),
                const SizedBox(height: AppSpacing.sm),
                const LoginForgotPassword(),
                const SizedBox(height: AppSpacing.lg),
                const LoginButton(),
                const SizedBox(height: AppSpacing.md),
                const LoginDivider(),
                const SizedBox(height: AppSpacing.md),
                LoginSocialButton(
                  label: 'Continue with Google',
                  icon: Icons.g_mobiledata,
                  iconColor: Colors.blue,
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.lg),
                const LoginSignupLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
