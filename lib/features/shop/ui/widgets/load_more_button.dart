import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_text_styles.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Disabled load more for now as it's not implemented in the new repository pattern
    return const SizedBox.shrink();
  }
}
