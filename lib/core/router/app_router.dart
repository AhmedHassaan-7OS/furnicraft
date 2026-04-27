import 'package:go_router/go_router.dart';
import '../../features/auth/ui/screens/welcome_screen.dart';
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/home/ui/screens/home_screen.dart';
import '../../features/shop/ui/screens/category_screen.dart';
import '../../features/product/ui/screens/product_details_screen.dart';
import '../../features/cart/ui/screens/cart_screen.dart';

abstract class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String category = '/category';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.category,
      builder: (context, state) {
        final categoryName = state.extra as String? ?? 'Living Room';
        return CategoryScreen(categoryName: categoryName);
      },
    ),
    GoRoute(
      path: AppRoutes.productDetails,
      builder: (context, state) => const ProductDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.cart,
      builder: (context, state) => const CartScreen(),
    ),
  ],
);
