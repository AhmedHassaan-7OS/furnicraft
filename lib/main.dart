import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/util/constants/app_colors.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/shop/cubit/shop_cubit.dart';
import 'features/product/cubit/product_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';

void main() {
  runApp(const FurniCraftApp());
}

class FurniCraftApp extends StatelessWidget {
  const FurniCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => HomeCubit()..loadHome()),
        BlocProvider(create: (_) => ShopCubit()),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: MaterialApp.router(
        title: 'FurniCraft',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            background: AppColors.background,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
