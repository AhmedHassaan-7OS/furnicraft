import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageUtils {
  static String? getImageUrl(String? path) {
    if (path == null || path.isEmpty) return null;

    if (path.startsWith('http')) {
      // ── Optimize Unsplash URLs to save data ────────────────────────
      if (path.contains('images.unsplash.com')) {
        // Remove existing q/w params and add optimized ones
        final cleanUrl = path.split('?')[0];
        return '$cleanUrl?auto=format&fit=crop&q=70&w=600';
      }
      return path;
    }

    // ── Assuming Supabase Storage public URL ────────────────────────
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    if (supabaseUrl == null) return path;

    final cleanUrl = supabaseUrl.endsWith('/')
        ? supabaseUrl.substring(0, supabaseUrl.length - 1)
        : supabaseUrl;

    // Default to 'products' bucket
    return '$cleanUrl/storage/v1/object/public/products/$path';
  }
}
