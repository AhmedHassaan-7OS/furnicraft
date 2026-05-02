import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants/app_colors.dart';
import '../../cubit/product_cubit.dart';
import '../sections/product_images_section.dart';
import '../sections/product_info_section.dart';
import '../sections/product_actions_section.dart';
import '../../../../data/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProduct(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          ProductImagesSection(),
          ProductInfoSection(),
          ProductActionsSection(),
        ],
      ),
    );
  }
}
