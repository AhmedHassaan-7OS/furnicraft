import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/constants/app_colors.dart';
import '../../../../../core/util/constants/app_text_styles.dart';
import '../../../cubit/auth_cubit.dart';

class SignupFullNameField extends StatelessWidget {
  const SignupFullNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: context.read<AuthCubit>().onFullNameChanged,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        labelText: 'Full Name',
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: const Icon(Icons.person_outline_rounded,
            color: AppColors.textSecondary),
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
