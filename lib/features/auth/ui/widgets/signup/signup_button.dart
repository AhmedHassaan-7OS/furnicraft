import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/constants/app_colors.dart';
import '../../../../../core/util/constants/app_spacing.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, FurniAuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed:
                isLoading ? null : context.read<AuthCubit>().signUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Create Account',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
