import 'package:flutter/material.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';

class CartPriceSummary extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double total;

  const CartPriceSummary({
    super.key,
    this.subtotal = 0.0,
    this.shipping = 0.0,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        children: [
          if (subtotal > 0) ...[
            _SummaryRow(
              label: 'Subtotal',
              value: '\$${subtotal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (shipping > 0) ...[
            _SummaryRow(
              label: 'Shipping',
              value: '\$${shipping.toStringAsFixed(2)}',
            ),
          ],
          if (subtotal > 0 || shipping > 0)
            const Divider(color: AppColors.divider, height: AppSpacing.lg),
          _SummaryRow(
            label: 'Total',
            value: '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal ? AppTextStyles.h3 : AppTextStyles.bodySecondary,
        ),
        Text(
          value,
          style: isTotal ? AppTextStyles.priceXl : AppTextStyles.body,
        ),
      ],
    );
  }
}
