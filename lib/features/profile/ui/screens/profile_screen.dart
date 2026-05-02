import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSignedOut) {
            context.go(AppRoutes.welcome);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text('Profile', style: AppTextStyles.headingMedium),
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                final email = state.user.email ?? 'No email';
                final name =
                    state.user.userMetadata?['full_name'] as String? ??
                        'FurniCraft User';
                final initials = name
                    .split(' ')
                    .take(2)
                    .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
                    .join();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.xl),

                      // Avatar
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          initials,
                          style: AppTextStyles.headingLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      Text(name, style: AppTextStyles.headingMedium),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        email,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // Profile menu items
                      _ProfileTile(
                        icon: Icons.shopping_bag_outlined,
                        label: 'My Orders',
                        onTap: () {},
                      ),
                      _ProfileTile(
                        icon: Icons.favorite_outline_rounded,
                        label: 'Wishlist',
                        onTap: () => context.push(AppRoutes.wishlist),
                      ),
                      _ProfileTile(
                        icon: Icons.location_on_outlined,
                        label: 'Addresses',
                        onTap: () {},
                      ),
                      _ProfileTile(
                        icon: Icons.notifications_none_rounded,
                        label: 'Notifications',
                        onTap: () {},
                      ),
                      _ProfileTile(
                        icon: Icons.help_outline_rounded,
                        label: 'Help & Support',
                        onTap: () {},
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Sign out
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              context.read<ProfileCubit>().signOut(),
                          icon: const Icon(Icons.logout_rounded,
                              color: AppColors.error),
                          label: Text(
                            'Sign Out',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.error),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Not signed in
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.person_off_outlined,
                        size: 64, color: AppColors.textSecondary),
                    const SizedBox(height: AppSpacing.md),
                    Text('Not signed in',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        )),
                    const SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.textPrimary),
        title: Text(label, style: AppTextStyles.bodyMedium),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
