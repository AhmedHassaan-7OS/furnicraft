import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../../../core/util/constants/app_spacing.dart';
import '../../../../core/util/constants/app_text_styles.dart';
import '../../cubit/cart_cubit.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final double total;

  const CheckoutBottomSheet({super.key, required this.total});

  @override
  State<CheckoutBottomSheet> createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  int _selectedPayment = 0;
  int _selectedDelivery = 0;

  final List<_PaymentOption> _payments = const [
    _PaymentOption(icon: Icons.credit_card_rounded, label: 'Credit Card'),
    _PaymentOption(icon: Icons.account_balance_rounded, label: 'Bank Transfer'),
    _PaymentOption(icon: Icons.money_rounded, label: 'Cash on Delivery'),
  ];

  final List<_DeliveryOption> _deliveries = const [
    _DeliveryOption(label: 'Standard', days: '3-5 days', price: 0),
    _DeliveryOption(label: 'Express', days: '1-2 days', price: 9.99),
  ];

  double get deliveryFee => _deliveries[_selectedDelivery].price;
  double get grandTotal => widget.total + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        top: AppSpacing.md,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text('Checkout', style: AppTextStyles.headingMedium),
            const SizedBox(height: AppSpacing.xl),

            // ── Delivery Options ──────────────────────────────────
            Text('Delivery', style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            )),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: List.generate(_deliveries.length, (i) {
                final opt = _deliveries[i];
                final selected = _selectedDelivery == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedDelivery = i),
                    child: Container(
                      margin: EdgeInsets.only(right: i == 0 ? AppSpacing.sm : 0),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? AppColors.primary : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(opt.label,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                              )),
                          Text(opt.days,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              )),
                          Text(
                            opt.price == 0
                                ? 'Free'
                                : '\$${opt.price.toStringAsFixed(2)}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.xl),

            // ── Payment Options ───────────────────────────────────
            Text('Payment Method', style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            )),
            const SizedBox(height: AppSpacing.sm),
            ...List.generate(_payments.length, (i) {
              final opt = _payments[i];
              final selected = _selectedPayment == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedPayment = i),
                child: Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary.withOpacity(0.1)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? AppColors.primary : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(opt.icon,
                          color: selected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 22),
                      const SizedBox(width: AppSpacing.md),
                      Text(opt.label, style: AppTextStyles.bodyMedium),
                      const Spacer(),
                      if (selected)
                        const Icon(Icons.check_circle_rounded,
                            color: AppColors.primary, size: 20),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: AppSpacing.xl),

            // ── Order Summary ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _SummaryRow(label: 'Subtotal',
                      value: '\$${widget.total.toStringAsFixed(2)}'),
                  const SizedBox(height: AppSpacing.xs),
                  _SummaryRow(
                    label: 'Delivery',
                    value: deliveryFee == 0
                        ? 'Free'
                        : '\$${deliveryFee.toStringAsFixed(2)}',
                  ),
                  const Divider(height: AppSpacing.lg),
                  _SummaryRow(
                    label: 'Total',
                    value: '\$${grandTotal.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // ── Place Order Button ────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق الشيت
                  context.read<CartCubit>().checkout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Place Order  •  \$${grandTotal.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)
        : AppTextStyles.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value,
            style: style.copyWith(
              color: isBold ? AppColors.primary : AppColors.textPrimary,
            )),
      ],
    );
  }
}

class _PaymentOption {
  final IconData icon;
  final String label;
  const _PaymentOption({required this.icon, required this.label});
}

class _DeliveryOption {
  final String label;
  final String days;
  final double price;
  const _DeliveryOption(
      {required this.label, required this.days, required this.price});
}
