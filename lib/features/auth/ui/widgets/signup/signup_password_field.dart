import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/constants/app_colors.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../cubit/auth_cubit.dart';

class SignupPasswordField extends StatefulWidget {
  const SignupPasswordField({super.key});

  @override
  State<SignupPasswordField> createState() => _SignupPasswordFieldState();
}

class _SignupPasswordFieldState extends State<SignupPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: context.read<AuthCubit>().onPasswordChanged,
      obscureText: _obscure,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: const Icon(Icons.lock_outline_rounded,
            color: AppColors.textSecondary),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obscure = !_obscure),
          child: Icon(
            _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.textSecondary,
          ),
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
