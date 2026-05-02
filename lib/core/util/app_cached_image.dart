import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'image_utils.dart';

/// Shared image widget — pass [url] as a raw string (e.g. from Supabase).
/// Uses CachedNetworkImage so the same asset is never downloaded twice.
/// Provide [width] / [height] to avoid layout thrash.
class AppCachedImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AppCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final formattedUrl = ImageUtils.getImageUrl(url);

    // ── empty / null URL → placeholder immediately, no network call
    if (formattedUrl == null || formattedUrl.isEmpty) {
      return _Placeholder(width: width, height: height);
    }

    // Key is the URL so Flutter reuses the cached element instead of
    // re-building from scratch on every parent rebuild.
    Widget child = CachedNetworkImage(
      key: ValueKey(formattedUrl),
      imageUrl: formattedUrl,
      width: width,
      height: height,
      fit: fit,
      // ── use const-friendly widget builders, not inline lambdas
      placeholder: (_, __) => _Placeholder(width: width, height: height),
      errorWidget: (_, __, ___) => _ErrorPlaceholder(width: width, height: height),
      // Fade in smoothly on first load only
      fadeInDuration: const Duration(milliseconds: 250),
      fadeOutDuration: Duration.zero,
    );

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }
}

// ── Internal stateless placeholders (const-safe, no rebuilds) ────────────

class _Placeholder extends StatelessWidget {
  final double? width;
  final double? height;

  const _Placeholder({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surface,
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;

  const _ErrorPlaceholder({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surface,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }
}
