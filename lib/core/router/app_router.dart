import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// feature screens
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/auth/ui/screens/signup_screen.dart';
import '../../features/auth/ui/screens/welcome_screen.dart';
import '../../features/home/ui/screens/home_screen.dart';
import '../../features/cart/ui/screens/cart_screen.dart';
import '../../features/product/ui/screens/product_details_screen.dart';
import '../../features/profile/ui/screens/profile_screen.dart';
import '../../features/shop/ui/screens/category_screen.dart';
import '../../features/wishlist/ui/screens/wishlist_screen.dart';
import '../../data/models/product_model.dart';

abstract class AppRoutes {
  static const welcome = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const cart = '/cart';
  static const profile = '/profile';
  static const productDetails = '/product-details';
  static const category = '/category';
  static const wishlist = '/wishlist';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (_, __) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (_, __) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (_, __) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.productDetails,
        builder: (context, state) {
          final product = state.extra;
          // Guard: لو extra فاضي (deep link أو خطأ) ارجع للهوم
          if (product == null || product is! ProductModel) {
            return const Scaffold(
              body: Center(
                child: Text('Product not found', style: TextStyle(fontSize: 16)),
              ),
            );
          }
          return ProductDetailsScreen(product: product);
        },
      ),
      GoRoute(
        path: AppRoutes.category,
        builder: (context, state) {
          final categoryName = state.extra as String;
          return CategoryScreen(categoryName: categoryName);
        },
      ),
      GoRoute(
        path: AppRoutes.wishlist,
        builder: (_, __) => const WishlistScreen(),
      ),
    ],
  );
}
