import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/router/app_router.dart';
import 'core/util/constants/app_colors.dart';
import 'data/repositories/categories_repository.dart';
import 'data/repositories/products_repository.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/shop/cubit/shop_cubit.dart';
import 'features/product/cubit/product_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/search/cubit/search_cubit.dart';
import 'features/wishlist/cubit/wishlist_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const FurniCraftApp());
}

class FurniCraftApp extends StatelessWidget {
  const FurniCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    final supabaseClient = Supabase.instance.client;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(
          create: (_) => HomeCubit(
            categoriesRepository: CategoriesRepository(client: supabaseClient),
            productsRepository: ProductsRepository(client: supabaseClient),
          )..loadHome(),
        ),
        BlocProvider(
          create: (_) => ShopCubit(
            productsRepository: ProductsRepository(client: supabaseClient),
          ),
        ),
        BlocProvider(
          create: (_) => SearchCubit(
            productsRepository: ProductsRepository(client: supabaseClient),
          ),
        ),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(
          create: (_) {
            final cubit = CartCubit(supabaseClient);
            if (supabaseClient.auth.currentUser != null) {
              cubit.loadFromSupabase();
            }
            return cubit;
          },
        ),
        BlocProvider(
          create: (_) {
            final cubit = WishlistCubit(supabaseClient);
            if (supabaseClient.auth.currentUser != null) {
              cubit.loadFromSupabase();
            }
            return cubit;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'FurniCraft',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            surface: AppColors.background,
          ),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
